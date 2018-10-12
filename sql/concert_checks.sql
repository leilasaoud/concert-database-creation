-- ======================================
-- Concert Database Creation
-- SQL script: concert_checks.sql
-- Adding checks
-- Leila Saoud
-- ======================================


-- Opening hour must be before the closing hour

ALTER TABLE LIEU_CULTUREL
ADD CHECK (Hor_Heure_Ouverture < Hor_Heure_Fermeture) ;

-- A concert' starting hour must be before it ending hour

ALTER TABLE CONCERT
ADD CHECK (Heure_Debut < Heure_FIN) ;

-- Added concert's date must be between 1 year ago and 2 years in the future
ALTER TABLE CONCERT
ADD CHECK (
    Date >= date(’now’,’-1 year’)
    AND Date <= date(’now’,’+2 years’)
    ) ;

-- Ticket price must be greater or equal to 0 (some concerts are free)

ALTER TABLE CATEGORIE
ADD CHECK (Prix >= 0) ;

-- Employees' salary must be greater or equal to 0 (some are volunteers)
-- Their job category is either technician or corporate

ALTER TABLE MEMBRE_EQUIPE
ADD CHECK (Salaire >= 0)
ADD CHECK (Fonction IN (’Technicien’, ’Organisation’)) ;

-- Artists' staff members can be either agents, musicians, technicians or other

ALTER TABLE MEMBRE_STAFF
ADD CHECK (Fonction IN (’Agent’, ’Musicien’, ’Technicien’,’Autre’)) ;

-- An artist must be paid (salary greater than 0, union rules)

ALTER TABLE ARTISTE
ADD CHECK (Cachet>= 0) ;

-- A performance is either the opening (1) or main act (2)

ALTER TABLE PRESTATION
ADD CHECK (Partie IN (’1’,’2’)) ;

-- Concert halls' capacity must be greater than 0

ALTER TABLE SALLE
ADD CHECK (Capacite > 0)

-- Equipment must be one of 3 types (sound OR light OR Staging and accessories):

ALTER TABLE EQUIPEMENT
ADD CHECK (Type IN (’Son’,’Lumière’,’Décor et accessoires’)) ;
