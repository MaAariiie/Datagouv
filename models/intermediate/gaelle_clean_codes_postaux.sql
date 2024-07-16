WITH test AS (SELECT 

*,
LPAD(CAST(code_postal AS STRING), 5, '0') AS corrected_postal_code,

from {{ source('Datagouv', 'total_codes_postaux') }}

ORDER BY LPAD(CAST(code_postal AS STRING), 5, '0')
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
CASE
  WHEN CAST(code_postal AS STRING) LIKE '971%' THEN 'Guadeloupe'
  WHEN CAST(code_postal AS STRING) LIKE '972%' THEN 'Martinique'
  WHEN CAST(code_postal AS STRING) LIKE'974%' THEN 'La Réunion'
  WHEN CAST(code_postal AS STRING) LIKE '975%' THEN 'Saint-Pierre-et-Miquelon'
  WHEN CAST(code_postal AS STRING) LIKE '986%' THEN 'Wallis-et-Futuna'
  WHEN CAST(code_postal AS STRING) LIKE '987%' THEN 'Polynésie française'
  WHEN CAST(code_postal AS STRING) LIKE '988%' THEN 'Nouvelle-Calédonie'
  WHEN CAST(code_postal AS STRING) LIKE '989%' THEN 'Île de Clipperton'
  WHEN libelle_acheminement LIKE 'MONACO' THEN 'Monaco'
  ELSE nom_region
END AS nom_region_clean,
CASE
  WHEN CAST(code_postal AS STRING) LIKE '971%' THEN 'Guadeloupe'
  WHEN CAST(code_postal AS STRING) LIKE '972%' THEN 'Martinique'
  WHEN CAST(code_postal AS STRING) LIKE'974%' THEN 'La Réunion'
  WHEN CAST(code_postal AS STRING) LIKE '975%' THEN 'Saint-Pierre-et-Miquelon'
  WHEN CAST(code_postal AS STRING) LIKE '986%' THEN 'Wallis-et-Futuna'
  WHEN CAST(code_postal AS STRING) LIKE '987%' THEN 'Polynésie française'
  WHEN CAST(code_postal AS STRING) LIKE '988%' THEN 'Nouvelle-Calédonie'
  WHEN CAST(code_postal AS STRING) LIKE '989%' THEN 'Île de Clipperton'
  WHEN libelle_acheminement LIKE 'MONACO' THEN 'Monaco'
  ELSE nom_departement
END AS nom_departement_clean

FROM test

ORDER BY code_commune_INSEE