DROP TABLE IF EXISTS Remontees;
DROP TABLE IF EXISTS Pistes;
DROP TABLE IF EXISTS Horaires;


CREATE TABLE IF NOT EXISTS Pistes (
  nomP TEXT PRIMARY KEY,
  difficulte TEXT,
  longueur INTEGER,
  CONSTRAINT ck_difficulte CHECK (difficulte IN ('vert', 'bleu', 'rouge', 'noire'))
);

CREATE TABLE IF NOT EXISTS Horaires (
  altitude TEXT PRIMARY KEY,
  ouverture DATE,
  fermeture DATE,
  CONSTRAINT ck_altitute CHECK (altitude IN ('haute', 'moyenne', 'basse'))
);

CREATE TABLE IF NOT EXISTS Remontees (
  nomR TEXT,
  nomP TEXT,
  altitude VARCHAR(6),
  CONSTRAINT pk_remontees PRIMARY KEY (nomR, nomP),
  CONSTRAINT fk_remontees_nomp FOREIGN KEY (nomP) REFERENCES Pistes(nomP),
  CONSTRAINT fk_remontees_altitude FOREIGN KEY (altitude) REFERENCES Horaires(altitude)
);

INSERT INTO Horaires VALUES
   ('haute',   '09:15', '16:15'),
   ('moyenne', '09:00', '16:30'),
   ('basse', '09:00', '16:45');

INSERT INTO Pistes VALUES
   ('Jandri 5', 'bleu', 500),
   ('Puy Salié I', 'bleu', 600),
   ('Jandri 4', 'bleu', 1200),
   ('Glacier 1', 'rouge', 600),
   ('Glacier 2', 'bleu', 350),
   ('Glacier 3', 'rouge', 800),
   ('Glacier 4', 'rouge', 150),
   ('Glacier 5', 'rouge', 300),
   ('Jandri 3', 'bleu', 200),
   ('Sautet', 'bleu', 150),
   ('Pierre Grosse 1', 'bleu', 1400),
   ('Pierre Grosse 2', 'rouge', 1000),
   ('Toura 1', 'bleu', 800),
   ('Toura 2', 'bleu', 700),
   ('Diable 1', 'noire', 666),
   ('Jandri 1', 'bleu', 700),
   ('Jandri 2', 'bleu', 800),
   ('Petites Crêtes', 'vert', 750);
   
 INSERT INTO Remontees VALUES 
   ('Diable', 'Diable 1', 'basse'),
   ('Diable', 'Jandri 1', 'basse'),
   ('Diable', 'Petites Crêtes', 'basse'),
   ('Crêtes', 'Petites Crêtes', 'basse'),
   ('Jandri Express 1', 'Jandri 3', 'moyenne'),
   ('Jandri Express 1', 'Pierre Grosse 1', 'moyenne'),
   ('Jandri Express 1', 'Toura 1', 'moyenne'),
   ('Jandri Express 1', 'Toura 2', 'moyenne'),
   ('Toura', 'Toura 1', 'moyenne'),
   ('Toura', 'Toura 2', 'moyenne'),
   ('Envers', 'Toura 1', 'moyenne'),
   ('Envers', 'Toura 2', 'moyenne'),
   ('Pierre Grosse', 'Glacier 5', 'haute'),
   ('Jandri Express 2', 'Jandri 4', 'haute'),
   ('Jandri Express 2', 'Jandri 5', 'haute'),
   ('Jandri Express 2', 'Glacier 1', 'haute');
