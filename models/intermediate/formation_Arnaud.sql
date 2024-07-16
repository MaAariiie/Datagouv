WITH  table_format AS (
SELECT *,
CASE WHEN alternant_adresse_code_postal = "LYON" THEN "69000"
WHEN alternant_adresse_code_postal = "PARIS" THEN "75000"
WHEN alternant_adresse_code_postal = "DIJON" THEN "21000"
WHEN alternant_adresse_code_postal = "VANNES" THEN "26000"
WHEN alternant_adresse_code_postal = "LILLE" THEN "59000"
WHEN alternant_adresse_code_postal = "Cergy" THEN "95000"
WHEN alternant_adresse_code_postal = "NOGEN" THEN "94130"
WHEN alternant_adresse_code_postal = "OSNY" THEN "95520"
WHEN alternant_adresse_code_postal = "BLOIS" THEN "41000"
WHEN alternant_adresse_code_postal = "ANGER" THEN "49000"
WHEN alternant_adresse_code_postal = "GAGNY" THEN "93220"
WHEN alternant_adresse_code_postal = "NIORT" THEN "79000"
WHEN alternant_adresse_code_postal = "LORIENT" THEN "56100"
WHEN alternant_adresse_code_postal = "Ivry" THEN "94205"
ELSE alternant_adresse_code_postal
END AS alternant_adresse_code_postalv1
FROM {{ source('Datagouv', 'contrat_deca_test') }}
),

code_postal_tab AS (
SELECT *,
SAFE_CAST(alternant_adresse_code_postalv1 AS INT64) AS alternant_adresse_code_postalv2,
FROM table_format
),

code_postal_tabb AS (
SELECT *,
CAST(alternant_adresse_code_postalv2 AS STRING) AS alternant_code_postal_bis,
CAST(employeur_adresse_code_postal AS STRING) AS employeur_code_postal_bis,
FROM code_postal_tab
),

code_postal_tab_bis AS (
SELECT *,
CASE WHEN CHAR_LENGTH(alternant_code_postal_bis) < 4 THEN ""
WHEN CHAR_LENGTH(alternant_code_postal_bis) >= 4 THEN alternant_code_postal_bis
END AS alternant_code_postal_bis2
FROM code_postal_tabb
),

code_postal_tab2 AS (SELECT *, 
CASE WHEN CHAR_LENGTH(alternant_code_postal_bis2) = 4 THEN CONCAT(0,alternant_code_postal_bis2)
WHEN CHAR_LENGTH(alternant_code_postal_bis2) != 4 THEN alternant_code_postal_bis2
END AS alternant_code_postal_cleanV1,
CASE WHEN CHAR_LENGTH(employeur_code_postal_bis) = 4 THEN CONCAT(0,employeur_code_postal_bis)
WHEN CHAR_LENGTH(employeur_code_postal_bis) != 4 THEN employeur_code_postal_bis
END AS employeur_code_postal_clean
FROM code_postal_tab_bis
),

code_postal_tab2_bis AS (SELECT *, 
CASE WHEN alternant_code_postal_cleanV1 LIKE "00%" THEN ""
ELSE alternant_code_postal_cleanV1
END AS alternant_code_postal_cleanv2
FROM code_postal_tab2 
),

code_postal_tab2_ter AS (
SELECT *, 
CASE WHEN alternant_code_postal_cleanv2 = "" then null
ELSE alternant_code_postal_cleanv2
END AS alternant_code_postal_clean
FROM code_postal_tab2_bis
)

SELECT id_alternant, 
numero_contrat, 
alternant_date_naissance, 
alternant_sexe, 
alternant_code_postal_clean,
formation_intitule_ou_qualification, 
titre_diplome_groupe, 
formation_date_debut, 
formation_date_fin, 
date_debut_contrat, 
date_fin_contrat, 
date_effet_rupture, 
employeur_code_postal_clean,
employeur_nombre_de_salaries, 
type_employeur_libelle
FROM code_postal_tab2_ter 
ORDER BY alternant_code_postal_clean ASC


