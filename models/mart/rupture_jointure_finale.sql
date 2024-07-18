SELECT 

jointure1.*,
jointure_apres_casewhen.categorie_formation
FROM {{ ref("jointure1") }}
INNER JOIN {{ ref("jointure_apres_casewhen") }} USING (numero_contrat)