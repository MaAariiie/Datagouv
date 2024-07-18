SELECT *
FROM {{ ref("formation_Arnaud") }}
JOIN {{ ref("diplome_alice") }} USING (numero_contrat)

JOIN {{ ref("gaelle_public_prive") }} USING (numero_contrat)
JOIN {{ ref("gaelle_clean_codes_postaux") }} ON (formation_Arnaud.alternant_code_postal_clean) = (gaelle_clean_codes_postaux.corrected_postal_code)


