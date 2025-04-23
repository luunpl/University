-- Jeux de données NOK (ne doit pas marcher àprès avoir éxécuté le jeux de données NOK)

-- Erreur : Modèle existant
INSERT INTO Modeles VALUES ('Pirate', 10);
-- Erreur : Longueur négative
INSERT INTO Modeles VALUES ('Voilier', -3);

-- Erreur : Type emplacement autre que "petit", "moyen" ou "grand"
INSERT INTO TypesEmplacements VALUES ('très petit', 2, 2000);

-- Erreur : Emplacement avec type inconnu
INSERT INTO Emplacements VALUES (1000, 4, 'cetypenexistepas');

-- Erreur : Bateau avec numéro existant
INSERT INTO Bateaux VALUES (1, '1111-01-01', 'Pirate',1001);
-- Erreur : Bateau sans modèle
INSERT INTO Bateaux VALUES (12, '1222-02-02', NULL,1002);
-- Erreur : Bateau sans emplacement
INSERT INTO Bateaux VALUES (13, '1333-03-03', 'Pirate', NULL);
-- Erreur : Bateau de modèle inconnu
INSERT INTO Bateaux VALUES (14, '1444-04-04', 'ModeleInventé',1004);
-- Erreur : Bateau dans emplacement inconnu
INSERT INTO Bateaux VALUES (15, '1555-05-05', 'Pirate',1015);
-- Erreur : Bateau dans emplacement déjà occupé
INSERT INTO Bateaux VALUES (16, '1666-06-06', 'Pirate',1006);

-- Erreur : Adhérent avec numéro existant
INSERT INTO Adherents VALUES (10, 'Erroné', 'Erroné', '2020-02-02');
-- Erreur : Adhérent sans nom
INSERT INTO Adherents VALUES (15, NULL, 'Erroné', '2020-02-02');
-- Erreur : Adhérent sans prenom
INSERT INTO Adherents VALUES (16, 'Erroné', NULL, '2020-02-02');

-- Erreur : Adhérent inconnu
INSERT INTO Proprietaires VALUES (666, 1);
-- Erreur : Bateau inconnu
INSERT INTO Proprietaires VALUES (1, 666);
-- Erreur : Bateau inconnu
INSERT INTO Proprietaires VALUES (999, NULL);
-- Erreur : Adhérent inconnu
INSERT INTO Proprietaires VALUES (NULL, 999);