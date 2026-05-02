import * as functions from "firebase-functions";
import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { ExerciseAssignmentService } from "./services/ExerciseAssignmentService";

admin.initializeApp();

const db = admin.firestore();

/**
 * Triggered when a new user is created in Firebase Auth.
 * Initializes the user document in Firestore.
 */
export const onUserCreated = functions.auth.user().onCreate(async (user) => {
    const { uid, email, displayName } = user;

    const userDoc = {
        id: uid,
        name: displayName || "",
        email: email || "",
        isBanned: false,
        progress: {
            hasCompletedWelcome: false,
            hasCompletedRedFlags: false,
            hasCompletedBodyMap: false,
            hasCompletedPainScore: false,
            hasCompletedScheduling: false,
            isClearedForExercise: false,
        },
        painRegions: [],
        backlogRegions: [],
        completedExerciseIds: [],
        currentStreak: 0,
        totalWorkouts: 0,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        lastActiveAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    try {
        await db.collection("users").doc(uid).set(userDoc, { merge: true });
        console.log(`User document created for ${uid}`);
    } catch (error) {
        console.error(`Error creating user document for ${uid}:`, error);
    }
});

/**
 * Callable function to assign the initial exercise program based on triage.
 */
export const assignInitialExerciseProgram = onCall(async (request) => {
    const userId = request.auth?.uid;
    if (!userId) {
        throw new HttpsError("unauthenticated", "User must be authenticated.");
    }

    try {
        const assignmentService = new ExerciseAssignmentService();
        await assignmentService.assignProgram(userId);
        return { success: true, message: "Program assigned successfully." };
    } catch (error: any) {
        console.error(`Error assigning program for ${userId}:`, error);
        throw new HttpsError("internal", error.message || "Internal server error.");
    }
});

/**
 * Triggered when a user document in Firestore is updated.
 * Performs Clinical Decision Support System (CDSS) safety checks.
 */
export const onUserDocumentUpdated = functions.firestore
    .document("users/{userId}")
    .onUpdate(async (change, context) => {
        const newData = change.after.data();
        const previousData = change.before.data();

        // Avoid infinite loops
        if (newData.isBanned && !previousData.isBanned) return; 
        if (newData.isBanned && previousData.isBanned && newData.banReason === previousData.banReason) return;

        const userId = context.params.userId;
        let banReason: string | null = null;

        // --- CDSS LOGIC START ---

        // 1. Red Flag Control
        if (newData.progress?.hasCompletedRedFlags && !newData.progress?.isClearedForExercise) {
            banReason = "redFlag";
        }

        // 2. Extreme Pain Control (NPRS >= 10)
        if (!banReason && newData.painRegions && Array.isArray(newData.painRegions)) {
            const hasExtremePain = newData.painRegions.some((r: any) => r.nprsScore >= 10);
            if (hasExtremePain) banReason = "extremePain";
        }

        // 3. Central Sensitization Control
        if (!banReason && newData.painRegions && Array.isArray(newData.painRegions) && newData.painRegions.length >= 4) {
            const highPainRegions = newData.painRegions.filter((r: any) => r.nprsScore >= 8).length;
            if (highPainRegions >= 3) banReason = "centralSensitization";
        }

        // 4. Max Flare-Up Strike (3 or more flare-ups in the same region)
        if (!banReason && newData.painRegions && Array.isArray(newData.painRegions)) {
            const hasMaxFlareUps = newData.painRegions.some((r: any) => r.flareUpCount >= 3);
            if (hasMaxFlareUps) banReason = "maxFlareUpStrike";
        }

        // 5. Therapeutic Resistance (Score increase in macro assessments)
        if (!banReason && newData.painRegions && Array.isArray(newData.painRegions)) {
            for (const region of newData.painRegions) {
                if (region.scoreHistory && Array.isArray(region.scoreHistory) && region.scoreHistory.length >= 2) {
                    const lastScore = region.scoreHistory[region.scoreHistory.length - 1];
                    const previousScore = region.scoreHistory[region.scoreHistory.length - 2];
                    if (lastScore > previousScore) {
                        banReason = "therapeuticResistance";
                        break;
                    }
                }
            }
        }

        // --- CDSS LOGIC END ---

        if (banReason) {
            console.log(`User ${userId} blocked due to: ${banReason}`);
            await change.after.ref.update({
                isBanned: true,
                banReason: banReason,
                banNote: `Automatically banned by CDSS Cloud Function: ${banReason}`,
                updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
        }
    });
