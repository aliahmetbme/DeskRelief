import { Timestamp } from "firebase-admin/firestore";

export type PainRegionId = 
    | "neck" 
    | "leftShoulder" 
    | "rightShoulder" 
    | "upperBack" 
    | "lowerBack" 
    | "leftArm" 
    | "rightArm" 
    | "hip" 
    | "leftKnee" 
    | "rightKnee" 
    | "leftAnkle" 
    | "rightAnkle";

export type ExercisePhase = "rom" | "strength" | "stretch";

export interface RegionDetail {
    regionId: PainRegionId;
    nprsScore: number;
    flareUpCount: number;
    lastFlareUpDate?: Timestamp | Date;
    isAkut: boolean;
    scoreHistory: number[];
}

export interface ExerciseReference {
    id: string;
    name: string;
    phase: ExercisePhase;
    sets: number;
    reps: number;
    holdTime?: number; // In seconds
}

export interface CurrentProgram {
    startDate: Timestamp | Date;
    phase: number;
    assignedRegions: PainRegionId[];
    dailyExercises: ExerciseReference[];
    isMotorLearningPhase: boolean;
}

export interface UserModel {
    id: string;
    name: string;
    email: string;
    painRegions: RegionDetail[];
    backlogRegions: RegionDetail[];
    currentProgram?: CurrentProgram;
    registrationDate?: Timestamp | Date;
    // Add other fields as needed
}

export interface ExerciseModel {
    id: string;
    name: string;
    targetRegions: PainRegionId[];
    phase: ExercisePhase;
    recommendedSets: number;
    recommendedReps: number;
    isJoker: boolean;
    // Add other fields as needed
}
