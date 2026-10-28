import { concatWith, EMPTY, fromEvent, map, Observable, of, scan, switchMap, takeUntil } from "rxjs";
import { createMutablePolygon, finishPolygon, Polygon, PolygonState } from "./polygon";
import { eventToLocalPoint } from "./eventToCoord";
import { DrawingConfig } from "./drawingConfig";

/**
 * Construit un observable de polygones à partir d'un élément HTML et d'une configuration de dessin.
 * Pour construire un polygone :
 *   - Presser un bouton de la souris pour démarrer (crée un nouveau polygone)
 *   - bouger la souris pour définir le périmètre du polygone (modifie ce polygone)
 *   - relâcher le bouton de la souris pour terminer le polygone (passe le polygone à l'état "finished")
 */
export function drawPolygonFrom(canvas: HTMLElement, config: DrawingConfig): Observable<Polygon<PolygonState>> {
    console.log('Mise en place du dessin de polygone sur le canevas avec la configuration:', config);

    // Fonction utilitaires de conversion de coordonnées
    const toLocalPoint = (event: MouseEvent) => eventToLocalPoint(event, canvas);

    // Observables sources pour l'interaction avec la souris
    const fromMouseDown$ = fromEvent<MouseEvent>(canvas, 'mousedown').pipe( map(toLocalPoint) );
    const fromMouseMove$ = fromEvent<MouseEvent>(canvas, 'mousemove').pipe( map(toLocalPoint) );
    const fromMouseUp$   = fromEvent<MouseEvent>(canvas, 'mouseup'  ).pipe( map(toLocalPoint) );
    
    // B.1 et B.2 : Doit renvoyer un observable de polygones...
    return EMPTY;
}