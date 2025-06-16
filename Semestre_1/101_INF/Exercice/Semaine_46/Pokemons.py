"""
Dans un jeu vidéo Pokemon, on souhaite donner des noms personnalisés à certains types de pokémons. Pour ce faire, on définit une fonction noms_perso(pokemons, noms), qui prend en argument une liste de pokémons attrapés, et un dictionnaire faisant correspondre des noms de pokémons originaux à leurs nouveaux noms. La fonction renvoie une nouvelle liste de pokémons, avec les noms modifiés. Les noms qui n'apparaissement pas dans le dictionnaire restent inchangés.

Exemple:

    mes_pokemons = ["pikachu", "bulbizarre", "roucarnage", "lippoutou"]
    mes_noms = {"bulbizarre": "jean-jacques", "roucarnage": "gros pigeon"}
    noms_perso(mes_pokemons, mes_noms)
    ["pikachu", "jean-jacques", "gros pigeon", "lippoutou"]
"""


def noms_perso(pokemons, noms):
    result = []
    for i in pokemons:
        if i in noms:
            result.append(noms[i])
        else:
            result.append(i)
    return result
