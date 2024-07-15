with 

source as (

    select * from {{ source('Datagouv', 'mapping_codes_postaux') }}

),

renamed as (

    select
        code_commune_insee,
        nom_commune_postal,
        code_postal,
        libelle_acheminement,
        ligne_5,
        latitude,
        longitude,
        code_commune,
        article,
        nom_commune,
        nom_commune_complet,
        code_departement,
        nom_departement,
        code_region,
        nom_region

    from source

)

select * from renamed
