select
    id_alternant,
    formation_intitule_ou_qualification,

    CASE 
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%JURI%' THEN 'Activités juridiques et comptables'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%COMPTA%' THEN 'Activités juridiques et comptables'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%DROIT%' AND UPPER(formation_intitule_ou_qualification) NOT LIKE '%MANAG%' AND UPPER(formation_intitule_ou_qualification) NOT LIKE '%MEDIAT%' THEN 'Activités juridiques et comptables'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%BANQUE%' THEN 'Finance, banque et assurance'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%SOIGNE%' THEN 'Agriculture et élevage'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%CUISI%' THEN 'Hôtellerie et restauration'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%CULIN%' THEN 'Hôtellerie et restauration'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%PAYSA%' AND UPPER(formation_intitule_ou_qualification) NOT LIKE '%INGEN%' AND UPPER(formation_intitule_ou_qualification) NOT LIKE '%CONSTR%' AND UPPER(formation_intitule_ou_qualification) NOT LIKE '%MANAGE%' THEN 'Maintenance, entretien et nettoyage'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%INFIR%' THEN 'Santé'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%SOIGNA%' THEN 'Santé'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%MEDIC%' THEN 'Santé'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%PSYCHO%' THEN 'Santé'
        WHEN UPPER(formation_intitule_ou_qualification) LIKE '%RADIO%' AND UPPER(formation_intitule_ou_qualification) NOT LIKE '%NUCL%' THEN 'Santé'
        ELSE 'autre'
    END AS categorie_formation

FROM {{ref('stg_Datagouv__contrat_deca_test')}}



