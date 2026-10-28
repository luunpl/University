# concatWith

Émet toutes les valeurs de l'observable source, puis, une fois qu'il complète, s'abonne à chaque observable passé en argument, l'un après l'autre, sans s'abonner au suivant avant que le précédent ait complété.

Exemple :
```ts
import { fromEvent, map, take, concatWith } from 'rxjs';

const clicks$ = fromEvent(document, 'click');
const moves$ = fromEvent(document, 'mousemove');

clicks$.pipe(
  map(() => 'click'),
  take(1),
  concatWith(
    moves$.pipe(
      map(() => 'move')
    )
  )
).subscribe(x => console.log(x));

// 'click'
// 'move'
// 'move'
// 'move'
// ...
```
