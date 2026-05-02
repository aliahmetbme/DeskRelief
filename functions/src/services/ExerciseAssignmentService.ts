import * as admin from "firebase-admin";
import { UserModel, ExerciseModel, RegionDetail, PainRegionId, CurrentProgram, ExerciseReference } from "../models/types";
import { ClinicalRules } from "./ClinicalRules";

export class ExerciseAssignmentService {
    private db = admin.firestore();

    async assignProgram(userId: string): Promise<void> {
        const userRef = this.db.collection("users").doc(userId);
        const userSnap = await userRef.get();

        if (!userSnap.exists) {
            throw new Error(`User ${userId} not found`);
        }

        const userData = userSnap.data() as UserModel;
        const painRegions = userData.painRegions || [];

        if (painRegions.length === 0) {
            console.log(`User ${userId} has no pain regions selected.`);
            return;
        }

        // A. Triage & Region Isolation
        const assignedRegions = this.triageRegions(painRegions);
        
        // Determine the dominant NPRS score (max among assigned)
        const maxNprs = Math.max(...assignedRegions.map(r => r.nprsScore));
        const zone = ClinicalRules.getZone(maxNprs);
        const poolCounts = ClinicalRules.POOLS[zone].counts;

        // B. Fetch Exercises
        const exercises = await this.fetchEligibleExercises(assignedRegions.map(r => r.regionId));

        // C. Build Session (Selection Logic)
        const dailyExercises = this.selectExercises(exercises, poolCounts);

        // D. Update currentProgram
        const program: CurrentProgram = {
            startDate: admin.firestore.FieldValue.serverTimestamp() as any,
            phase: 1,
            assignedRegions: assignedRegions.map(r => r.regionId),
            dailyExercises: dailyExercises,
            isMotorLearningPhase: true
        };

        await userRef.update({
            currentProgram: program,
            lastActiveAt: admin.firestore.FieldValue.serverTimestamp()
        });

        console.log(`Program successfully assigned to user ${userId} in ${zone} zone.`);
    }

    private triageRegions(regions: RegionDetail[]): RegionDetail[] {
        // Sort by NPRS score (desc), then by Clinical Priority, then FIFO (implicit in original order)
        const sorted = [...regions].sort((a, b) => {
            if (b.nprsScore !== a.nprsScore) {
                return b.nprsScore - a.nprsScore;
            }
            return ClinicalRules.getRegionPriority(a.regionId) - ClinicalRules.getRegionPriority(b.regionId);
        });

        // Pick top 2
        let topTwo = sorted.slice(0, 2);

        // Flare-Up Filter: If ΔNPRS >= 4, keep only the higher one
        if (topTwo.length === 2) {
            const diff = Math.abs(topTwo[0].nprsScore - topTwo[1].nprsScore);
            if (diff >= 4) {
                topTwo = [topTwo[0]];
            }
        }

        return topTwo;
    }

    private async fetchEligibleExercises(regionIds: PainRegionId[]): Promise<ExerciseModel[]> {
        const exercisesRef = this.db.collection("exercises");
        
        // Since we can't easily do "array-contains-any" for multiple regions effectively in some cases,
        // we'll fetch all exercises that target at least one of the regions.
        const query = await exercisesRef.where("targetRegions", "array-contains-any", regionIds).get();
        
        return query.docs.map(doc => ({ id: doc.id, ...doc.data() } as ExerciseModel));
    }

    private selectExercises(allExercises: ExerciseModel[], counts: { strength: number; rom: number; stretch: number }): ExerciseReference[] {
        const selected: ExerciseReference[] = [];

        const phases: (keyof typeof counts)[] = ["rom", "strength", "stretch"];
        
        for (const phase of phases) {
            const targetCount = counts[phase];
            if (targetCount === 0) continue;

            // Filter exercises by phase
            let pool = allExercises.filter(e => e.phase === phase);

            // Prioritize Joker exercises if multiple regions are assigned?
            // Actually, sorting by isJoker (desc) will put them first.
            pool.sort((a, b) => (b.isJoker ? 1 : 0) - (a.isJoker ? 1 : 0));

            // Take the required amount (randomize or take first)
            // For now, let's take first after prioritization. 
            // In real app, you might want more complex rotation.
            const taken = pool.slice(0, targetCount);

            taken.forEach(ex => {
                selected.push({
                    id: ex.id,
                    name: ex.name,
                    phase: ex.phase,
                    sets: ClinicalRules.BASE_SETS, // Initial phase is always baseSets (2)
                    reps: ex.recommendedReps,
                    holdTime: 0 // Default, can be refined
                });
            });
        }

        return selected;
    }
}
