# Examen CL&IHM 2025-2026 - 1

## Avant tout

Saisissez votre numéro d'anonymat (format AA999) : 

Pensez à commiter votre code et à la pousser sur le serveur. Vous pouvez vérifier l'état du GIT dans l'onglet vsCode "Source Control".
La version poussé sur votre dépôt correspond à l'icône "nuage/cloud" en bas à gauche de votre fenêtre vsCode.

**Commitez et poussez régulièrement votre code, même si vous n'avez pas implémenté toutes les fonctionnalités demandées.** Et ce afin d'éviter de perdre du travail en cas de problème technique (panne d'ordinateur, etc.).

Rappel, le site du cours : [https://im2ag-ens-l3m.univ-grenoble-alpes.fr](https://im2ag-ens-l3m.univ-grenoble-alpes.fr)

## Instructions générales

Les dépendances sont déjà installées. Commande pour exécuter le projet :

```bash
npm start
```

Vous pouvez consulter le résultat attendu en ligne à l'adresse suivante : [https://l3-miage-grenoble.github.io/l3m-clihm-2025-2026-exam-et-1/](https://l3-miage-grenoble.github.io/l3m-clihm-2025-2026-exam-et-1/).

**Documentation :** Des fichiers de documentation décrivant des fonctions et opérateurs RxJS sont disponibles dans le dossier `doc`.

## Partie A : Palette de dessin (8 points)

Dans cette partie, on travaillera sur la page 1, les fichiers à éditer seront les suivants :
* `src/app/page-1/page-1.ts`
* `src/app/page-1/page-1.html`
* `src/app/components/palette/palette.ts`

Il faudra dans cette partie implémenter une palette de dessin (dans le composant dédié `Palette`) et la synchroniser avec deux formulaires dans le composant `Page1` (un formulaire template driven et un formulaire réactif).

### A.1 : Composant `Palette`

La vue et le formulaire réactif (dans la vue-modèle) sont déjà implémentés. Complétez le constructeur du composant `Palette` pour synchroniser `_form` et `config` :
* Attention à éviter les boucles infinies de mises à jour.
* Attention à ne propager les informations de `_form` que si elles sont valides (voir l'attribut `valid` du formulaire). La vue du formulaire est en effet conçue à façon pour permettre la saisie d'une épaisseur de trait invalide (négative), alors que `_form` définit un validateur qui interdit les valeurs négatives pour l'épaisseur de trait. Le formulaire réactif enregistre ces valeurs mais indique alors que c'est invalide. Si les données du formulaire sont invalide, il faudra simplement ne pas les propager à l'attribut `config`.
* A l'inverse, on propagera les données de `config` vers `_form` sans vérifier leur validité.

Modifiez également le composant `Page1` afin de lier l'attribut `paletteConfig` de ce composant avec l'entrée-sortie `config` du composant `Palette` (dans les deux sens).

### A.2 : Composant `Page1`, formulaire template driven

En utilisant les mécanismes et directives des **template-driven forms** Angular, synchronisez le formulaire marqué `"Template-driven forms"` de la page 1 avec l'attribut `paletteConfig` dans les deux sens.

Conservez les balises HTML du formulaire déjà présentes dans `page-1.html` et ajoutez les data-bindings nécessaires en respectant les contraintes suivantes :
- Conservez `type="text"` pour les champs `fill` et `stroke`.
- Conservez `type="number"` pour le champ `strokeWidth`, sans ajouter d'attributs `min` ou `max` côté HTML.

Ces types sont volontairement permissifs : l'utilisateur peut ainsi saisir des couleurs invalides ou une épaisseur négative. La validation doit donc être gérée côté TypeScript, pas dans le template.

**Direction `paletteConfig` → formulaire :** chaque input doit refléter la valeur courante de `paletteConfig`.

**Direction formulaire → `paletteConfig` :** chaque modification d'un input doit déclencher une validation via `isValidDrawingConfigP` (définie dans `src/app/data/drawingConfig.ts`) avant toute mise à jour de `paletteConfig`. Si les données sont valides, mettez à jour `paletteConfig`. Sinon, écrivez un message d'erreur dans la console via :

```typescript
(err: ZodError) => this.displayConfigError("Erreur de validation template-driven\n", err)
```
et **ne mettez pas à jour `paletteConfig`**.


### A.3 : Composant `Page1`, formulaire réactif

En utilisant le `NonNullableFormBuilder`, définissez un formulaire réactif dans le composant `Page1` et synchronisez-le avec l'attribut `paletteConfig`.

Conservez les balises HTML du formulaire déjà présentes dans le fichier `page-1.html` et ajoutez les data-bindings nécessaires. Les inputs sont de type texte, c'est fait exprès pour que l'utilisateur puisse définir des valeurs invalides.

**Indications :**
* Construisez un attribut `_form` à l'aide du `NonNullableFormBuilder` afin de gérer des données de même type que `paletteConfig`.
* Etablissez les data-bindings avec la vue
* Dans le constructeur du composant `Page1`, synchronisez votre formulaire `_form` et `paletteConfig` (dans les deux sens). Attention à éviter les boucles infinies de mises à jour.
* Utilisez la fonction `isValidDrawingConfigObs` définie dans le fichier `src/app/data/drawingConfig.ts` pour vérifier que les données produites par le formulaire sont valides avant de les synchroniser avec la palette. Dans le cas contraire, il faudra écrire un message d'erreur dans la console et ne pas synchroniser les données.
* Pour capturer l'erreur, vous pourrez vous appuyer sur l'opérateur RxJS `catchError` pour dériver l'observable renvoyé par `isValidDrawingConfigObs`. La fonction de traitement de l'erreur pourra être la suivante :
    ```typescript
    (err: ZodError) => {
        this.displayConfigError("Erreur de validation reactive form\n", err);
        return EMPTY; // En cas d'erreur on s'arrète là...
    }
    ```

## Partie B : Canvas de polygones (8 points)

Dans cette partie, on travaillera sur le composant `CanvasPolygons` qui est déjà inclu dans le composant `Page2`, les fichiers à éditer seront les suivants :
* `src/app/components/canvas-polygons/canvas-polygons.ts`
* `src/app/data/drawPolygonFrom.ts`
* `réponses.md` (pour la question B.2)

Le but de cette partie est de permettre à l'utilisateur de dessiner des polygones, la palette de dessin (couleur de fond, couleur de trait, épaisseur de trait) est prédéfinie, il n'y a rien à modifier à ce niveau.

### Prise en main des types de données

Les données types utilisées pour définir les polygones sont dans les fichiers suivants :
* `src/app/data/point.ts` : Définition de ce qu'est un point. Définition des schémas ZOD correspondants et définition de la fonction `isPointArrayP` qui valide un tableau de points.
* `src/app/data/polygon.ts` : Définit en particulier :
  * `Polygon` : Un polygone immuable qui peut être dans l'état `"drawing"` ou `"finished"`. L'état `"drawing"` correspond à un polygone en cours de construction (dont on a la référence, mais cette référence ne permet pas de le modifier). L'état `"finished"` correspond à un polygone terminé.
  * `MutablePolygon` : Un polygone mutable, à utiliser pour construire un polygone à partir de points successifs. Son état est modififiable, ainsi que sa liste de points.
  * `createMutablePolygon` : Fonction de création d'un polygone mutable à partir de données partielles, elle génère automatiquement un id unique et initialise l'état à "drawing". Renvoie la promesse d'un polygone mutable. La promesse sera tenue si et seulement si les données sont valides.
  * `finishPolygon` : Fonction qui produit un polygone immuable fini à partir d'un polygone mutable.

### B.1 : Fonction de tracé d'un polygone

Complétez la fonction `drawPolygonFrom` définie dans le fichier `src/app/data/drawPolygonFrom.ts`. Cette fonction doit construire et émettre des polygones à partir des événements souris sur un canvas. Les observables sources sont déjà définis :

- `fromMouseDown$` : émet la position de la souris à chaque appui sur le bouton
- `fromMouseMove$` : émet la position de la souris à chaque mouvement
- `fromMouseUp$` : émet la position de la souris à chaque relâchement du bouton

**Ce que vous devez implémenter :** à partir de `fromMouseDown$`, effectuez une dérivation en **deux opérateurs RxJS enchaînés** :

**Premier opérateur :** à chaque appui sur le bouton de la souris, créez un nouveau polygone mutable via `createMutablePolygon`. Passez-lui le point de départ et la configuration de dessin (`config`).

**Second opérateur :** associez ce polygone mutable à un observable qui :
1. écoute `fromMouseMove$` et, à chaque mouvement, **ajoute le nouveau point directement dans `poly.points`** (ne créez pas un nouveau polygone à chaque point, modifiez le polygone existant),
2. s'arrête lorsque l'utilisateur relâche la souris.

> **Note sur le typage :** `MutablePolygon` est un sous-type de `Polygon<PolygonState>`. Vous pouvez donc émettre directement le polygone mutable sans conversion de type, et le modifier en place plutôt que d'en créer un nouveau à chaque point — c'est précisément l'intérêt de cette approche.

**Ce que vous devriez voir :** lorsque vous appuyez sur le bouton de la souris sur le canvas, un polygone commence à se dessiner à partir du point de départ. À chaque mouvement de la souris, un nouveau point est ajouté, jusqu'à ce que vous relâchiez la souris.

### B.2 : Terminer le tracé par un polygone terminé

Complétez le second opérateur de la dérivation définie à la question précédente pour que lorsque l'utilisateur relâche la souris, le polygone émis soit un polygone terminé (état "finished").

Pour cela, vous pourrez utiliser :
* la fonction `finishPolygon` définie dans le fichier `src/app/data/polygon.ts`.
* L'opérateur `concatWith` (voir la documentation dans le dossier `doc`).

On vous fait les propositions suivantes, indiquez dans le fichier `/réponses.md` pour chaque proposition si elle est correcte ou incorrecte et justifiez votre réponse pour chacune d'entre elle (une ligne de justification suffit). On suppose que poly se réfère au polygone mutable en cours de construction. Placez ensuite le code de la proposition dans le second opérateur de la dérivation définie à la question précédente pour vérifier que votre réponse est correcte.

1. ```typescript
    concatWith( of(0).pipe( map( () => finishPolygon(poly) ) ) )
    ```
2. ```typescript
    concatWith( of(finishPolygon(poly)) )
    ```
3. ```typescript
    concatWith( finishPolygon(poly) )
    ```
4. ```typescript
    concatWith( poly as Polygon<"finished"> )
    ```

**Ce que vous devriez voir :** Le comportement ne diffère que peu par rapport à la question B.1. Lorsque vous relâchez la souris, le polygone émis est un polygone terminé (état `"finished"`), c'est à dire que son état est `"finished"` et qu'il ne peut plus être modifié. La seule façon de vérifier cela est de logger dans la console les polygones émis par l'observable de la fonction `drawPolygonFrom`. Utilisez l'opérateur `tap` pour cela, par exemple :
  ```typescript
  xxx.pipe(
      ... des opérations qui produisent un polygone ....,
      tap( poly => console.log(poly) )
  )
  ```

### B.3 : Accumulation des polygones

Rendez-vous dans le constructeur du composant `CanvasPolygons` (fichier `src/app/components/canvas-polygons/canvas-polygons.ts`). A la fin du constructeur, il y a une zone dédiée à la réponse à la question B.3.

Le but de cette question est de faire en sorte que les polygones terminés soient ajoutés à la liste des polygones à afficher sur le canvas, au lieu d'être remplacé à chaque nouveau tracé. Pour cela, vous devrez faire en sorte que lorsque l'observable `currentPolygon$` émet un polygone **terminé**, ce polygone soit ajouté à la liste des polygones à afficher sur le canvas (via l'entrée-sortie `polygons`).

**Indications :** Dériver l'observable `currentPolygon$`. Lorsque ce dernier émet un polygone fini, ajoutez ce polygone à l'entrée-sortie `polygons` du composant. Appuyez-vous sur la fonction `isFinishedPolygon` définie dans le fichier `src/app/data/polygon.ts` qui permet de réaliser une réduction de type.

## Partie C : Canvas, palettes et stockage (8 points)

Dans cette partie, on travaillera sur le composant `Page3`, les fichiers à éditer seront les suivants :
* `src/app/page-3/page-3.ts`
* `src/app/page-3/page-3.html`

Vous devrez utiliser (mais pas modifier) le service `StoreService` (fichier `src/app/services/store-service.ts`), il est déjà injecté dans le composant `Page3`.

Le but de cette partie est de permettre à l'utilisateur de dessiner des polygones sur un canvas avec une palette de dessin, et de stocker ces polygones dans le localStorage du navigateur pour qu'ils soient conservés même lorsque l'utilisateur rafraichit la page.

En vous référant au site de référence donné en introduction de ce sujet, implémentez les fonctionnalités suivantes :
* La configuration de la palette est utilisée pour dessiner les polygones sur le canvas.
* Quand la liste des polygones est mise à jour, alors procéder à l'enregistrement de cette liste via le service `StoreService`. Ainsi, si la page est rechargée, les polygones précédemment sauvegardés sont rechargés et affichés sur le canevas.
* Lorsque l'utilisateur clique sur le bouton "Ajouter configuration", la configuration courante de la palette est ajoutée à une liste de configurations sauvegardées dans le service `StoreService`.
* Les configurations sauvegardées dans le service `StoreService` sont affichées dans la page (voir le commentaire dans la vue du composant pour les positionner). Vous pouvez utiliser le fragment HTML suivant pour afficher une configuration sauvegardée (en supposant que **`c`** soit une `DrawingConfig`) :
    ```html
    <svg width="40" height="40">
        <rect
            x="4" y="4" width="32" height="32" rx="4"
            [attr.fill]="c.fill"
            [attr.stroke]="c.stroke"
            [attr.stroke-width]="c.strokeWidth"
        />
    </svg>
    ```
* Lorsque l'utilisateur clique sur une configuration sauvegardée, la configuration courante de la palette est mise à jour avec cette configuration.
* Bouton de réinitialisation
  * **SI** la liste des configurations n'est pas vide
  * **OU** la liste des polygones n'est pas vide
  * **ALORS** afficher un bouton pour permettre de supprimer toutes les configurations ainsi que tous les polygones (via le service `StoreService`). Vous pouvez utiliser le template suivant pour ce bouton :
    ```html
    <button mat-icon-button color="warn">
        <mat-icon>delete</mat-icon>
    </button>
    ```
  * **SINON** ne pas afficher ce bouton de réinitialisation
* Si la liste des configurations sauvegardées n'est pas vide, alors la première configuration de cette liste est utilisée pour initialiser la palette à l'ouverture de la page, sinon la palette est initialisée avec une configuration par défaut (voir `defaultDrawingConfig`). **Indication :** Pensez à l'opérateur `take(1)` pour n'opérer cette initialisation qu'une seule fois à l'ouverture de la page.
