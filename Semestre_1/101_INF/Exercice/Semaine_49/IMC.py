# Ecrivez votre programme ci-dessous.
# Bouton Fullscreen pour passer en plein ecran
# Ensuite Save + Run puis Save + Evaluate
# Pour des raisons techniques, laissez une ligne blanche avant de commencer votre programme.





def separe(ligne):
    ligne=ligne.strip() # permet d'enlever un éventuel \n et/ou des espaces a la fin de la ligne
    liste_donnees=ligne.split(" ") # separe la ligne a chaque fois qu'un espace est rencontré
    return liste_donnees
    
def affiche_console(nom_fichier):
    print("====================================")
    print("Contenu du fichier", nom_fichier)
    print("====================================")
    f=open(nom_fichier)
    print(f.read())
    print("====================================")
    f.close()
        
        
if __name__=="__main__": # NE PAS SUPPRIMER CETTE LIGNE
    # Votre programme principal ne sera pas évalué.
    # Utilisez-le pour tester votre programme en faisant
    # les appels de votre choix.
    # Respectez bien ce niveau d'identation.
    print("Debut du prog. principal")
    
    print("Test de la fonction affiche_console")
    affiche_console("resultats-donnees1.txt")
   