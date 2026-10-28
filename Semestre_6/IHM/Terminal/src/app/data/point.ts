import { z } from "zod";

/**
 * Un point dans le plan 2D
 */
export interface Point {
    readonly x: number;
    readonly y: number;
}

/**
 * Vérifie que les données passées en argument sont un tableau de points valides,
 * sinon rejette la promesse avec une erreur de validation.
 * @param data La donnée à vérifier 
 * @returns Une promesse qui résout un tableau de points si les données sont valides,
 *          ou qui est rejetée avec une erreur de validation sinon.
 */
export function isPointArrayP(data: unknown): Promise<readonly Point[]> {
    return pointsArraySchema.parseAsync(data);
}


/**
 * Schémas ZOD
 */
export const pointSchema = z.object({
    x: z.number(),
    y: z.number()
});

export const pointsArraySchema = z.array(pointSchema);

