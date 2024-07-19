with 

source as (

    select * from {{ source('Datagouv', 'distance_global_copy') }}

),

renamed as (

    select
        numero_contrat,
        alternant_code_postal_clean,
        employeur_code_postal_clean,
        distance_km

    from source

)

select * from renamed
