WITH CTE_Doublons AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY corrected_postal_code ORDER BY corrected_postal_code) AS rn
    FROM {{ref("gaelle_clean_codes_postaux")}}
)
SELECT
    code_commune_INSEE,
    nom_commune_postal,
    corrected_postal_code,
    libelle_acheminement,
    latitude,
    longitude,
    code_commune,
    nom_commune_complet,
    nom_region_clean,
    nom_departement_clean
FROM
    CTE_Doublons
WHERE
    rn = 1