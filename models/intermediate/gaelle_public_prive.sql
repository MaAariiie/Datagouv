WITH test as
(SELECT
numero_contrat,

CASE
  WHEN type_employeur_libelle LIKE "%Entreprise inscrite au répertoire des métiers ou au registre des entreprises pour l'Alsace-Moselle%" THEN "Entreprise inscrite au RCS ou RM pour l'Alsace-Moselle"
  WHEN type_employeur_libelle LIKE '%Entreprise inscrite uniquement au registre du commerce et des sociétés%' THEN "Entreprise inscrite au RCS ou RM"
  WHEN type_employeur_libelle LIKE '%383%' THEN "Association"
  ELSE type_employeur_libelle
END AS type_employeur_clean,
CASE
  WHEN type_employeur_libelle LIKE "%Association%" THEN "Association"
  WHEN UPPER(type_employeur_libelle) LIKE "%ENTREPRISE%" OR UPPER(type_employeur_libelle) LIKE "%EMPLOYEUR PRIV%" OR UPPER(type_employeur_libelle)LIKE "%PROFESSION%" THEN "Entreprise privée"
  WHEN type_employeur_libelle LIKE "%Etablissement%" OR type_employeur_libelle LIKE "%Région%" OR type_employeur_libelle LIKE "%Commune%" OR type_employeur_libelle LIKE "%Département%" OR type_employeur_libelle LIKE "%administration%" OR type_employeur_libelle LIKE "%public%" THEN "Entreprise publique"
  ELSE type_employeur_libelle
END AS public_prive
FROM  {{ref('stg_Datagouv__contrat_deca_test')}})
SELECT
numero_contrat,
public_prive
FROM test
