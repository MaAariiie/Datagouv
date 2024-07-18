SELECT 

jointure_gaelle_1.*,
jointure_apres_casewhen.categorie_formation
FROM {{ ref("jointure_gaelle_1") }}
JOIN {{ ref("jointure_apres_casewhen") }} USING (numero_contrat)