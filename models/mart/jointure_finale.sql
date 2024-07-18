SELECT 

jointure_Antonin.*,
jointure_code_postaux.*
FROM {{ ref("jointure_Antonin") }}
LEFT JOIN {{ ref("jointure_code_postaux") }} ON (jointure_Antonin.employeur_code_postal_clean) = (jointure_code_postaux.corrected_postal_code)
