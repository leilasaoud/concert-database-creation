-- ======================================
-- Concert Database Creation
-- SQL script: concert_views.sql
-- Views creation
-- Leila Saoud
-- ======================================


-- List all future concerts in Brussels with info about artists and venues

CREATE VIEW VUE_CONCERTS (
    ID_Artiste,
    Nom_Scene,
    Partie,
    Pays_Origine,
    Nom_Lieu,
    ID_Salle,
    Nom_Salle,
    ID_Concert,
    Date,
    Heure_Debut,
    Heure_Fin)
AS SELECT
    P.ID_Artiste,
    Nom_Scene,
    Partie,
    Pays_Origine,
    S.Nom_Lieu,
    C.ID_Salle,
    Nom_Salle,
    P.ID_Concert,
    Date,
    Heure_Debut,
    HEURE_Fin
FROM PRESTATION P, ARTISTE A, CONCERT C, SALLE S
WHERE Date >= date(’now’)
AND P.ID_Artiste = A.ID_Artiste
AND P.ID_Concert = C.ID_Concert
AND C.ID_Salle = S.ID_Salle
ORDER BY Date, ID_Concert ;

-- List all venues where concerts were organized in 2017

CREATE VIEW CONCERTS_2017 (
    Nom_Lieu,
    ID_Salle,
    ID_Concert,
    Date)
AS SELECT
    Nom_Lieu,
    C.ID_Salle,
    ID_Concert,
    Date
FROM CONCERT C, SALLE S
WHERE S.ID_Salle = C.ID_Salle
AND date > ‘31-12-2016’
AND date < ‘1-1-2018’
ORDER BY Nom_Lieu, C.ID_Salle, Date ;

-- List number of tickets sold by each reseller for each concert

CREATE VIEW VENTE_TICKET (
    ID_Concert,
    ID_Societe,
    Nom,
    COUNT(Num_Ticket))
AS SELECT
    ID_Concert,
    T.ID_Societe,
    Nom,
    COUNT(Num_Ticket)
FROM TICKET T, SOCIETE SO
WHERE T.ID_Societe = SO.ID_Societe
GROUP BY ID_Concert, T.ID_Societe ;
