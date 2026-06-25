import { Routes } from '@angular/router';

export const routes: Routes = [
  { path: '', redirectTo: 'page-1', pathMatch: 'full' },
  {
    path: 'page-1',
    loadComponent: () => import('./page-1/page-1').then(m => m.Page1)
  },
  {
    path: 'page-2',
    loadComponent: () => import('./page-2/page-2').then(m => m.Page2)
  },
  {
    path: 'page-3',
    loadComponent: () => import('./page-3/page-3').then(m => m.Page3)
  }
];
