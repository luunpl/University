import { Component, signal } from '@angular/core';
import { CanvasPolygons } from '@components/canvas-polygons/canvas-polygons';
import { createMutablePolygon, finishPolygon, Polygon } from '@data/polygon';

@Component({
  selector: 'app-page-2',
  imports: [CanvasPolygons],
  templateUrl: './page-2.html',
  styleUrl: './page-2.scss'
})
export class Page2 {
  protected readonly polygons = signal<readonly Polygon<"finished">[]>([]);
    
  constructor() {
    this.init();
  }

  init(): void {
    Promise.all([
      createMutablePolygon({ fill: "#00ff00", stroke: "#000000", strokeWidth: 1, points: [{ x: 10, y: 10 }, { x: 100, y: 10 }, { x: 100, y: 100 }] }),
      createMutablePolygon({ fill: "#0000ff", stroke: "#000000", strokeWidth: 4, points: [{ x: 50, y: 50 }, { x: 150, y: 50 }, { x: 150, y: 150 }] }),
      createMutablePolygon({ fill: "#00ffff", stroke: "#000000", strokeWidth: 2, points: [{ x: 90, y: 90 }, { x: 190, y: 90 }, { x: 190, y: 190 }] }),
    ]).then(
      L => L.map(finishPolygon)
    ).then(
      L => this.polygons.set(L)
    );
  }
}
