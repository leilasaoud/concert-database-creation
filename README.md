# Concert Database Creation

A database to manage concert venues in Brussels.

## Preview

![Alt text](schemas/concert_logical_schema.jpg?raw=true "Conceptual schema")

- [Conceptual schema](schemas/concert_conceptual_schema.pdf)
- [Logical schema](schemas/concert_logical_schema.pdf)

## Content

- [SQL DDL](sql/concert_ddl.sql)
- [SQL checks](sql/concert_checks.sql)
- [SQL triggers](sql/concert_triggers.sql)
- [SQL access control](sql/concert_access_control.sql)
- [SQL views](sql/concert_views.sql)

## Example query

```
# Show all future Lady Gaga concerts
SELECT
    Nom_Scene,
    Partie,
    S.Nom_Lieu,
    Nom_Salle,
    Date,
    Heure_Debut,
    HEURE_Fin
FROM PRESTATION P
INNER JOIN ARTISTE A ON P.ID_Artiste = A.ID_Artiste
INNER JOIN CONCERT C ON P.ID_Concert = C.ID_Concert
INNER JOIN SALLE S ON C.ID_Salle = S.ID_Salle
WHERE Nom_Scene LIKE '%lady gaga%'
ORDER BY Date;
```

## Purpose

This database is meant to be used by all stakeholders involved with concerts in Brussels to facilitate management, updating and information sharing.

This database could help with numerous stakeholders, notably:
- customers, who would benefit from a more streamlined search;
- resellers, thanks to a common ticket format;
- artists and their teams, who could quickly compare venues (based on capacity for instance).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
