import { Component, computed, effect, inject, signal } from '@angular/core';
import { toObservable, toSignal } from '@angular/core/rxjs-interop';
import { FormsModule, NonNullableFormBuilder, ReactiveFormsModule } from '@angular/forms';
import { Palette } from '@components/palette/palette';
import { defaultDrawingConfig, DrawingConfig, isValidDrawingConfigObs, isValidDrawingConfigP } from '@data/drawingConfig';
import { catchError, EMPTY, map, switchMap } from 'rxjs';
import { ZodError } from 'zod';

@Component({
  selector: 'app-page-1',
  imports: [Palette, FormsModule, ReactiveFormsModule],
  templateUrl: './page-1.html',
  styleUrl: './page-1.scss'
})
export class Page1 {
  protected readonly paletteConfig = signal<DrawingConfig>(defaultDrawingConfig);

  /**
   * Question A.2 : Synchronisation du formulaire template driven et paletteConfig
   */


  /**
   * Question A.3 : Définition et synchronisation du formulaire réactif et paletteConfig
   */
  private readonly _fb = inject(NonNullableFormBuilder);
  
  // Définition du formulaire réactif


  constructor() {
    // Synchronisation du formulaire réactif et de paletteConfig
  }

  /**
   * Affiche dans la console les détails d'une erreur de validation d'un DrawingConfig
   * @param prefix Le préfixe pour identifier la source de l'erreur dans la console
   * @param err Le ZodError contenant les détails de l'erreur de validation
   */
  private displayConfigError(prefix: string, err: ZodError) {
    console.error(prefix, err.issues.at(0)?.path.join('.'), "\n", err.issues.at(0)?.message)
  }

}
