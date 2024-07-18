SELECT *
FROM {{ ref("jointure1") }}
JOIN {{ ref("jointure_apres_casewhen") }}
USING (numero_contrat)