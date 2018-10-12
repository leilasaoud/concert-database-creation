-- ======================================
-- Concert Database Creation
-- SQL script: concert_triggers.sql
-- Adding triggers
-- Leila Saoud
-- ======================================


-- Concerts can't start after venues' opening time  : horaires ouverture => TRIGGER

CREATE TRIGGER VERIF_HORAIRES
BEFORE INSERT OR UPDATE ON CONCERT
FOR EACH ROW
DECLARE h_ouv integer, h_ferm integer
BEGIN
	SELECT Hor_Heure_Ouverture INTO: h_ouv, Hor_Heure_Fermeture INTO: h_ferm
	FROM CONCERT C, SALLE S, LIEU_CULTUREL L
	WHERE ID_Concert = new.ID_CONcert
	AND C.ID_Salle = S.ID_Salle
	AND S.Nom_Lieu = L.Nom_lieu;
	IF (new.Heure_Debut < h_ouv AND new.Heure_Debut > h_ferm
	    AND new.Heure_Fin < h_ouv AND new.Heure_Fin > h_ferm)
	THEN RAISE EXCEPTION 001 'Erreur horaires'
	END IF;
END;

-- Artist can't perform at two venues at the same time

CREATE TRIGGER VERIF_ARTISTE
BEFORE INSERT OR UPDATE ON PRESTATION
FOR EACH ROW
DECLARE N integer
BEGIN
	SELECT count(*) INTO:N
	FROM PRESTATION P, CONCERT C
	WHERE Code_Artiste = new.Code_Artiste
	AND Date=new.Date
	AND Heure_Debut >= new.Heure_Debut
	AND Heure_Fin <= new.Heure_Fin
	AND P.ID_Concert = C.ID_Concert;
	IF (N > 1)
	THEN RAISE EXCEPTION 002 'Artiste preste autre concert'
	END IF;
END;

-- Can't sell more tickets than venues' capacity

CREATE TRIGGER VERIF_CAPACITE
BEFORE INSERT ON TICKET
FOR EACH ROW
DECLARE M integer, N integer
BEGIN
		SELECT count(*) INTO:M, Capacite INTO:N
		FROM TICKET T, CONCERT C, SALLE S
		WHERE ID_Concert = new.ID_Concert
		AND T.ID_Concert = C.ID_Concert
		AND C.ID_Salle= S.ID_Salle;
		IF (M >= N)
				THEN RAISE EXCEPTION 003 'Capacité de salle excédée'
		END IF;
END;

-- Can't exceed tickets category

CREATE TRIGGER VERIF_CAPACITE
BEFORE INSERT ON TICKET
FOR EACH ROW
DECLARE M integer, N integer
BEGIN
		SELECT count(*) INTO:M, Nombre_Places INTO:N
		FROM CATEGORIE CA, TICKET T
		WHERE ID_Categorie = new.ID_Categorie
		AND ID_Concert = new.ID_Concert
		AND CA.ID_Categorie = T.ID_Categorie;
		IF (M >= N)
				THEN RAISE EXCEPTION 004 'Plus de tickets de cette catégorie disponibles'
		END IF;
END;

-- Customers can't buy more than 10 tickets per concert

CREATE TRIGGER LIMITE_ACHAT
BEFORE INSERT ON TICKET
FOR EACH ROW
DECLARE N integer
BEGIN
  	SELECT count(*) INTO:N,
		FROM SPECTATEUR SE, TICKET T
		WHERE ID_Concert = new.ID_Concert
		AND T.Num_Client = new.Num_Client
		AND SE.Num_Client = T.Num_Client
		IF (N > 10)
				THEN RAISE EXCEPTION 005 'Client a déjà acheté 10 tickets'
		END IF;
END;

-- Artists can't invite more than 10 people

CREATE TRIGGER LIMITE_INVITE
BEFORE INSERT ON INVITATION
FOR EACH ROW
DECLARE N integer
BEGIN
		SELECT count(*) INTO:N,
		FROM Invitation
		WHERE ID_Concert = new.ID_Concert
		AND Code_Artiste = new.Code_Artiste
		IF (N > 10)
				THEN RAISE EXCEPTION 006 'Artiste a déjà 10 invités'
		END IF;
END;
