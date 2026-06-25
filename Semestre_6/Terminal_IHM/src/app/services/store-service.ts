import { effect, Injectable, signal } from '@angular/core';
import { takeUntilDestroyed, toObservable } from '@angular/core/rxjs-interop';
import { DrawingConfig, drawingConfigSchema } from '@data/drawingConfig';
import { pointsArraySchema } from '@data/point';
import { createMutablePolygon, finishPolygon, MutablePolygon, Polygon } from '@data/polygon';
import { combineLatest, skip, switchMap } from 'rxjs';

const configsKey = "l3m-clihm-2025-2026-exam-et-1-configs";
const polygonsKey = "l3m-clihm-2025-2026-exam-et-1-polygons";

@Injectable({
  providedIn: 'root',
})
export class StoreService {
  // Signaux privés en écriture pour gérer les données
  private readonly _configs = signal<readonly DrawingConfig[]>([]);
  private readonly _polygons = signal<readonly Polygon<"finished">[]>([]);

  // Signaux publics en lecture seule pour exposer les données
  public readonly configs = this._configs.asReadonly();
  public readonly polygons = this._polygons.asReadonly();

  constructor() {
    // Sauvegarde des configurations de dessin dans le localStorage
    toObservable(this._configs).pipe(
      skip(1),
      takeUntilDestroyed()
    ).subscribe(
      configs => localStorage.setItem(configsKey, JSON.stringify(configs))
    );
    
    // Sauvegarde des polygones dans le localStorage
    toObservable(this._polygons).pipe(
      skip(1),
      takeUntilDestroyed()
    ).subscribe(
      polys => localStorage.setItem(polygonsKey, JSON.stringify(polys))
    );

    // Initialisation des signaux du store avec les données du localStorage
    this.init();
  }

  /**
   * Sauvegarde d'une configuration de dessin.
   * La configuration sera ajoutée à la liste des configurations déjà présentes.
   * @param config La configuration de dessin à sauvegarder
   */
  public saveDrawingConfig(config: DrawingConfig): void {
    this._configs.update( L => [...L, config] );
  }

  /**
   * Réinitialisation de la liste des configurations.
   * Toutes les configurations seront supprimées.
   * La liste des configurations sera vide après l'appel de cette méthode.
   */
  public resetConfigs(): void {
    this._configs.set([]);
  }

  /**
   * Réinitialisation de la liste des polygones.
   * Tous les polygones seront supprimés.
   * La liste des polygones sera vide après l'appel de cette méthode.
   */
  public resetPolygons(): void {
    this._polygons.set([]);
  }
  
  /**
   * Sauvegarde d'une liste de polygones terminés.
   * La liste de polygones fournie remplacera la liste des polygones déjà présents.
   * @param polys La liste de polygones à sauvegarder, qui doit être une liste de polygones terminés (état "finished")
   */
  public savePolygons(polys: readonly Polygon<"finished">[]): void {
    this._polygons.set(polys);
  }

  /**
   * Initialisation des signaux du store avec les données du localStorage.
   */
  private init(): void {
    combineLatest([
      jsonParseAsync(localStorage.getItem(configsKey) ?? "[]").then(isDrawingConfigListP).catch(() => [] as DrawingConfig[]),
      jsonParseAsync(localStorage.getItem(polygonsKey) ?? "[]").then(isPseudoPolygonListP).catch(() => [] as Omit<MutablePolygon, "id" | "state">[])
    ]).pipe(
      switchMap(
        ([C, LP]) => Promise.all(
          LP.map(createMutablePolygon)
        ).then(
          L => [C, L.map(finishPolygon)] as const
        )
      )
    ).subscribe(
      ([C, LP]) => {
        this._configs.set(C);
        this._polygons.set(LP);
      }
    );
  }
}

/**
 * Utilitaries
 */
async function jsonParseAsync(str: string): Promise<unknown> {
  return new Promise( (resolve, reject) => {
    try {
      resolve(JSON.parse(str));
    } catch (err) {
      reject(err);
    }
  });
}

/**
 * Validation of a list of DrawingConfig, using the schema defined in drawingConfig.ts
 */
import { z } from 'zod';

const drawingConfigsSchema = z.array(drawingConfigSchema);
async function isDrawingConfigListP(data: unknown): Promise<readonly DrawingConfig[]> {
  return drawingConfigsSchema.parseAsync(data);
}

async function isPseudoPolygonListP(data: unknown): Promise<readonly Omit<MutablePolygon, "id" | "state">[]> {
  return polygonListSchema.parseAsync(data);
}

const polygonListSchema = z.array(
  drawingConfigSchema.extend({
    points: pointsArraySchema,
  })
);