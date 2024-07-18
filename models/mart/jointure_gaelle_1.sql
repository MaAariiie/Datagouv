SELECT *
FROM {{ ref("jointure_Arnaud_Alice") }}
INNER JOIN {{ ref("gaelle_public_prive") }} USING (numero_contrat)