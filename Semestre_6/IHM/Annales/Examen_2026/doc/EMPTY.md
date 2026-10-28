# EMPTY

Observable qui complète immédiatement sans émettre aucune valeur.

![marble EMPTY](EMPTY.png)

Peut être utile en combinaison avec des opérateurs monadiques comme switchMap, mergeMap, etc...

Exemple 1 :
```ts
import { EMPTY } from 'rxjs';

EMPTY.subscribe({
  next: () => console.log('ne sera jamais appelé'),
  complete: () => console.log('complété')
});
// complété
```

Exemple 2 :
```ts
import { EMPTY } from 'rxjs';

source$.pipe(
  data => {
    if ( hasCertainProperties(data) ) return ....;
    return EMPTY; // si les données n'ont pas les propriétés attendues, on retourne un observable "vide"
  }
).subscribe( console.log );
```
