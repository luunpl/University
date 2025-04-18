--Suppression des tables si elles existent deja
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Exemplaires;
DROP TABLE IF EXISTS Indisponibilites;
DROP TABLE IF EXISTS Employes_base;
DROP TABLE IF EXISTS Materiels_base;
DROP TABLE IF EXISTS SousCategories;
DROP TABLE IF EXISTS Categories;

--Suppression des vues si elles existent deja
DROP VIEW IF EXISTS Employes;
DROP VIEW IF EXISTS Materiels;

-- Pour activer les FKs
PRAGMA FOREIGN_KEYS=ON;

--Question 2 (Script de création de la BD)
--Creation des tables
--Types SQLite vs ORACLE (TEXT = VARCHAR; REAL & INTEGER = NUMBER)
CREATE TABLE Materiels_base (
   id_materiel INTEGER PRIMARY KEY,
   id_categorie INTEGER NOT NULL,
   libelle_materiel TEXT NOT NULL,
   FOREIGN KEY (id_categorie) REFERENCES Categories(id_categorie)
);

CREATE TABLE Indisponibilites (
   id_indisponibilite INTEGER PRIMARY KEY,
   description_indisponibilite TEXT NOT NULL CHECK (description_indisponibilite IN ('panne', 'maintenance', 'perdu'))
);

CREATE TABLE Employes_base (
   id_employe INTEGER PRIMARY KEY,
   nom_employe TEXT NOT NULL,
   mail TEXT,
   tel TEXT
);

CREATE TABLE Reservations (
   id_reservation INTEGER PRIMARY KEY AUTOINCREMENT,
   id_employe INTEGER NOT NULL,
   id_exemplaire INTEGER NOT NULL,
   date_debut date NOT NULL,
   date_fin date NOT NULL,
   date_emprunt date,
   date_retour date,
   FOREIGN KEY (id_employe) REFERENCES Employes_base(id_employe),
   FOREIGN KEY (id_exemplaire) REFERENCES Exemplaires(id_exemplaire),
   CHECK (date_emprunt IS NULL OR date_emprunt >= date_debut),
   CHECK (date_emprunt IS NULL OR date_fin >= date_emprunt),
   CHECK (date_retour IS NULL OR date_retour >= date_emprunt)
);


CREATE TABLE Exemplaires (
   id_exemplaire INTEGER PRIMARY KEY,
   id_materiel INTEGER NOT NULL,
   id_indisponibilite INTEGER,
   etat TEXT NOT NULL CHECK (etat IN ('neuf', 'bon', 'moyen', 'defectueux')),
   FOREIGN KEY (id_materiel) REFERENCES Materiels_base(id_materiel),
   FOREIGN KEY (id_indisponibilite) REFERENCES Indisponibilites(id_indisponibilite)
);

CREATE TABLE Categories (
   id_categorie INTEGER PRIMARY KEY,
   libelle_categorie TEXT NOT NULL UNIQUE,
   nb_emprunt_max INTEGER NOT NULL
);

CREATE TABLE SousCategories (
   id_sous_categorie INTEGER PRIMARY KEY,
   id_categorie INTEGER NOT NULL,
   libelle_sous_categorie TEXT NOT NULL UNIQUE,
   id_parent_sous_categorie INTEGER,
   FOREIGN KEY (id_categorie) REFERENCES Categories(id_categorie),
   FOREIGN KEY (id_parent_sous_categorie) REFERENCES SousCategories(id_sous_categorie)
);

--Question 3 (Transfert de données existantes et sous-catégories) 
--Charger des donnees
INSERT INTO Indisponibilites
SELECT id_indisponibilite, description_indisponibilite
FROM Resa
WHERE id_indisponibilite != '';
	
INSERT INTO Employes_base (id_employe, nom_employe, mail, tel)
SELECT DISTINCT id_employe, nom_employe, mail, tel
FROM Resa
WHERE id_employe IS NOT NULL AND id_employe != '';
		
INSERT INTO Categories
	SELECT DISTINCT id_categorie, libelle_categorie, nb_emprunt_max
	FROM Resa
	WHERE libelle_categorie != '' AND nb_emprunt_max != '';

INSERT INTO Materiels_base
		SELECT DISTINCT id_materiel, id_categorie, libelle_materiel
		FROM Resa
		WHERE id_categorie != '' AND libelle_materiel != '';
		
INSERT INTO Exemplaires
	SELECT DISTINCT id_exemplaire, id_materiel, id_indisponibilite, etat
	FROM Resa
	WHERE id_materiel != '' AND etat != '';
	
INSERT INTO Reservations (
  id_employe,
  id_exemplaire,
  date_debut,
  date_fin,
  date_emprunt,
  date_retour
)
SELECT id_employe, id_exemplaire, date_debut, date_fin, date_emprunt, date_retour
FROM Resa
WHERE id_employe IS NOT NULL AND id_employe != ''
  AND id_exemplaire IS NOT NULL AND id_exemplaire != ''
  AND date_debut IS NOT NULL AND date_debut != ''
  AND date_fin IS NOT NULL AND date_fin != ''
  AND (date_emprunt IS NULL OR date_emprunt >= date_debut)
  AND (date_emprunt IS NULL OR date_fin >= date_emprunt)
  AND (date_retour IS NULL OR date_emprunt IS NULL OR date_retour >= date_emprunt);

INSERT INTO SousCategories VALUES (1, 3, 'projecteurs', NULL);
INSERT INTO SousCategories VALUES (2, 5, 'CD', NULL);
INSERT INTO SousCategories VALUES (3, 3, 'projecteurs professionnels', 1);
INSERT INTO SousCategories VALUES (4, 5, 'CD musique', 2);
--Question 4 (Vues)
--Creation des Vues;
--Employes
CREATE VIEW Employes AS
SELECT
	e.id_employe,
	e.nom,
	e.mail,
	e.telephone_employe,
	COUNT(r.id_reservation) AS nb_emprunts_en_cours
FROM Employes_base e
LEFT JOIN Reservations r ON e.id_employe = r.id_employe
WHERE r.date_emprunt IS NULL AND r.date_retour IS NULL
GROUP BY e.id_employe, e.nom_employe;

--Materiels
CREATE VIEW Materiels AS
SELECT
    m.id_materiel,
    m.libelle_materiel,
    COUNT(r.id_reservation) AS nb_emprunts_en_cours
FROM Materiels_base m
JOIN Exemplaires ex ON m.id_materiel = ex.id_materiel
LEFT JOIN Reservations r ON ex.id_exemplaire = r.id_exemplaire
WHERE r.date_emprunt IS NULL AND r.date_retour IS NULL
GROUP BY m.id_materiel, m.libelle_materiel;
																								
																		
