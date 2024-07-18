WITH replace_2002 AS (
SELECT *,
REPLACE(CAST(formation_date_debut as STRING),"2002","2022") AS formation_date_debutv2,
REPLACE(CAST(formation_date_fin as STRING),"5025","2025") AS formation_date_finv2,
REPLACE(CAST(date_effet_rupture as STRING),"2002","2022") AS date_effet_rupturev2
FROM {{ref('rupture_jointure_finale')}})
),

replace_2003 AS (
SELECT *,
REPLACE(CAST(formation_date_debutv2 as STRING),"2003","2023") AS formation_date_debutv3,
REPLACE(CAST(formation_date_finv2 as STRING),"3034","2024") AS formation_date_finv3
FROM replace_2002
)
,

replace_2922 AS (
SELECT *,
REPLACE(CAST(formation_date_debutv3 as STRING),"2922","2022") AS formation_date_debutv4,
REPLACE(CAST(formation_date_finv3 as STRING),"2923","2023") AS formation_date_finv4
FROM replace_2003
)
,

replace_2202 AS (
SELECT *,
REPLACE(CAST(formation_date_debutv4 as STRING),"2202","2022") AS formation_date_debutv5,
REPLACE(CAST(formation_date_finv4 as STRING),"2203","2023") AS formation_date_finv5
FROM replace_2922
)
,

replace_2032 AS (
SELECT *,
REPLACE(CAST(formation_date_debutv5 as STRING),"2202","2022") AS formation_date_debutv6,
REPLACE(CAST(formation_date_finv5 as STRING),"2053","2023") AS formation_date_finv6
FROM replace_2202
)
,

replace_2052 AS (
SELECT *,
REPLACE(CAST(formation_date_finv6 as STRING),"2052","2022") AS formation_date_finv7
FROM replace_2032
)
,

replace_2042 AS (
SELECT *,
REPLACE(CAST(formation_date_finv7 as STRING),"2042","2022") AS formation_date_finv8
FROM replace_2052
)
,

replace_2033 AS (
SELECT *,
REPLACE(CAST(formation_date_finv8 as STRING),"2033","2023") AS formation_date_finv9
FROM replace_2042
)
,

replace_1903 AS (
SELECT *,
REPLACE(CAST(formation_date_finv9 as STRING),"1903","2023") AS formation_date_finv10
FROM replace_2033
)
,

string_to_INT AS (
SELECT *, 
CAST(formation_date_debutv6 as DATE) AS formation_date_debutv7,
CAST(formation_date_finv10 as DATE) AS formation_date_finv11,
CAST(date_effet_rupturev2 as DATE) AS date_effet_rupture_clean
FROM replace_1903 
)
,

case_when_tab AS (
SELECT *,
CASE WHEN formation_date_debutv7 <"2019-01-01" then NULL
WHEN formation_date_debutv7 > "2030-01-01" then NULL
ELSE formation_date_debutv7
END AS formation_date_debut_clean,
CASE WHEN formation_date_finv11 <"2019-01-01" then NULL
ELSE formation_date_finv11
END AS formation_date_fin_clean,
FROM string_to_INT
)
,

date_diff_tab AS (
SELECT *,
DATE_DIFF(formation_date_fin_clean, formation_date_debut_clean, DAY) AS diff_formation_jours,
DATE_DIFF(date_fin_contrat, date_debut_contrat, DAY) AS diff_contrat_jours,
DATE_DIFF(formation_date_fin_clean, date_debut_contrat, DAY) AS diff_debut_contrat_fin_formation_jours,
DATE_DIFF(date_fin_contrat,date_effet_rupture_clean, DAY) AS diff_fin_contrat_ruptur_jours,
DATE_DIFF(date_effet_rupture_clean, date_debut_contrat, DAY) AS diff_debut_contrat_ruptur_jours,
DATE_DIFF(date_effet_rupture_clean,formation_date_debut_clean, DAY) AS diff_debut_formation_ruptur_jours,
DATE_DIFF(formation_date_fin_clean, date_effet_rupture_clean, DAY) AS diff_fin_formation_ruptur_jours

FROM case_when_tab
)

SELECT id_alternant,
id_alternant, 
numero_contrat, 
alternant_date_naissance, 
alternant_sexe, 
alternant_code_postal_clean,
formation_intitule_ou_qualification, 
titre_diplome_groupe, 
formation_date_debut_clean, 
formation_date_fin_clean, 
date_debut_contrat, 
date_fin_contrat, 
date_effet_rupture_clean, 
employeur_code_postal_clean,
employeur_nombre_de_salaries, 
type_employeur_libelle,
diff_formation_jours,
diff_contrat_jours,
diff_debut_contrat_fin_formation_jours,
diff_fin_contrat_ruptur_jours,
diff_debut_contrat_ruptur_jours,
diff_debut_formation_ruptur_jours,
diff_fin_formation_ruptur_jours

FROM date_diff_tab
WHERE numero_contrat !="f042a85961099684715647726f65084e"