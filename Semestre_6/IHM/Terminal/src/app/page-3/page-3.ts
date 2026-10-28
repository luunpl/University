import { Component, computed, inject, signal } from '@angular/core';
import { toObservable } from '@angular/core/rxjs-interop';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { CanvasPolygons } from '@components/canvas-polygons/canvas-polygons';
import { Palette } from '@components/palette/palette';
import { DrawingConfig, defaultDrawingConfig } from '@data/drawingConfig';
import { Polygon } from '@data/polygon';
import { StoreService } from '@services/store-service';
import { filter, map, skip, take, tap } from 'rxjs';


@Component({
  selector: 'app-page-3',
  imports: [CanvasPolygons, Palette, MatButtonModule, MatIconModule],
  templateUrl: './page-3.html',
  styleUrl: './page-3.scss'
})
export class Page3 {
  private readonly _store = inject(StoreService);
  
  protected readonly polygons = this._store.polygons;
  protected readonly configs  = this._store.configs;
  protected readonly paletteConfig = signal<DrawingConfig>(defaultDrawingConfig);

  /**
   * Partie C
   */
}
