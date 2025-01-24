"""
On veut gérer les notes d’examens des étudiants d’un groupe. Tous les étudiants du groupe ne suivent pas forcément les mêmes cours, ni le même nombre de cours. Les notes sont organisées dans une liste, dont chaque élément est un dictionnaire contenant le nom de l’étudiant et ses notes dans les matières qu’il a choisies. Exemple :

notes_groupe=[
    {’nom’: ’lambert’, ’notes’: {’physique’: 12, ’info’: 11}},
    {’nom’: ’meng’, ’notes’: {’maths’: 13.5, ’info’: 18, ’sport’: 17}},
    ...]

1. Ecrire une fonction moyenne_etudiant(etudiant) qui prend en argument un élément de la liste décrite précédemment et qui retourne la moyenne de l’étudiant.

2. Ecrire une fonction meilleur(notes_groupe) qui prend la liste du groupe en argument et retourne la meilleure moyenne du groupe ainsi que le nom de l’étudiant qui l’a obtenue.

3. (Difficile) Ecrire une fonction matiere_difficile(notes_groupe) qui retourne le nom de la matière la plus difficile (celle qui a la pire moyenne de groupe).
"""


def moyenne_etudiant(etudiant):
    somme_note = 0
    matiere = 0
    for note in etudiant['notes']:
        somme_note += etudiant['notes'][note]
        matiere += 1
    return somme_note / matiere


def meilleur(notes_groupe):
    max = 0
    meilleur_etudiant = ""
    for etudiant in notes_groupe:
        # Chercher la meilleure moyenne
        if moyenne_etudiant(etudiant) > max:
            max = moyenne_etudiant(etudiant)
            meilleur_etudiant = etudiant["nom"]
    return max, meilleur_etudiant


def matiere_difficile(notes_groupe):
    matieres = set()
    for etudiant in notes_groupe:
        notes = etudiant.get('notes', {})
        matieres.update(notes.keys())

    pire_moyenne = float('inf')
    matiere_pire_moyenne = ''

    for matiere in matieres:
        total_notes_matiere = 0
        nombre_etudiants = 0
        for etudiant in notes_groupe:
            notes = etudiant.get('notes', {})
            total_notes_matiere += notes.get(matiere, 0)
            nombre_etudiants += 1
        moyenne_matiere = total_notes_matiere / nombre_etudiants
        if moyenne_matiere < pire_moyenne:
            pire_moyenne = moyenne_matiere
            matiere_pire_moyenne = matiere
    return matiere_pire_moyenne
