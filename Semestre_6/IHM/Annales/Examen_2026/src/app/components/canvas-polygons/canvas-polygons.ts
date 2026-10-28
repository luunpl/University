import { Component, ElementRef, input, model, Signal, viewChild } from '@angular/core';
import { toObservable, toSignal } from '@angular/core/rxjs-interop';
import { drawPolygonFrom } from '@data/drawPolygonFrom';
import { isFinishedPolygon, Polygon, PolygonState } from '@data/polygon';
import { combineLatest, EMPTY, filter, map, Observable, share, startWith, switchMap } from 'rxjs';
import { defaultDrawingConfig } from '@data/drawingConfig';

interface PolygonForSvg<T extends PolygonState> extends Polygon<T> {
  pointsStr: string;
}

function mapPolygonToPolygonForSvg<T extends PolygonState>(poly: Polygon<T>): PolygonForSvg<T> {
  return {
    ...poly,
    pointsStr: poly.points.reduce((str, pt) => `${str} ${pt.x},${pt.y}`, '')
  }
}

@Component({
  selector: 'app-canvas-polygons',
  imports: [],
  templateUrl: './canvas-polygons.html',
  styleUrl: './canvas-polygons.scss',
})
export class CanvasPolygons {
  // E/S
  public readonly drawingConfig = input(defaultDrawingConfig);
  public readonly polygons = model.required<readonly Polygon<"finished">[]>();

  // Membres protégés pour la vue
  protected readonly polygonsForSvg: Signal<readonly PolygonForSvg<PolygonState>[]>;

  // Membres privés pour la logique interne
  private readonly _canvasRef = viewChild<ElementRef<HTMLElement>>('svgCanvas');
  private readonly _canvas$: Observable<HTMLElement | undefined> = toObservable(this._canvasRef).pipe(
    map(ref => ref?.nativeElement)
  );

  /**
   * Constructor, set up observables for drawing polygons on the canvas and updating the signal with the new polygons to draw
   */
  constructor() {
    /** NE PAS MODIFIER
     * Observable définissant les polygones à dessiner sur le canevas 
     * lorsque les deux éléments suivants sont disponibles :
     * - le canevas (élément HTML)
     * - la configuration de dessin (drawingConfig)
     * Si l'un d'eux est manquant, l'observable sera vide et aucun dessin sera produit.
     */
    const currentPolygon$ = combineLatest([
      this._canvas$,
      toObservable(this.drawingConfig)
    ]).pipe(
      map(([canvas, config]) => ({canvas, config: config} as const)),
      switchMap(
        data => data.canvas === undefined ? EMPTY : drawPolygonFrom(data.canvas, data.config)
      ),
      share()
    );

    /** NE PAS MODIFIER
     * Observable mappant les polygones passés en entrée vers un format adapté pour le dessin SVG.
     */
    const svgPolygonsFromInput$ = toObservable(this.polygons).pipe(
      map(polys => polys.map(mapPolygonToPolygonForSvg))
    );

    /** NE PAS MODIFIER
     * Observable représentant le polygone en cours de dessin sous forme de tuple (tableau d'un élément)
     * pour faciliter la combinaison avec les polygones d'entrée
     */
    const currentSvgPolygonAsTuple$ = currentPolygon$.pipe(
      map(p => [mapPolygonToPolygonForSvg(p)]),
      startWith<PolygonForSvg<PolygonState>[]>([])
    );

    /** NE PAS MODIFIER
     * Observable combinant les polygones d'entrée et le polygone en cours de dessin
     * pour obtenir la liste des polygones à dessiner sur le canevas
     */
    const allSvgPolygons$ = combineLatest([
      svgPolygonsFromInput$,
      currentSvgPolygonAsTuple$
    ]).pipe(
      map(([fromInput, current]) => [
        ...fromInput,
        ...current.filter(p => !fromInput.some(pi => pi.id === p.id)) // On ajoute le polygone en cours de dessin seulement s'il n'est pas déjà dans les polygones passés en entrée.
      ])
    );

    /** NE PAS MODIFIER
     * On expose les polygones à dessiner sous forme de signal pour la vue.
     * Le signal est initialisé avec une liste vide.
     */
    this.polygonsForSvg = toSignal(allSvgPolygons$, { initialValue: [] });

    /**
     * Question B.3 : Accumulation des polygones
     */
    
  }

}
