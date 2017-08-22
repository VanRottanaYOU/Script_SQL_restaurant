DROP database formation ;
create database IF NOT EXISTS formation;
use formation;

create table IF NOT EXISTS client(
idClient integer NOT NULL AUTO_INCREMENT,
nom varchar(20) NOT NULL,
PRIMARY KEY ( idClient )
);

create table IF NOT EXISTS commande (
idCommande integer NOT NULL AUTO_INCREMENT,
idClient integer NOT NULL,
FOREIGN KEY (idClient) REFERENCES client (idClient),
date1 date NOT NULL,
total double NOT NULL, 
PRIMARY KEY ( idCommande)
);

create table IF NOT EXISTS plat(
idPlat integer NOT NULL AUTO_INCREMENT,
nom varchar(15) NOT NULL,
tarif double NOT NULL,
PRIMARY KEY ( idPlat )
);

create table IF NOT EXISTS commande_plat (
idCommande integer NOT NULL,
FOREIGN KEY (idCommande) REFERENCES commande (idCommande),
idplat integer NOT NULL,
FOREIGN KEY (idplat) REFERENCES plat (idPlat),
quantite integer NOT NULL
);

create table IF NOT EXISTS ingredient(
idIngredient integer NOT NULL AUTO_INCREMENT,
nom varchar(15) NOT NULL,
PRIMARY KEY ( idIngredient)
);

create table IF NOT EXISTS ingredient_plat (
idPlat integer NOT NULL,
FOREIGN KEY (idPlat) REFERENCES plat (idPlat),
idIngredient integer NOT NULL,
FOREIGN KEY (idIngredient) REFERENCES ingredient (idIngredient),
quantite integer NOT NULL
);




