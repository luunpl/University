# Welcome to my GitHub!

I am a student at the Université Grenoble Alpes.  
All my files and projects here are written in French.  
Passionate about learning and sharing knowledge, I share my academic work here.  

## Organisation

L1 IMA → L2 INM → L3 MIAGE (see `ETC/Maquette_Licence_MIAGE.pdf`).

### Structure

```
Semestre_N/<UE>/              # UE = 101_INF … (S1–S4) or abbreviation (S5–S6)
├── Cours/      NN_Sujet.pdf  (00_ = presentation), Poly_<UE>.pdf, Livre_*.pdf, Memo_*.pdf
├── TD/         TDn[_Sujet].pdf, TDn_Correction.pdf, Poly_TD_<UE>.pdf, Memo_*.pdf
├── TP/         TPn.pdf / TPn/ (code), TPn.ipynb, TPn_Correction.*
├── Exercice/   extra exercises (Caseine, colles, articles…)
├── Projet/     <Nom_Projet>/
└── Annales/    <Type>_<Year>[_Variant][_Correction].pdf
```

- Only the sub-folders a course needs exist. A course split into independent parts repeats this layout per part (`201_MAP/EDO`, `201_MAP/IMAGE`, `SR/Reseaux`, `SR/Systeme`).
- Exam types: `Partiel`, `Terminal`, `Seconde_Chance`, `Examen`, `CC`, `DS`, `Quick`, `Quiz`, `Test_Positionnement`. `<Year>` is the calendar year of the exam. An exam done as a code project is a folder `Annales/<Type>_<Year>/`.
- File names: no spaces or `& ' , ( )` — use `_`; numbers on two digits (`01_`, `10_`) so they sort correctly.

| Semestre | Dossier | UE |
|---|---|---|
| S1 | `101_INF` | INF101 – Méthodes informatiques et techniques de programmation |
| S1 | `101_MAT` | MAT101 – Langage mathématique, algèbre et géométrie élémentaires |
| S1 | `101_MAP` | MAP101 – Analyse élémentaire et introduction au calcul scientifique |
| S1 | `103_INF` | INF103 – Science des données |
| S1 | `105_MAT` | MAT105 |
| S2 | `201_INF` | INF201 – Algorithmique et programmation fonctionnelle |
| S2 | `201_MAT` | MAT201 – Introduction à l'algèbre linéaire |
| S2 | `201_MAP` | MAP201 – Découverte des mathématiques appliquées (`IMAGE/`, `EDO/`) |
| S2 | `202_INF` | INF202 – Logique et relations |
| S2 | `203_INF` | INF203 – Unix, Bash et langage C |
| S3 | `301_INF` | INF301 – Algorithmique et programmation impérative |
| S3 | `302_INF` | INF302 – Automates et langages |
| S3 | `303_INF` | INF303 – Modélisation des structures informatiques (graphes) |
| S3 | `304_INF` | INF304 – Bases du développement logiciel |
| S3 | `309_MAT` | MAT309 – Algèbre et arithmétique |
| S4 | `401_INF` | INF401 – Introduction aux architectures logicielles et matérielles |
| S4 | `401_STA` | STA401 – Statistique et calcul des probabilités |
| S4 | `401_GES` | GES401 – Économie et gestion |
| S4 | `403_INF` | INF403 – Gestion de données relationnelles et applications |
| S4 | `404_INF` | INF404 – Projet logiciel |
| S5 | `ALM` | Architectures logicielles et matérielles |
| S5 | `SR` | Systèmes et réseaux |
| S5 | `APO` | Algorithmique et programmation orientée objet |
| S5 | `FD` | Formalisation des connaissances et programmation fonctionnelle (langages pour le web) |
| S5 | `RO` | Recherche opérationnelle |
| S5 | `MSI` | Management des systèmes d'information |
| S5 | `GC` | Gestion commerciale |
| S6 | `BD` | Bases de données et systèmes d'information |
| S6 | `MSPL` | Modèles statistiques et programmation lettrée (méthodologie) |
| S6 | `PD` | Programmation déclarative (Prolog) |
| S6 | `IHM` | Composants logiciels et IHM |
| S6 | `GRH` | Gestion des ressources humaines |

`ETC/` holds everything that is not a course of the curriculum: `Calendriers/`, `Langues/` (English), `Insertion_Pro/` (PPC, PEP2, stages, alternance), `Hors_Cursus/` (INF402, MOSIG) and `Outils/`.
