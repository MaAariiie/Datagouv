SELECT *
FROM {{ ref("formation_Arnaud") }}
JOIN {{ ref("diplome_alice") }}
USING (numero_contrat)

JOIN {{ ref("gaelle_public_prive") }} USING (numero_contrat)
#JOIN {{ ref("gaelle_clean_codes_postaux") }} U (alternant_code_postal_clean)
