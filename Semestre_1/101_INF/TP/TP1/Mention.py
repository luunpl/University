MATIERES_PONDERES = [
    ("Chimie", 3),
    ("Physique", 4),
    ("Mathématiques", 2),
    ("Informatique", 2),
]


def calculer_mention(moyenne: float) -> str:
    """Retourne la mention associée à une moyenne donnée."""
    if moyenne < 10:
        return "AJOURNE"
    if moyenne < 12:
        return "PASSABLE"
    if moyenne < 14:
        return "ASSEZ BIEN"
    if moyenne < 16:
        return "BIEN"
    return "TRES BIEN"


def demander_note_unique(matiere: str) -> float | None:
    """
    Demande une note pour une matière.
    Retourne la note si elle est correcte, None sinon (et affiche 'INCORRECT').
    """
    note = float(input(f"Note en {matiere} : "))
    if 0 <= note <= 20:
        return note

    print("INCORRECT")
    return None


def demander_note_avec_reessais(matiere: str, max_essais: int = 2) -> float | None:
    """
    Demande une note avec un nombre limité d'essais.
    Retourne la note si elle est correcte, None sinon (et affiche 'INCORRECT' en dernier recours).
    """
    for essai in range(max_essais):
        note = float(input(f"Note en {matiere} : "))
        if 0 <= note <= 20:
            return note

        if essai < max_essais - 1:
            print("Note incorrecte, veuillez réessayer.")
        else:
            print("INCORRECT")

    return None


def demander_note_filtrage(matiere: str) -> float:
    """Demande une note jusqu'à ce qu'elle soit correcte."""
    while True:
        note = float(input(f"Note en {matiere} : "))
        if 0 <= note <= 20:
            return note
        print("Note incorrecte, veuillez réessayer.")


# 1. Calcul de la moyenne simple de 4 disciplines
def moyenne_simple():
    notes = []
    for matiere in ["Chimie", "Physique", "Mathématiques", "Informatique"]:
        note = demander_note_unique(matiere)
        if note is None:
            return
        notes.append(note)
    moyenne = sum(notes) / len(notes)
    print(f"Moyenne : {moyenne:.2f}")


# 2. Arrêt immédiat si note incorrecte
def moyenne_arret_immediat():
    # Même comportement que moyenne_simple, conservé pour compatibilité.
    moyenne_simple()


# 3. Moyenne pondérée avec coefficients
def moyenne_ponderee():
    total = 0.0
    total_coef = 0
    for matiere, coef in MATIERES_PONDERES:
        note = demander_note_unique(matiere)
        if note is None:
            return
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")


# 4. Moyenne pondérée + mention
def moyenne_mention():
    total = 0.0
    total_coef = 0
    for matiere, coef in MATIERES_PONDERES:
        note = demander_note_unique(matiere)
        if note is None:
            return
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    mention = calculer_mention(moyenne)
    print(f"Mention : {mention}")


# 5. Deuxième chance pour une note incorrecte
def moyenne_mention_2chance():
    total = 0.0
    total_coef = 0
    for matiere, coef in MATIERES_PONDERES:
        note = demander_note_avec_reessais(matiere, max_essais=2)
        if note is None:
            return
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    mention = calculer_mention(moyenne)
    print(f"Mention : {mention}")


# 6. Bonus : filtrage avec while
def moyenne_mention_filtrage():
    total = 0.0
    total_coef = 0
    for matiere, coef in MATIERES_PONDERES:
        note = demander_note_filtrage(matiere)
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    mention = calculer_mention(moyenne)
    print(f"Mention : {mention}")


# 7. Bonus : nombre de disciplines et coefficients inconnus
def moyenne_mention_generique():
    n = int(input("Nombre de disciplines : "))
    total = 0.0
    total_coef = 0
    for i in range(n):
        nom = input(f"Nom de la discipline {i + 1} : ")
        coef = int(input(f"Coefficient de {nom} : "))
        note = demander_note_filtrage(nom)
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    mention = calculer_mention(moyenne)
    print(f"Mention : {mention}")
