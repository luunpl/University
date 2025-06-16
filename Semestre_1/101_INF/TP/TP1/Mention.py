# 1. Calcul de la moyenne simple de 4 disciplines
def moyenne_simple():
    notes = []
    for matiere in ["Chimie", "Physique", "Mathématiques", "Informatique"]:
        note = float(input(f"Note en {matiere} : "))
        if note < 0 or note > 20:
            print("INCORRECT")
            return
        notes.append(note)
    moyenne = sum(notes) / 4
    print(f"Moyenne : {moyenne:.2f}")

# 2. Arrêt immédiat si note incorrecte
def moyenne_arret_immediat():
    notes = []
    for matiere in ["Chimie", "Physique", "Mathématiques", "Informatique"]:
        note = float(input(f"Note en {matiere} : "))
        if note < 0 or note > 20:
            print("INCORRECT")
            return
        notes.append(note)
    moyenne = sum(notes) / 4
    print(f"Moyenne : {moyenne:.2f}")

# 3. Moyenne pondérée avec coefficients
def moyenne_ponderee():
    matieres = [("Chimie", 3), ("Physique", 4), ("Mathématiques", 2), ("Informatique", 2)]
    total = 0
    total_coef = 0
    for matiere, coef in matieres:
        note = float(input(f"Note en {matiere} : "))
        if note < 0 or note > 20:
            print("INCORRECT")
            return
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")

# 4. Moyenne pondérée + mention
def moyenne_mention():
    matieres = [("Chimie", 3), ("Physique", 4), ("Mathématiques", 2), ("Informatique", 2)]
    total = 0
    total_coef = 0
    for matiere, coef in matieres:
        note = float(input(f"Note en {matiere} : "))
        if note < 0 or note > 20:
            print("INCORRECT")
            return
        total += note * coef
        total_coef += coef
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    if moyenne < 10:
        mention = "AJOURNE"
    elif moyenne < 12:
        mention = "PASSABLE"
    elif moyenne < 14:
        mention = "ASSEZ BIEN"
    elif moyenne < 16:
        mention = "BIEN"
    else:
        mention = "TRES BIEN"
    print(f"Mention : {mention}")

# 5. Deuxième chance pour une note incorrecte
def moyenne_mention_2chance():
    matieres = [("Chimie", 3), ("Physique", 4), ("Mathématiques", 2), ("Informatique", 2)]
    total = 0
    total_coef = 0
    for matiere, coef in matieres:
        for essai in range(2):
            note = float(input(f"Note en {matiere} : "))
            if 0 <= note <= 20:
                total += note * coef
                total_coef += coef
                break
            elif essai == 0:
                print("Note incorrecte, veuillez réessayer.")
            else:
                print("INCORRECT")
                return
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    if moyenne < 10:
        mention = "AJOURNE"
    elif moyenne < 12:
        mention = "PASSABLE"
    elif moyenne < 14:
        mention = "ASSEZ BIEN"
    elif moyenne < 16:
        mention = "BIEN"
    else:
        mention = "TRES BIEN"
    print(f"Mention : {mention}")

# 6. Bonus : filtrage avec while
def moyenne_mention_filtrage():
    matieres = [("Chimie", 3), ("Physique", 4), ("Mathématiques", 2), ("Informatique", 2)]
    total = 0
    total_coef = 0
    for matiere, coef in matieres:
        while True:
            note = float(input(f"Note en {matiere} : "))
            if 0 <= note <= 20:
                total += note * coef
                total_coef += coef
                break
            else:
                print("Note incorrecte, veuillez réessayer.")
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    if moyenne < 10:
        mention = "AJOURNE"
    elif moyenne < 12:
        mention = "PASSABLE"
    elif moyenne < 14:
        mention = "ASSEZ BIEN"
    elif moyenne < 16:
        mention = "BIEN"
    else:
        mention = "TRES BIEN"
    print(f"Mention : {mention}")

# 7. Bonus : nombre de disciplines et coefficients inconnus
def moyenne_mention_generique():
    n = int(input("Nombre de disciplines : "))
    total = 0
    total_coef = 0
    for i in range(n):
        nom = input(f"Nom de la discipline {i+1} : ")
        coef = int(input(f"Coefficient de {nom} : "))
        while True:
            note = float(input(f"Note en {nom} : "))
            if 0 <= note <= 20:
                total += note * coef
                total_coef += coef
                break
            else:
                print("Note incorrecte, veuillez réessayer.")
    moyenne = total / total_coef
    print(f"Moyenne pondérée : {moyenne:.2f}")
    if moyenne < 10:
        mention = "AJOURNE"
    elif moyenne < 12:
        mention = "PASSABLE"
    elif moyenne < 14:
        mention = "ASSEZ BIEN"
    elif moyenne < 16:
        mention = "BIEN"
    else:
        mention = "TRES BIEN"
    print(f"Mention : {mention}")

# moyenne_simple()
# moyenne_arret_immediat()
# moyenne_ponderee()
# moyenne_mention()
# moyenne_mention_2chance()
# moyenne_mention_filtrage()
# moyenne_mention_generique()