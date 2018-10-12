-- ======================================
-- Concert Database Creation
-- SQL script: concert_ddl.sql
-- Database and tables creation
-- Leila Saoud
-- ======================================


CREATE SCHEMA CONCERTS_BXL ;

-- ======================
-- Creating domains
-- ======================

CREATE DOMAIN DID char(10) ;

CREATE DOMAIN DNOM char(25) ;

CREATE DOMAIN DPRENOM char(15) ;

CREATE DOMAIN DTELEPHONE char(16) ;

CREATE DOMAIN DEMAIL char(50) ;

CREATE DOMAIN DEAN integer(13) ;

-- ======================
-- Concerts table
-- ======================

CREATE table CONCERT (
ID_Concert DID NOT NULL,
Date date NOT NULL,
Heure_Debut time(0) NOT NULL,
Heure_Fin time(0) NOT NULL,
ID_Salle DID NOT NULL,
PRIMARY KEY (ID_Concert),
UNIQUE (Date, Heure_Debut, Heure_Fin, ID_Salle),
FOREIGN KEY (ID_Salle) REFERENCES SALLE
) ;

-- ======================
-- Tickets table
-- ======================

CREATE table TICKET (
Num_ticket DID NOT NULL,
ID_Categorie DID NOT NULL,
ID_Concert DID NOT NULL,
ID_Societe DID NOT NULL,
Num_Client DID NOT NULL,
PRIMARY KEY (Num_Ticket),
FOREIGN KEY (Num_Client) REFERENCES SPECTATEUR,
FOREIGN KEY (ID_Societe) REFERENCES SOCIETE,
FOREIGN KEY (ID_Categorie) REFERENCES CATEGORIE,
FOREIGN KEY (ID_Concert) REFERENCES CONCERT
) ;

-- ======================
-- Tickets categories table
-- ======================

CREATE table CATEGORIE (
ID_Categorie DID NOT NULL,
Nom DNOM NOT NULL,
Prix decimal(6,2) NOT NULL,
Nombre_Place integer(5) NOT NULL,
PRIMARY KEY (ID_Categorie)
) ;

-- ======================
-- Resellers table
-- ======================

CREATE table SOCIETE (
ID_Societe DID NOT NULL,
Nom DNOM NOT NULL,
ID_Adresse DID NOT NULL,
Telephone DTELEPHONE NOT NULL,
PRIMARY KEY (ID_Societe),
FOREIGN KEY (ID_Adresse) REFERENCES ADRESSE
) ;

-- ======================
-- Sponsors table
-- ======================

CREATE table SPONSOR (
ID_Societe DID NOT NULL,
ID_Concert DID NOT NULL,
Type_Offre char(50) NOT NULL,
PRIMARY KEY (ID_Societe, ID_Concert, Type_Offre),
FOREIGN KEY (ID_Societe) REFERENCES SOCIETE,
FOREIGN KEY (ID_Concert) REFERENCES CONCERT
) ;

-- ======================
-- Customers table
-- ======================

CREATE table SPECTATEUR (
Num_Client DID NOT NULL,
Nom DNOM NOT NULL,
Prenom DPRENOM NOT NULL,
ID_Adresse DID,
Telephone DTELEPHONE,
E_mail DEMAIL NOT NULL,PRIMARY KEY (Num_Client),
FOREIGN KEY (ID_Adresse) REFERENCES ADRESSE
) ;

-- ======================
-- Concert halls table
-- ======================

CREATE table SALLE (
ID_Salle DID NOT NULL,
Nom_Lieu char(50) NOT NULL,
Nom_Salle char(50) NOT NULL,
Capacite integer(5) NOT NULL,
PRIMARY KEY (ID_Salle),
FOREIGN KEY (Nom_Lieu) REFERENCES LIEU_CULTUREL
) ;

-- ======================
-- Venues table
-- ======================

CREATE table LIEU_CULTUREL (
Nom_Lieu char(50) NOT NULL,
ID_Adresse DID NOT NULL,
Telephone DTELEPHONE NOT NULL,
Hor_Heure_Ouverture time(0) NOT NULL,
Hor_Heure_Fermeture time(0) NOT NULL,
PRIMARY KEY (Nom_Lieu),
FOREIGN KEY (ID_Adresse) REFERENCES ADRESSE
) ;

-- ======================
-- Jobs table
-- ======================

CREATE table TRAVAIL (
Nom_Lieu DID NOT NULL,
ID_Employe DID NOT NULL,
PRIMARY KEY (ID_Employe, Nom_Lieu),
FOREIGN KEY (ID_Employe) REFERENCES MEMBRE_EQUIPE,
FOREIGN KEY (Nom_Lieu) REFERENCES LIEU_CULTUREL
) ;

-- ======================
-- Venues' employees table
-- ======================

CREATE table MEMBRE_EQUIPE (
ID_Employe DID NOT NULL,
Nom DNOM NOT NULL,
Prenom DPRENOM NOT NULL,D_Adresse DID NOT NULL,
Salaire decimal(7,2) NOT NULL,
Telephone DTELEPHONE NOT NULL,
E_mail DEMAIL NOT NULL,
Fonction char(25) NOT NULL,
PRIMARY KEY (ID_Employe),
FOREIGN KEY (ID_Adresse) REFERENCES ADRESSE
) ;

-- ======================
-- Venue' equipment table
-- ======================

CREATE table OUTIL_SALLE (
ID_Employe DID NOT NULL,
Code_EAN DEAN NOT NULL,
PRIMARY KEY (ID_Employe, Code_EAN),
FOREIGN KEY (ID_Employe) REFERENCES MEMBRE_EQUIPE,
FOREIGN KEY (Code_EAN) REFERENCES EQUIPEMENT
) ;

-- ======================
-- Equipment table
-- ======================

CREATE table EQUIPEMENT (
Code_EAN DEAN NOT NULL,
Nom_Produit char(50) NOT NULL,
Type char(32) NOT NULL,
PRIMARY KEY (Code_EAN)
) ;

-- ======================
-- Performances table
-- ======================

CREATE table PRESTATION (
ID_Artiste DID NOT NULL,
ID_Concert DID NOT NULL,
Partie integer(1) NOT NULL,
PRIMARY KEY (ID_Artiste, ID_Concert),
FOREIGN KEY (ID_Artiste) REFERENCES ARTISTE,
FOREIGN KEY (ID_Concert) REFERENCES CONCERT
) ;

-- ======================
-- Artists table
-- ======================

CREATE table ARTISTE (
ID_Artiste DID NOT NULL,
Nom DNOM NOT NULL,
Prenom DPRENOM NOT NULL,
Nom_Scene char(50),
Telephone DTELEPHONE NOT NULL,
Pays_Origine char(2) NOT NULL,
Cachet decimal(10,2) NOT NULL,
PRIMARY KEY (ID_Artiste)
) ;

-- ======================
-- Invitations table
-- ======================

CREATE table INVITATION (
ID_Artiste DID NOT NULL,
Num_Client DID NOT NULL,
ID_Concert DID NOT NULL,
PRIMARY KEY (ID_Artiste, Num_Client, ID_Concert),
FOREIGN KEY (ID_Artiste) REFERENCES ARTISTE,
FOREIGN KEY (Num_Client) REFERENCES SPECTATEUR,
FOREIGN KEY (ID_Concert) REFERENCES CONCERT
) ;

-- ======================
-- Artists' crew table
-- ======================

CREATE table ACCOMPAGNEMENT (
ID_Artiste DID NOT NULL,
ID_Staff DID NOT NULL,
PRIMARY KEY (ID_Artiste, ID_Staff ),
FOREIGN KEY (ID_Artiste) REFERENCES ARTISTE,
FOREIGN KEY (ID_Staff ) REFERENCES MEMBRE_STAFF
) ;

-- ======================
-- Staff members table
-- ======================

CREATE table MEMBRE_STAFF (
ID_Staff DID NOT NULL,
Nom DNOM NOT NULL,
Prenom DPRENOM NOT NULL,
Telephone DTELEPHONE,
E_mail DEMAIL NOT NULL,
FONctiON char(25) NOT NULL,
PRIMARY KEY (ID_Staff )
) ;

-- ======================
-- Staff's equipment table
-- ======================

CREATE table OUTIL_STAFF (
ID_Staff DID NOT NULL,
Code_EAN DEAN NOT NULL,
PRIMARY KEY (ID_Staff, Code_EAN),
FOREIGN KEY (ID_Staff ) REFERENCES MEMBRE_STAFF,
FOREIGN KEY (Code_EAN) REFERENCES EQUIPEMENT
) ;

-- ======================
-- Address table
-- ======================

CREATE table ADRESSE (
ID_Adresse DID NOT NULL,
Rue char(32) NOT NULL,
Code_Postal char(9) NOT NULL,
Ville char(25) NOT NULL,
PRIMARY KEY (ID_Adresse),
UNIQUE (Rue, Code_Postal, Ville)
) ;

-- ======================
-- Adding indexes
-- ======================

CREATE index IND_EQUIPE
ON MEMBRE_EQUIPE (Nom) ;

CREATE index IND_SOCIETE
ON SOCIETE (Nom) ;

CREATE index IND_SPECTATEUR
ON SPECTATEUR (Nom) ;

CREATE index IND_ARTISTE
ON ARTISTE (Nom_Scene) ;

CREATE index IND_EQUIPEMENT
ON EQUIPEMENT (Nom_Produit) ;
