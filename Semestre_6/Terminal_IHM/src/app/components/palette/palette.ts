import { Component, effect, inject, model } from '@angular/core';
import { NonNullableFormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSliderModule } from '@angular/material/slider';
import { DrawingConfig } from '@data/drawingConfig';
import { filter, map } from 'rxjs';

@Component({
  selector: 'app-palette',
  imports: [ReactiveFormsModule, MatFormFieldModule, MatInputModule, MatSliderModule],
  templateUrl: './palette.html',
  styleUrl: './palette.scss',
})
export class Palette {
  // E/S du composant
  public readonly config = model.required<DrawingConfig>();

  // Injection de dépendances (service de construction de formulaires)
  private readonly _fb = inject(NonNullableFormBuilder);

  private readonly _form = this._fb.group({
    fill: ['#ff0000', Validators.required],
    stroke: ['#000000', Validators.required],
    strokeWidth: [2, [Validators.required, Validators.min(0)]],
  });
  protected readonly controls = this._form.controls;

  constructor() {
    // Question A.1 : Synchronisation de _form et config
  }
}
