-- Drop existing tables (if they exist) in reverse order of creation
DROP TABLE IF EXISTS Interventions;
DROP TABLE IF EXISTS Panneaux;
DROP TABLE IF EXISTS Sentiers;
DROP TABLE IF EXISTS Techniciens;


CREATE TABLE IF NOT EXISTS Techniciens (
	num_technicien	INTEGER NOT NULL,
	pseudo_technicien	TEXT NOT NULL,
	telephone_technicien	TEXT NOT NULL,
	email_technicien	TEXT NOT NULL,
	CONSTRAINT pk_techniciens PRIMARY KEY(num_technicien),
	CONSTRAINT ch_techniciens CHECK(num_technicien > 0)
);
CREATE TABLE IF NOT EXISTS Sentiers (
	num_sentier	INTEGER NOT NULL,
	commune_sentier	TEXT NOT NULL,
	lieudit_sentier	TEXT NOT NULL,
	CONSTRAINT pk_sentiers PRIMARY KEY(num_sentier),
	CONSTRAINT ch_sentiers CHECK(num_sentier > 0)
);
CREATE TABLE IF NOT EXISTS Panneaux (
	num_panneau	INTEGER NOT NULL,
	commune_panneau	TEXT NOT NULL,
	lieudit_panneau	TEXT NOT NULL,
	num_sentier	INTEGER NOT NULL,
	CONSTRAINT pk_panneaux PRIMARY KEY(num_panneau),
	CONSTRAINT fk_panneaux_sentiers FOREIGN KEY(num_sentier) REFERENCES Sentiers(num_sentier),
	CONSTRAINT ch_panneaux CHECK(num_panneau > 0)
);
CREATE TABLE IF NOT EXISTS Interventions (
	num_technicien	INTEGER NOT NULL,
	num_sentier	INTEGER NOT NULL,
	date_intervention	DATE NOT NULL,
	type_intervention	TEXT NOT NULL,
	duree_intervention	REAL NOT NULL,
	commentaire_intervention TEXT NOT NULL DEFAULT 'Rien à signaler',
	CONSTRAINT pk_interventions PRIMARY KEY(num_technicien, num_sentier, date_intervention),
	CONSTRAINT fk_interventions_techniciens FOREIGN KEY(num_technicien) REFERENCES Techniciens(num_technicien),
	CONSTRAINT fk_interventions_sentiers FOREIGN KEY(num_sentier) REFERENCES Sentiers(num_sentier),
	CONSTRAINT ch_interventions CHECK (0 < duree_intervention AND duree_intervention < 8) 
);

INSERT INTO Techniciens (num_technicien,pseudo_technicien,telephone_technicien,email_technicien) 
VALUES 
 (1,'Alexis','+3361234567','alexis@example.com'),
 (2,'Marie','+3369876543','marie@example.com'),
 (3,'Théo','+3361122334','theo@example.com');
INSERT INTO Sentiers (num_sentier,commune_sentier,lieudit_sentier) 
VALUES 
 (1,'Saou','Pomerolle'),
 (2,'Léoncel','Roc Toulaud'),
 (3,'La Chapelle En Vercors','Revoulat'),
 (4,'Romans Sur Isère','La Martinette'),
 (5,'Correçon En Vercors','Centre Village'),
 (6,'Chateau Bernard','Les Moulins'),
 (7,'Chateau Bernard','Playnet'),
 (8,'Chateau Bernard','Pas de la Balme'),
 (9,'Crest','Vaunaveys');
INSERT INTO Panneaux (num_panneau,commune_panneau,lieudit_panneau,num_sentier) 
VALUES 
 (1,'Léoncel','Le grand virage',2),
 (2,'Léoncel','Le lac',2),
 (3,'Léoncel','Plateau d’Ambel',2),
 (4,'Léoncel','Tête de la dame',2),
 (5,'Léoncel','Pas du Gouillat',2),
 (6,'Léoncel','Grand Veymont',2),
 (7,'Léoncel','Ravin de Pissebille',2);
 

INSERT INTO Interventions (num_technicien,num_sentier,date_intervention,type_intervention,duree_intervention,commentaire_intervention) 
VALUES 
 (2,2,'2023-02-02','Vérification des panneaux',7.0,'Tout vérifié'),
 (3,4,'2024-03-27','Repeinte des marques au sol',3.0,'couleurs : blanc, jaune et rouge');
 
INSERT INTO Interventions (num_technicien,num_sentier,date_intervention,type_intervention,duree_intervention) 
VALUES 
 (3,4,'2023-02-10','Débroussaillage',4.5),
 (1,5,'2024-03-19','Taille d''arbres',6.0),
 (2,6,'2024-03-20','Débroussaillage',5.0),
 (3,7,'2024-03-21','Pose de garde-corps',6.5),
 (1,8,'2024-03-22','Vérification des garde-corps',3.0),
 (2,9,'2024-03-23','Pose d’échelles',4.0),
 (2,9,'2024-03-24','Manutention des échelles',6.0),
 (1,2,'2024-03-25','Vérification du balisage',5.0),
 (2,3,'2024-03-26','Re-positionnement des balises',2.0);
	
