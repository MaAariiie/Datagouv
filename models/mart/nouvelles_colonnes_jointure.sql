with test as (select
jointure_finale.*,
rupture_jointure_finale_dateDIFF.diff_formation_jours,
rupture_jointure_finale_dateDIFF.diff_contrat_jours,
rupture_jointure_finale_dateDIFF.diff_debut_contrat_fin_formation_jours,
rupture_jointure_finale_dateDIFF.diff_fin_contrat_ruptur_jours,
rupture_jointure_finale_dateDIFF.diff_debut_contrat_ruptur_jours,
rupture_jointure_finale_dateDIFF.diff_debut_formation_ruptur_jours,
rupture_jointure_finale_dateDIFF.diff_fin_formation_ruptur_jours,
stg_Datagouv__distance_global_copy.distance_km,
CASE
        WHEN jointure_finale.alternant_sexe = 1 THEN 'Homme'
        WHEN jointure_finale.alternant_sexe = 2 THEN 'Femme'
    END AS Homme_Femme,

CASE
        WHEN jointure_finale.employeur_nombre_de_salaries BETWEEN 0 AND 19 THEN 'TPE'
        WHEN jointure_finale.employeur_nombre_de_salaries BETWEEN 20 AND 249 THEN 'PME'
        WHEN jointure_finale.employeur_nombre_de_salaries BETWEEN 250 AND 5000 THEN 'ETI'
        WHEN jointure_finale.employeur_nombre_de_salaries > 5000 THEN 'GE'
        ELSE 'Non classé'  -- Optionnel, pour les cas où employeur_nombre_de_salaries est NULL ou non valide
    END AS categorie_entreprise,

DATETIME_DIFF( DATE "2024-07-19",jointure_finale.alternant_date_naissance,YEAR) AS Age,


FROM {{ ref("jointure_finale") }}
LEFT JOIN {{ ref("rupture_jointure_finale_dateDIFF") }} USING (numero_contrat)
LEFT JOIN {{ ref("stg_Datagouv__distance_global_copy") }} USING (numero_contrat))
select *,
CASE
    WHEN test.distance_km < 10 THEN '< 10 km'
    WHEN test.distance_km >= 10 AND test.distance_km < 20 THEN '10-20 km'
    WHEN test.distance_km >= 20 AND test.distance_km < 30 THEN '20-30 km'
    WHEN test.distance_km >= 30 AND test.distance_km < 40 THEN '30-40 km'
    WHEN test.distance_km >= 40 AND test.distance_km < 50 THEN '40-50 km'
    WHEN test.distance_km >= 50 AND test.distance_km < 100 THEN '50-100 km'
    WHEN test.distance_km >= 100 AND test.distance_km < 200 THEN '100-200 km'
    WHEN test.distance_km >= 200 AND test.distance_km < 500 THEN '200-500 km'
    WHEN test.distance_km >= 500 AND test.distance_km < 20000 THEN 'supérieure à 500 km'
    ELSE 'distance inconnue'
    END AS categorie_distance,


CASE
    WHEN test.Age <= 20 THEN 'Moins de 20 ans'
    WHEN test.Age >= 20 THEN 'Plus de 20 ans'
    END AS categorie_age

FROM test