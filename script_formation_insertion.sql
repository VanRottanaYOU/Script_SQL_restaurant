INSERT INTO client(nom) VALUES("van"),("angelo");

INSERT INTO commande(idClient,date1,total) VALUES(1,'2017-08-21',7.99),(1,'2017-08-22',8.99);

INSERT INTO plat(idPlat,nom,tarif) VALUES(1,"tacos",7.99),(2,"BIGMAC",8.99);

INSERT INTO commande_plat(idCommande,idPlat,quantite) VALUES(1,1,1),(2,2,1);

INSERT INTO ingredient(idIngredient,nom) VALUES(1,"boeuf"),(2,"fromage"),(3,"frite");

INSERT INTO ingredient_plat(idPlat,idIngredient,quantite) VALUES(1,1,100),(1,2,20),(1,3,100),
														  (2,1,125),(2,2,30),(2,3,200)
;
