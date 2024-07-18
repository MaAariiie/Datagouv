SELECT *,
  COALESCE(
    titre_diplome_groupe,
    CASE
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%BTS%" THEN "Diplôme ou titre de niveau bac +2"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%BUT%" THEN "Diplôme ou titre de niveau bac +3 et 4"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%BACHELOR%" THEN "Diplôme ou titre de niveau bac +3 et 4"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%DCG%" THEN "Diplôme ou titre de niveau bac +3 et 4"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%MASTER%" THEN "Diplôme ou titre de niveau bac +5 et plus"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%CESI%" THEN "Diplôme ou titre de niveau bac +5 et plus"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%MBA%" THEN "Diplôme ou titre de niveau bac +5 et plus"
      WHEN UPPER(formation_intitule_ou_qualification) LIKE "%CAP%" THEN "Diplôme ou titre de niveau CAP/BEP"
      ELSE "Autre"
    END
  ) AS categorie_diplome
FROM {{ source('Datagouv', 'contrat_deca_test') }}
