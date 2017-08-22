use immobilier;
-- Question 1 : Affichez le nom des agences
SELECT nom FROM agence;

-- Question 2 : Affichez le numéro de l’agence « Orpi »
SELECT idAgence FROM agence
where nom = "orpi"
;

-- Question 3 : Affichez le premier enregistrement de la table logement
SELECT * FROM logement
order by idLogement
limit 1
;

-- Question 4 : Affichez le nombre de logements (Alias : Nombre_de_logements)
select count(*) Nombre_de_logements
FROM logement
;
-- Question 5 : Affichez les logements à vendre à moins de 150 000 € dans l’ordre croissant des prix.
SELECT * FROM logement
where categorie = "vente" and prix <= 150000
order by prix ASC
;
-- Question 6 : Affichez le nombre de logements à la location (alias : nombre)
select count(*) Nombre_de_logements_location
FROM logement
where categorie = "location" 
;
-- Question 7 : Affichez les villes différentes recherchées par les personnes demandeuses d'un logement
select distinct ville
FROM demande
;

-- Question 8 : Affichez le nombre de biens à vendre par ville
select ville, count(*) Nombre_de_ventes_par_ville
FROM logement
where categorie = "vente" 
group by ville
;
-- Question 9 : Quelles sont les id des logements destinés à la location ?
select idLogement
FROM logement
where categorie = "location" 
;
-- Question 10 : Quels sont les id des logements entre 20 et 30m² ?
select idLogement
FROM logement
where superficie between 20 and 30
;
-- Question 11 : Quel est le prix vendeur (hors commission) du logement le moins cher à vendre ? (Alias : prix minimum)
select min(prix) prix_minimum
FROM logement
where categorie = "vente" 
;
-- Question 12 : Dans quelle ville se trouve les maisons à vendre ?
select ville
FROM logement
where categorie = "vente" and genre= "maison"
group by ville
;
-- Question 13 : L’agence Orpi souhaite diminuer les frais qu’elle applique sur le logement ayant l'id « 5246 ». Passer les frais de ce logement de 800 à 730€
update logement_agence
set frais= 730 
where idLogement = 5246
;
-- Question 14 : Quels sont les logements gérés par l’agence « laforet »
select idLogement
from logement_agence, agence
where logement_agence.idAgence = agence.idAgence
and agence.nom ="laforet"
;

-- Question 15 : Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre)
select count(distinct idPersonne) Nombre
from logement_personne, logement
where ville="Paris" and logement_personne.idLogement = logement.idLogement
;

-- Question 16 : Affichez les informations des trois premieres personnes souhaitant acheter un logement
select * 
from personne, demande
where demande.idPersonne = personne.idPersonne
and categorie= "vente"
;
-- Question 17 : Affichez le prénom du vendeur pour le logement ayant la référence « 5770 »
select prenom
from personne,logement_personne
where personne.idPersonne=logement_personne.idPersonne
and logement_personne.idLogement = 5770
;
-- Question 18 : Affichez les prénoms des personnes souhaitant accéder à un logement sur la ville de Lyon
select prenom
from personne,demande
where personne.idPersonne=demande.idPersonne
and demande.ville = "Paris"
;
-- Question 19 : Affichez les prénoms des personnes souhaitant accéder à un logement en location sur la ville de Paris
select prenom
from personne,demande
where personne.idPersonne=demande.idPersonne
and demande.ville = "Paris" and categorie="location"
;
-- Question 20 : Affichez les prénoms des personnes souhaitant acheter un logement de la plus grande à la plus petite superficie
select prenom
from personne,demande
where personne.idPersonne=demande.idPersonne
order by demande.superficie DESC
;
-- Question 21 : Quel sont les prix finaux proposés par les agences pour la maison à la vente ayant la référence « 5091 » ? (Alias : prix frais d'agence
-- inclus)
select (prix + frais) as prix_frais_d_agence_inclus
from logement,logement_agence
where logement.idLogement=logement_agence.idLogement
and logement.idLogement=5091
;
-- Question 23 : Si l’ensemble des logements étaient vendus ou loués demain, quel serait le bénéfice généré grâce aux frais d’agence et pour chaque agence
-- (Alias : benefice, classement : par ordre croissant des gains)
select idAgence, sum(frais) as benefice
from logement_agence
group by idAgence
ORDER by benefice
;
-- Question 24 : Affichez les id des biens en location, les prix, suivis des frais d’agence (classement : dans l’ordre croissant des prix) 
select logement.idLogement, prix, frais
from logement,logement_agence
where logement.idLogement=logement_agence.idLogement
ORDER BY prix
;
-- Question 25 : Quel est le prénom du propriétaire proposant le logement le moins cher à louer ?
select prenom
from personne,logement_personne
where personne.idPersonne=logement_personne.idPersonne
and logement_personne.idLogement=
								(select logement.idLogement
									from logement
									where prix = (select min(prix) from logement)
									and logement.categorie = "location")
;
-- Question 26 : Affichez le prénom et la ville où se trouve le logement de chaque propriétaire
select prenom, ville
from personne,logement,logement_personne
where personne.idPersonne=logement_personne.idPersonne
and logement_personne.idLogement=logement.idLogement					
;
-- Question 27 : Quel est l’agence immobilière s’occupant de la plus grande gestion de logements répertoriés à Paris ? (alias : nombre, classement : trié par
-- ordre décroissant)

select idAgence,count(distinct logement_agence.idLogement) 
from logement_agence , logement
where logement_agence.idLogement = logement.idLogement and logement.ville="paris"
group by idAgence
;

-- select max(counted) from
-- (
-- 	select count(temp) as counted from 
--     ( 
-- 		select idLogement as temp
-- 		from logement
-- 		where logement.ville="paris"
--     ) 	
--     as result2
-- ) 
-- as result
-- ;

-- Question 28 : Affichez le prix et le prénom des vendeurs dont les logements sont proposés à 130000 € ou moins en prix final avec frais appliqués par les
-- agences (alias : prix final, classement : ordre croissant des prix finaux) :
 select prix as prix_final, prenom
 from logement, personne
 where prix in ( select prix from logement,logement_agence
				where logement.idLogement=logement_agence.idLogement
                and (prix +frais) <= 130000
                and categorie="vente"
				)
ORDER BY PRIX ASC
;
select (prix + frais) as prix_frais_d_agence_inclus, prenom
from logement,logement_agence, personne,logement_personne
where logement.idLogement=logement_agence.idLogement
and (prix +frais) <= 130000
and categorie="vente"
and personne.idPersonne=logement_personne.idPersonne
and logement_personne.idLogement=logement.idLogement
;
-- Question 29 : Afficher toutes les demandes enregistrées avec la personne à l'origine de la demande (Afficher également les demandes d'anciennes personnes n'existant plus dans notre base de données).
select idDemande, prenom, genre,ville, budget, superficie, categorie
from demande left join personne
on demande.idPersonne=personne.idPersonne
;
-- Question 30 : Afficher toutes les personnes enregistrées avec leur demandes correspondantes (Afficher également les personnes n'ayant pas formulé de demandes).
select idDemande, prenom, genre,ville, budget, superficie, categorie
from demande right join personne
on demande.idPersonne=personne.idPersonne
;