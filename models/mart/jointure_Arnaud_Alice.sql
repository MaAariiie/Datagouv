SELECT *
FROM {{ ref("formation_Arnaud") }}
INNER JOIN {{ ref("diplome_alice") }} USING (numero_contrat)