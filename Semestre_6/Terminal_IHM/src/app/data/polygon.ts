import { DrawingConfig, drawingConfigSchema } from "./drawingConfig";
import { Point, pointsArraySchema } from "./point";
import { z } from "zod";

/**
 * Définit un polygone immuable
 */
export type PolygonState = "drawing" | "finished";
export interface Polygon<T extends PolygonState> extends DrawingConfig {
    readonly id: number;
    readonly state: T;
    readonly points: readonly Point[];
}

/**
 * Définit un polygone dont l'état et les points sont mutables
 * à utiliser lorsque le polygone est en cours de construction.
 */
export interface MutablePolygon extends Omit<Polygon<PolygonState>, 'id'> {
    readonly id: number;
    state: PolygonState;        // L'état peut être modifié
    readonly points: Point[];   // Le tableau de points est mutable
}

/**
 * Fonction de création d'un polygone mutable
 *   avec un id unique généré automatiquement. 
 * La fonction vérifie que les données du polygone sont valides avant de le créer,
 *   elle rejette la promesse avec une erreur de validation si ça n'est pas le cas.
 * @param params Les paramètres du polygone à créer, à l'exception de l'id et de l'état qui sont générés automatiquement
 * @returns Une promesse qui résout un polygone mutable si les données sont valides,
 *          ou qui est rejetée avec une erreur de validation sinon.
 */
let polygonIdCounter = 0;
export function createMutablePolygon(params: Omit<MutablePolygon, 'id' | 'state'>): Promise<MutablePolygon> {
    const protoP: MutablePolygon = {
        id: polygonIdCounter++,
        state: 'drawing',
        ...params
    };
    console.log('Creating mutable polygon', protoP);
    return isValidMutablePolygonP(protoP);
}

/**
 * Fonction de transformation d'un polygone mutable en un polygone fini,
 * le tableau de points est recopié pour éviter les problèmes de mutabilité.
 * @param poly 
 * @returns 
 */
export function finishPolygon(poly: MutablePolygon): Polygon<'finished'> {
    return {
        ...poly,
        state: 'finished',
        points: [...poly.points]
    };
}

/**
 * Vérifie qu'un polygone est fini, c'est à dire que son état est "finished".
 * @param polys Le polygone à vérifier
 * @returns true si le polygone est fini, false sinon
 *          Si la fonction renvoie vrai, alors le polygone passé en paramètre
 *          est considéré par le compilateur comme un polygone fini.
 */
export function isFinishedPolygon(polys: Polygon<PolygonState>): polys is Polygon<'finished'> {
    return polys.state === 'finished';
}

/**
 * Schémas ZOD et fonctions de validation pour les polygones
 */
const polygonSchema = drawingConfigSchema.extend({
    id: z.number(),
    state: z.enum(['drawing', 'finished']),
    points: pointsArraySchema,
    
});

function isValidMutablePolygonP(data: unknown): Promise<MutablePolygon> {
    return polygonSchema.parseAsync(data);
}
