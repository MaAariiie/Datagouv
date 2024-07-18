SELECT 

alternant_code_postal_clean,
jointure1.formation_intitule_ou_qualification,
titre_diplome_groupe,
formation_date_debut,
formation_date_fin,
date_debut_contrat,
date_fin_contrat,
date_effet_rupture,
employeur_code_postal_clean,
employeur_nombre_de_salaries,
type_employeur_libelle,
categorie_diplome,
public_prive,
code_commune_INSEE,
nom_commune_postal,
corrected_postal_code,
libelle_acheminement,
latitude,
longitude,
code_commune,
nom_commune_complet,
nom_region_clean,
nom_departement_clean,
categorie_formation
FROM {{ ref("jointure1") }}
JOIN {{ ref("jointure_apres_casewhen") }} USING (numero_contrat)