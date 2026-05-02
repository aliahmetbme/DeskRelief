import { PainRegionId } from "../models/types";

export const ClinicalRules = {
    // Phase 2: Triage Tie-Breaker Priority
    // Lower Back > Neck > Knee > Hip
    REGION_PRIORITY: [
        "lowerBack",
        "neck",
        "leftKnee",
        "rightKnee",
        "hip"
    ] as PainRegionId[],

    // Phase 3: Pool Counts
    POOLS: {
        GREEN: {
            minNprs: 1,
            maxNprs: 4,
            counts: {
                strength: 4,
                rom: 2,
                stretch: 2
            }
        },
        YELLOW: {
            minNprs: 5,
            maxNprs: 7,
            counts: {
                strength: 3,
                rom: 2,
                stretch: 1
            }
        },
        RED: {
            minNprs: 8,
            maxNprs: 10,
            counts: {
                strength: 0,
                rom: 2,
                stretch: 2 // ROM/Germe (2+2)
            }
        }
    },

    // Phase 3: Volume Management
    MOTOR_LEARNING_DAYS: 14,
    BASE_SETS: 2,
    PROGRESSED_SETS: 3,

    // Helper functions
    getZone(nprs: number) {
        if (nprs >= 8) return "RED";
        if (nprs >= 5) return "YELLOW";
        return "GREEN";
    },

    getRegionPriority(region: PainRegionId): number {
        const index = this.REGION_PRIORITY.indexOf(region);
        return index === -1 ? 999 : index;
    }
};
