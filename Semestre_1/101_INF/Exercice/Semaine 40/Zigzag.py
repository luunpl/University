"""
Ecrire un programme qui demande à l'utilisateur deux entiers qui correspondront à la numérotation de la première et de la dernière ligne, puis un troisième entier qui correspondra au nombre de z avant "zigzag" (sans compter le premier "z" de zigzag), puis enfin qui affiche un zig-zag suivant le modèle suivant:

Numero de début:* l'utilisateur tape 3 *
Numero de fin:* l'utilisateur tape 10 *
Nombre de z:  * l'utilisateur tape 5 *
zzzzzzigzag 3
4 zzzzzzigzag
zzzzzzigzag 5
6 zzzzzzigzag
zzzzzzigzag 7
8 zzzzzzigzag
zzzzzzigzag 9
10 zzzzzzigzag

(les entiers pairs doivent être à gauche du zig-zag, et les entiers impairs doivent être à droite).

Exemple 2:

Numero de début:* l'utilisateur tape -2 *
Numero de fin:* l'utilisateur tape 4 *
Nombre de z:  * l'utilisateur tape 3 *
-2 zzzzigzag
zzzzigzag -1
0 zzzzigzag
zzzzigzag 1
2 zzzzigzag
zzzzigzag 3
4 zzzzigzag

Exemple 3:

Numero de début:* l'utilisateur tape 5 *
Numero de fin:* l'utilisateur tape 0 *
Nombre de z:  * l'utilisateur tape 10 *
(Rien ne s'affiche car 5>0)
"""

start = int(input("Numero de début: "))
end = int(input("Numero de fin: "))
nombre = int(input("Nombre de z: "))

zig = "z" * nombre
for i in range(start, end + 1):
    if i % 2 == 0:
        chaine = str(i) + " " + zig + "zigzag"
        print(chaine)
    else:
        chaine = zig + "zigzag" + " " + str(i)
        print(chaine)
