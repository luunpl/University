---------------------------------------------------------------
-----------------  DROPS ------------------------------------
---------------------------------------------------------------
DROP TABLE IF EXISTS Frequents;
DROP TABLE IF EXISTS Sells;
DROP TABLE IF EXISTS Likes;
DROP TABLE IF EXISTS Beers;
DROP TABLE IF EXISTS Bars;
DROP TABLE IF EXISTS Drinkers;

---------------------------------------------------------------
-----------------  CREATES ------------------------------------
---------------------------------------------------------------
PRAGMA foreign_keys = ON; -- Activation de FKs en SQlite

CREATE TABLE Beers (
  name_beer TEXT NOT NULL, --NOT NULL pas nécessaire pour un attribut clé dans certains SGBD
  manufacturer_beer TEXT,
  CONSTRAINT beers_c0 PRIMARY KEY (name_beer)
);

CREATE TABLE Bars (
	name_bar TEXT NOT NULL, 
	address_bar TEXT,
	licence_bar DATE,
	open_date_bar DATE,
	CONSTRAINT bars_c0 PRIMARY KEY (name_bar)
);
CREATE TABLE Drinkers (
	name_drinker TEXT NOT NULL, 
	address_drinker TEXT, 
	phone_drinker TEXT,
	CONSTRAINT drinkers_C0 PRIMARY KEY (name_drinker)
);
CREATE TABLE Frequents (
	name_drinker TEXT NOT NULL, 
	name_bar TEXT NOT NULL,
	CONSTRAINT frequents_c0 PRIMARY KEY (name_drinker, name_bar),
	CONSTRAINT frequents_c1 FOREIGN KEY (name_bar) REFERENCES Bars(name_bar),
	CONSTRAINT frequents_c2 FOREIGN KEY (name_drinker) REFERENCES Drinkers(name_drinker)
);

CREATE TABLE Likes(
  name_drinker TEXT NOT NULL,
  name_beer TEXT NOT NULL,
  CONSTRAINT likes_c0 PRIMARY KEY (name_drinker,name_beer),
  CONSTRAINT likes_c1 FOREIGN KEY (name_beer) REFERENCES Beers(name_beer),
  CONSTRAINT likes_c2 FOREIGN KEY (name_drinker) REFERENCES Drinkers(name_drinker)
);

CREATE TABLE Sells(
  name_bar TEXT NOT NULL,
  name_beer TEXT NOT NULL,
  price_sells REAL NOT NULL,
  CONSTRAINT sells_c0 PRIMARY KEY (name_bar,name_beer),
  CONSTRAINT sells_c1 FOREIGN KEY (name_bar) REFERENCES Bars(name_bar),
  CONSTRAINT sells_c2 FOREIGN KEY (name_beer) REFERENCES Beers(name_beer),
  CONSTRAINT sells_c3 CHECK (price_sells > 0)
);


---------------------------------------------------------------
-----------------  INSERTS ------------------------------------
---------------------------------------------------------------

INSERT INTO Drinkers VALUES ('Adam', 'Randwick ', '9385-4444');
INSERT INTO Drinkers VALUES ('Gernot', 'Newtown', '9415-3378');
INSERT INTO Drinkers VALUES ('John', 'Clovelly', '9665-1234');
INSERT INTO Drinkers VALUES ('Justin', 'Mosman', '9845-4321');
INSERT INTO Drinkers VALUES ('Marie', 'Rose Bay', '9371-2126');
INSERT INTO Drinkers VALUES ('Adrian', 'Redfern', '9371-1244');

INSERT INTO Beers VALUES ('80/-', 'Caledonian');
INSERT INTO Beers VALUES ('Bigfoot Barley Wine', 'Sierra Nevada');
INSERT INTO Beers VALUES ('Burragorang Bock', 'George IV Inn');
INSERT INTO Beers VALUES ('Crown Lager', 'Carlton');
INSERT INTO Beers VALUES ('Fosters Lager', 'Carlton');
INSERT INTO Beers VALUES ('Invalid Stout', 'Carlton');
INSERT INTO Beers VALUES ('Melbourne Bitter', 'Carlton');
INSERT INTO Beers VALUES ('New', 'Toohey''s');
INSERT INTO Beers VALUES ('Old', 'Toohey''s');
INSERT INTO Beers VALUES ('Old Admiral', 'Lord Nelson');
INSERT INTO Beers VALUES ('Pale Ale', 'Sierra Nevada');
INSERT INTO Beers VALUES ('Premium Lager', 'Cascade');
INSERT INTO Beers VALUES ('Red', 'Toohey''s');
INSERT INTO Beers VALUES ('Sheaf Stout', 'Toohey''s');
INSERT INTO Beers VALUES ('Sparkling Ale', 'Cooper''s');
INSERT INTO Beers VALUES ('Stout', 'Cooper''s');
INSERT INTO Beers VALUES ('Three Sheets', 'Lord Nelson');
INSERT INTO Beers VALUES ('Victoria Bitter', 'Carlton');

INSERT INTO Bars VALUES ('Australia Hotel', 'The Rocks', '123456', '1940-01-12 00:00:00');
INSERT INTO Bars VALUES ('Rose Bay Hotel', 'Rose Bay', '966410', '1920-08-31 00:00:00');
INSERT INTO Bars VALUES ('Coogee Bay Hotel', 'Coogee', '966500', '1980-08-31 00:00:00');
INSERT INTO Bars VALUES ('Lord Nelson', 'The Rocks', '123888', '1920-11-11 00:00:00');
INSERT INTO Bars VALUES ('Marble Bar', 'Sydney', '122123', '2001-04-01 00:00:00');
INSERT INTO Bars VALUES ('Regent Hotel', 'Kingsford', '987654', '2000-02-29 00:00:00');
INSERT INTO Bars VALUES ('Royal Hotel', 'Randwick', '938500', '1986-06-26 00:00:00');

INSERT INTO Likes VALUES ('Adam', 'Crown Lager');
INSERT INTO Likes VALUES ('Adam', 'Fosters Lager');
INSERT INTO Likes VALUES ('Adam', 'New');
INSERT INTO Likes VALUES ('Adam', 'Old');
INSERT INTO Likes VALUES ('Gernot', 'Premium Lager');
INSERT INTO Likes VALUES ('Gernot', 'Sparkling Ale');
INSERT INTO Likes VALUES ('John', '80/-');
INSERT INTO Likes VALUES ('John', 'Bigfoot Barley Wine');
INSERT INTO Likes VALUES ('John', 'Pale Ale');
INSERT INTO Likes VALUES ('John', 'Three Sheets');
INSERT INTO Likes VALUES ('Justin', 'Sparkling Ale');
INSERT INTO Likes VALUES ('Justin', 'Victoria Bitter');

INSERT INTO Sells VALUES ('Australia Hotel', 'Burragorang Bock', 3.50);
INSERT INTO Sells VALUES ('Coogee Bay Hotel', 'New', 2.30);
INSERT INTO Sells VALUES ('Coogee Bay Hotel', 'Old', 2.50);
INSERT INTO Sells VALUES ('Coogee Bay Hotel', 'Sparkling Ale', 2.80);
INSERT INTO Sells VALUES ('Coogee Bay Hotel', 'Victoria Bitter', 2.30);
INSERT INTO Sells VALUES ('Lord Nelson', 'Three Sheets', 3.75);
INSERT INTO Sells VALUES ('Lord Nelson', 'Old Admiral', 3.75);
INSERT INTO Sells VALUES ('Marble Bar', 'New', 2.80);
INSERT INTO Sells VALUES ('Marble Bar', 'Old', 2.80);
INSERT INTO Sells VALUES ('Marble Bar', 'Victoria Bitter', 2.80);
INSERT INTO Sells VALUES ('Regent Hotel', 'New', 2.20);
INSERT INTO Sells VALUES ('Regent Hotel', 'Victoria Bitter', 2.20);
INSERT INTO Sells VALUES ('Royal Hotel', 'New', 2.30);
INSERT INTO Sells VALUES ('Royal Hotel', 'Old', 2.30);
INSERT INTO Sells VALUES ('Royal Hotel', 'Victoria Bitter', 2.30);

INSERT INTO Frequents VALUES ('Adam', 'Coogee Bay Hotel');
INSERT INTO Frequents VALUES ('Gernot', 'Lord Nelson');
INSERT INTO Frequents VALUES ('John', 'Australia Hotel');
INSERT INTO Frequents VALUES ('John', 'Coogee Bay Hotel');
INSERT INTO Frequents VALUES ('John', 'Lord Nelson');
INSERT INTO Frequents VALUES ('Justin', 'Marble Bar');
INSERT INTO Frequents VALUES ('Justin', 'Regent Hotel');
INSERT INTO Frequents VALUES ('Marie', 'Rose Bay Hotel');



