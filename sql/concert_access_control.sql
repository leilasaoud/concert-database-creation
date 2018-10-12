-- ======================================
-- Concert Database Creation
-- SQL script: concert_access_control.sql
-- Access control definition
-- Leila Saoud
-- ======================================

-- Customers can access and search future concerts view

GRANT SELECT
ON VUE_CONCERTS
TO public ;

-- Resellers can access info about concerts and modify data about customers and tickets

CREATE ROLE SOCIETES ;

GRANT ALL PRIVILEGES
ON SPECTATEUR
TO SOCIETES ;

GRANT SELECT, UPDATE, INSERT
ON ADRESSE
TO SOCIETES ;

GRANT SELECT
ON CONCERT
TO SOCIETES ;

GRANT SELECT, UPDATE, INSERT
ON TICKET
TO SOCIETES ;

-- Venues' employees can access info about equipment and about artists' staff

CREATE ROLE EQUIPE ;

GRANT SELECT
ON EQUIPEMENT
TO EQUIPE WITH GRANT OPTION ;

GRANT SELECT (NOM, PRENOM, FONCTION)
ON MEMBRE_STAFF
TO EQUIPE
WITH GRANT OPTION ;
