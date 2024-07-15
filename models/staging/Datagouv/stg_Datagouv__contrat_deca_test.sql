with 

source as (

    select * from {{ source('Datagouv', 'contrat_deca_test') }}

),

renamed as (

    select
        id_alternant,
        numero_contrat,
        alternant_date_naissance,
        alternant_sexe,
        alternant_adresse_code_postal,
        formation_intitule_ou_qualification,
        titre_diplome_groupe,
        formation_date_debut,
        formation_date_fin,
        date_debut_contrat,
        date_fin_contrat,
        date_effet_rupture,
        employeur_adresse_code_postal,
        employeur_nombre_de_salaries,
        type_employeur_libelle

    from source

)

select * from renamed
