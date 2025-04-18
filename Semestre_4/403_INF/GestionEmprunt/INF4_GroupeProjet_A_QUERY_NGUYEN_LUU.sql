--1. Quelles sont les catégories de matériel réservés par l’employé ’Martin’ ?
SELECT DISTINCT e.nom_employe, c.libelle_categorie
FROM Reservations r
JOIN Employes_base e ON r.id_employe = e.id_employe
JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
JOIN Materiels_base m ON ex.id_materiel = m.id_materiel
JOIN Categories c ON m.id_categorie = c.id_categorie
WHERE e.nom_employe = 'Martin';

--2. Quels employés ont réservé l’appareil photo compact (id materiel=37) et l’appareil photo reflex (id materiel=38) ?
SELECT e.id_employe, e.nom_employe
FROM Employes_Base e
WHERE e.id_employe IN (
	SELECT r.id_employe
	FROM Reservations r JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
	WHERE ex.id_materiel = 37)
	AND e.id_employe IN (
	SELECT r.id_employe
	FROM Reservations r JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
	WHERE ex.id_materiel = 38);

--3. Combien d’employés ont réservé l’appareil photo compact (id materiel=37) ou l’appareil photo reflex (id materiel=38) ?
SELECT COUNT(e.id_employe)
FROM Employes_Base e
WHERE e.id_employe IN (
	SELECT r.id_employe
	FROM Reservations r JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
	WHERE ex.id_materiel = 37)
	OR e.id_employe IN (
	SELECT r.id_employe
	FROM Reservations r JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
	WHERE ex.id_materiel = 38);

--4. Quels employés n’ont rien réservé ?
SELECT id_employe, nom_employe
FROM Employes_base
WHERE id_employe NOT IN (
	SELECT DISTINCT id_employe
	FROM Reservations
);

--5. Quels employés ont réservé au moins 1 matériel de chaque catégorie (votre résultat doit comprendre 197 employés) ?
SELECT e.id_employe, e.nom_employe
FROM Employes_Base e JOIN Reservations r USING (id_employe)
            	JOIN Exemplaires ex USING (id_exemplaire)
            	JOIN Materiels_base	m Using (id_materiel)
            	JOIN Categories c USING (id_categorie)
GROUP BY e.id_employe, e.nom_employe
HAVING count(DISTINCT c.id_categorie) = (SELECT count(*) FROM Categories);

--6. Quel est le nombre d’exemplaires de chaque matériel (donner l’id et libellé) ?
SELECT m.id_materiel, m.libelle_materiel, COUNT(*) AS nb_exemplaires
FROM Exemplaires ex
JOIN Materiels_base m ON ex.id_materiel = m.id_materiel
GROUP BY m.id_materiel, m.libelle_materiel;

--7. Quels employés ont fait au moins 60 réservations ?
SELECT e.id_employe, e.nom_employe, COUNT(r.id_reservation) AS nombre_reservations
FROM Employes_base e JOIN Reservations r ON e.id_employe = r.id_employe
GROUP BY e.id_employe, e.nom_employe
HAVING COUNT(r.id_reservation) >= 60;

--8. Quels employés ont emprunté au moins 2 fois la perceuse (id materiel=20) ?
SELECT e.id_employe, e.nom_employe, COUNT(r.id_reservation) AS nombre_emprunts_reels_perceuse
FROM Employes_base e
JOIN Reservations r ON e.id_employe = r.id_employe
JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
WHERE ex.id_materiel = 20 
GROUP BY e.id_employe, e.nom_employe
HAVING COUNT(r.id_reservation) >= 2;

--9. Quel matériels ont été réservés le plus longtemps (sur 1 seule réservation) ?
WITH Durees AS (
  SELECT
	ex.id_materiel,
	m.libelle_materiel,
	r.id_reservation,
	CAST(julianday(r.date_fin) - julianday(r.date_debut) AS INTEGER) AS duree
  FROM Reservations r
  JOIN Exemplaires ex ON r.id_exemplaire = ex.id_exemplaire
  JOIN Materiels_base m ON ex.id_materiel = m.id_materiel
  WHERE r.date_debut IS NOT NULL AND r.date_fin IS NOT NULL
)
SELECT id_materiel, libelle_materiel, id_reservation, duree
FROM Durees
WHERE duree = (SELECT MAX(duree) FROM Durees);

--10. Quels sont les exemplaires (et le nom du matériel) qui ont été réservés le plus de fois ?
WITH X AS (
  SELECT
	r.id_exemplaire,
	m.libelle_materiel,
	COUNT(*) AS count_reservation
  FROM Reservations r
  JOIN Exemplaires e ON r.id_exemplaire = e.id_exemplaire
  JOIN Materiels_base m ON e.id_materiel = m.id_materiel
  GROUP BY r.id_exemplaire, m.libelle_materiel
),
MaxCount AS (
  SELECT MAX(count_reservation) AS max_resa FROM X
)
SELECT x.*
FROM X x JOIN MaxCount m ON x.count_reservation = m.max_resa;
