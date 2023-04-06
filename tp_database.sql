-- Tp MySQL made by Amandine Guenassia  
-- TP2  
--On créé la table utilisateur 

CREATE TABLE new_schema.utilisateur( 

users_id INT, 

nom VARCHAR(255), 

prenom VARCHAR(255), 

email VARCHAR(255), 

adresse VARCHAR(255), 

ville VARCHAR(255), 

created_on DATE 

);  

-- On modifie la table utilisateur pour mettre les types la clé primaire et changer les noms 

ALTER TABLE `new_schema`.`utilisateur`  

DROP COLUMN `created_on`, 

ADD COLUMN `Date_de_naissance` DATETIME NOT NULL AFTER `Adresse`, 

CHANGE COLUMN `users_id` `id_utilisateur` INT NOT NULL AUTO_INCREMENT , 

CHANGE COLUMN `nom` `Nom` VARCHAR(255) NOT NULL , 

CHANGE COLUMN `prenom` `Prénom` VARCHAR(255) NOT NULL , 

CHANGE COLUMN `email` `Email` VARCHAR(255) NOT NULL , 

CHANGE COLUMN `adresse` `Lieu_naissance` VARCHAR(255) NOT NULL , 

CHANGE COLUMN `ville` `Adresse` VARCHAR(255) NOT NULL , 

ADD PRIMARY KEY (`id_utilisateur`); 

; 


-- TP3 

INSERT INTO new_schema.utilisateur( Nom , Prénom, Email,Adresse,Date_de_naissance,Lieu_naissance )   

-- On créé un nouvel utilisateur dans la table utilisateur avec ses valeurs   

VALUES("Doe","John", "johndoe@gmail.com"," 41 rue dueri", "2004-02-02", "Lyon");   

COMMIT;   

INSERT INTO new_schema.utilisateur( Nom , Prénom, Email,Adresse,Date_de_naissance, Lieu_naissance )  

-- On créé un nouvel utilisateur dans la table utilisateur avec ses valeurs  

VALUES("Croft","Lara", "laracroft@gmail.com"," 93 rue dueri", "2004-05-09", "Paris");  

COMMIT;  

CREATE TABLE new_schema.profile(  

-- On créé une nouvelle table profile avec idprofil en non null et clé primaire et auto increment, Nom 

idprofil INT NOT NULL AUTO_INCREMENT,  

Nom varchar(45) NOT NULL,  

PRIMARY KEY(idprofil));  

COMMIT; 

-- On supprime de la table utilisateur l’utilisateur 2 qui possède l’email laracroft@gmail.com 

DELETE FROM `new_schema`.`utilisateur` 

WHERE `id_utilisateur` = 2 AND `Email` = 'laracroft@gmail.com'; 

 

--TP4  

ALTER TABLE `new_schema`.`utilisateur`  

CHANGE COLUMN `idprofile` `idprofile` INT NULL ; 

-- On ajoute une clé étrangère ( fk_profil) à la table utilisateur 

ALTER TABLE `new_schema`.`utilisateur`  

ADD COLUMN `idprofile` INT NOT NULL AFTER `Date_de_naissance`; 

ALTER TABLE `new_schema`.`utilisateur`  

ADD CONSTRAINT `fk_profile` 

 FOREIGN KEY (`idprofile`) 

 REFERENCES `new_schema`.`profile` (`idprofil`) 

 ON DELETE NO ACTION 

 ON UPDATE NO ACTION; 

 

 

--TP5  

-- On affiche les idutilisateurs en tant que identifiants et on affiche tous les emails sans doublons.  

SELECT id_utilisateur AS identifiant  

FROM new_schema.utilisateur;   

SELECT DISTINCT Email   

FROM new_schema.utilisateur;   

-- On met une condition de quand il y’a un prénom avec une valeur alors ça renvoies ‘okay ! ‘ ,quand y’a pas de prénom on renvoie ‘pas de prénom ‘ et sinon on renvoie ‘erreur’ .   

SELECT    

CASE   

WHEN Prénom IS NOT NULL THEN 'okay!'   

        WHEN Prénom IS NULL THEN 'pas de prénom'   

        ELSE 'ERREUR'   

END AS prenom_status   

    FROM new_schema.utilisateur    

    WHERE Date_de_naissance = 2004-05-09; 

 

 

 

-- TP6  

-- On va afficher les utilisateurs qui possèdent le prénom djen ou lara ou tom and ayant un nom tel que Croft ou Sally. 

SELECT Prénom 

FROM new_schema.utilisateur 

WHERE (Prénom = "djen" OR Prénom  = "Lara" OR Prénom = "Tom") 

AND ( Nom = "Croft" OR Nom = "Sally"); 

-- On va afficher la date de naissance de l’utilisateur ayant le nom croft et  qui est né entre 2002 et 2010. 

SELECT Nom 

FROM new_schema.utilisateur  

WHERE DATE_FORMAT(Date_de_naissance, '%Y-%m-%d')  >= 2002-01-01 AND DATE_FORMAT(Date_de_naissance, '%Y-%m-%d')  <= 2010-01-01 

AND (Nom = "Croft");  

-- On affiche les nom des utilisateurs qui ont soit Croft ou Potter ou Poitier dans leurs nom et ayant un prénom Lara 

SELECT Nom 

FROM new_schema.utilisateur 

WHERE Nom IN ( "Croft" OR "Potter" or "Poitier") AND Prénom IN ("Lara"); 

-- On va afficher toutes les colonnes de l’utilisateur qui possède l’email laracroft@gmail.com et étant né entre le 9 mai 2000 et le 1er janvier 2050 

SELECT * 

FROM new_schema.utilisateur 

WHERE DATE_FORMAT(Date_de_naissance, '%Y-%m-%d') BETWEEN '2000-05-09' AND '2050-01-01' 

AND Email = "laracroft@gmail.com"; 

-- On va afficher toutes les colonnes du profile qui possède en fin de nom les lettres ‘eur’ et qui commence par un D 

SELECT * 

FROM new_schema.profile 

WHERE nom LIKE 'D%eur'; 

-- On va afficher toutes les colonnes du profile qui possède en début de nom les lettres ‘la et on trie dans l’ordre alphabétique 

SELECT * 

FROM new_schema.utilisateur 

WHERE Email LIKE 'la%' 

ORDER BY nom ASC; 

 

 

-- TP7 

-- On affiche toutes les colonnes de la table utilisateur on va l’afficher si et seulement si quand dans la table profile et utilisateur leurs idprofil et idprofile sont les mêmes.  

SELECT idprofil, Prénom, Email, Adresse, new_schema.profile.nom,  id_utilisateur,Date_de_naissance  

FROM new_schema.utilisateur  

INNER JOIN new_schema.profile  

ON profile.idprofil = utilisateur.idprofile;  

-- On affiche idprofil, Prénom, Email, Adresse, new_schema.profile.nom,Date_de_naissance de la table utilisateur on va l’afficher si et seulement si quand dans la table profile et utilisateur leurs idprofil et idprofile sont les mêmes et que l’idprofile est non null et on affiche pas les id   

SELECT Prénom, Email, Adresse, new_schema.profile.nom, Date_de_naissance  

FROM new_schema.utilisateur  

INNER JOIN new_schema.profile  

ON new_schema.utilisateur.idprofile = new_schema.profile.idprofil  

WHERE new_schema.utilisateur.idprofile IS NOT NULL;  

-- On affiche idprofil, Prénom, Email, Adresse, new_schema.profile.nom, ,Date_de_naissance de la table utilisateur on va l’afficher si et seulement si quand dans la table profile et utilisateur leurs idprofil et idprofile sont les mêmes et que l’idprofile est non null et on n’affiche pas les utilisateurs sans profile  

SELECT Prénom, Email, Adresse, new_schema.profile.nom, Date_de_naissance  

FROM new_schema.utilisateur  

INNER JOIN new_schema.profile  

ON new_schema.utilisateur.idprofile = new_schema.profile.idprofil; 

 

 

-- TP8  

-- Sélectionne tous les profiles sans utilisateurs. Affiche uniquement l’ID du profile et son nom. On n’  affiche pas de doublon   

SELECT DISTINCT profile.idprofil, profile.nom   

FROM new_schema.profile   

LEFT JOIN new_schema.utilisateur   

ON profile.idprofil = utilisateur.idprofile  

WHERE utilisateur.idprofile IS NULL; 

 

 

-- TP9 
-- On crée la table entreprise avec   `identreprise` INT NOT NULL AUTO_INCREMENT primary key 

CREATE TABLE `new_schema`.`entreprise` ( 

  `identreprise` INT NOT NULL AUTO_INCREMENT, 

  `nom` VARCHAR(45) NOT NULL, 

  `adresse` VARCHAR(45) NOT NULL, 

  `telephone` VARCHAR(20) NOT NULL, 

  `email` VARCHAR(45) NOT NULL, 

  PRIMARY KEY (`identreprise`), 

  UNIQUE INDEX `email_UNIQUE` (`email`) 

); 

-- On crée la table de jointure utilisateur_entreprise avec   `idutilisateur_entreprise` INT NOT NULL (`idutilisateur_entreprise`) PRIMARY KEY AUTO_INCREMENT, `idutilisateur` NOT NULL, `identreprise` NOT NULL,  

CREATE TABLE `new_schema`.`utilisateur_entreprise` ( 
  `idutilisateur_entreprise` INT NOT NULL AUTO_INCREMENT, 
  `idutilisateur` INT NOT NULL, 
  `identreprise` INT NOT NULL, 
  PRIMARY KEY (`idutilisateur_entreprise`) 

); 
-- On ajoute a utilisateur_entreprise une clé étrangère fk_identreprise 

ALTER TABLE `new_schema`.`utilisateur_entreprise` 

ADD CONSTRAINT `fk_identreprise` 

  FOREIGN KEY (`identreprise`) 

  REFERENCES `new_schema`.`entreprise` (`identreprise`) 

  ON DELETE NO ACTION 

  ON UPDATE NO ACTION; 

-- On ajoute a utilisateur_entreprise une clé étrangère fk_idutilisateur 

ALTER TABLE `new_schema`.`utilisateur_entreprise`  

ADD CONSTRAINT `fk_idutilisateur`  

  FOREIGN KEY (`idutilisateur`)  

  REFERENCES `new_schema`.`utilisateur` (`id_utilisateur`)  

  ON DELETE NO ACTION  

  ON UPDATE NO ACTION; 

 

 

-- TP10 

-- On ajoute une colonne salaire à la table utilisateur et on ajoute des valeurs a certains utilisateurs 

ALTER TABLE new_schema.utilisateur ADD COLUMN salaire INT; -- ajout colonne salaire 

UPDATE `new_schema`.`utilisateur` SET `salaire` = '120000' WHERE (`id_utilisateur` = '1') and (`Email` = 'johndoe@gmail.com'); 

-- Compter le nombre d'utilisateurs  

SELECT COUNT(*) AS Nombre_Utilisateurs FROM `new_schema`.`utilisateur`;  

-- La somme des salaires  

SELECT SUM(salaire) AS Somme_Salaires FROM `new_schema`.`utilisateur`;  

-- La moyenne des salaires  

SELECT AVG(salaire) AS Moyenne_Salaires FROM `new_schema`.`utilisateur`;  

-- Arrondir la moyenne des salaires (entier)  

SELECT ROUND(AVG(salaire)) AS Moyenne_Salaires_Entier FROM `new_schema`.`utilisateur`;  

-- Le salaire maximum  

SELECT MAX(salaire) AS Salaire_Maximum FROM `new_schema`.`utilisateur`;  

-- Le salaire minimum  

SELECT MIN(salaire) AS Salaire_Minimum FROM `new_schema`.`utilisateur`; 

 

 

 

-- Tp11 

-- Décliner la requête du TP10 par entreprise, on ajoute la colonne "identreprise" à la table utilisateur 

ALTER TABLE new_schema.utilisateur ADD COLUMN identreprise INT; 

-- Compter le nombre d'utilisateurs par entreprise 

SELECT identreprise, COUNT(*) AS Nombre_Utilisateurs 

FROM new_schema.utilisateur 

GROUP BY identreprise; 

-- La somme des salaires par entreprise 

SELECT identreprise, SUM(salaire) AS Somme_Salaires 

FROM new_schema.utilisateur 

GROUP BY identreprise; 

-- La moyenne des salaires par entreprise 

SELECT identreprise, AVG(salaire) AS Moyenne_Salaires 

FROM new_schema.utilisateur 

GROUP BY identreprise; 

-- Arrondir la moyenne des salaires (entier) par entreprise 

SELECT identreprise, ROUND(AVG(salaire)) AS Moyenne_Salaires_Entier 

FROM new_schema.utilisateur 

GROUP BY identreprise; 

-- Le salaire maximum par entreprise 

SELECT identreprise, MAX(salaire) AS Salaire_Maximum 

FROM new_schema.utilisateur 

GROUP BY identreprise; 

-- Le salaire minimum par entreprise 

SELECT identreprise, MIN(salaire) AS Salaire_Minimum 

FROM new_schema.utilisateur 

GROUP BY identreprise; 

-- Décliner la requête du TP10 par profile, on utilise une requête GROUP BY sur la colonne profile 

SELECT idprofile, SUM(Salaire) AS Total_Salaire, COUNT(*) AS Nombre_Employes, AVG(Salaire) AS Moyenne_Salaire  

FROM `new_schema`.`utilisateur`  

GROUP BY idprofile;  

SELECT idprofile, SUM(Salaire) AS Total_Salaire, COUNT(*) AS Nombre_Employes, AVG(Salaire) AS Moyenne_Salaire  

FROM `new_schema`.`utilisateur`  

GROUP BY idprofile  

HAVING Moyenne_Salaire > 1800; 


-- Pour n'avoir que les salaires moyens supérieurs à 1800 

SELECT idprofile, SUM(Salaire) AS Total_Salaire, COUNT(*) AS Nombre_Employes, AVG(Salaire) AS Moyenne_Salaire 

FROM `new_schema`.`utilisateur` 

GROUP BY idprofile 

HAVING Moyenne_Salaire > 1800; 

-- Trouver le salaire minimum et maximum pour chaque profil, mais seulement pour les profils qui ont une différence entre le salaire maximum et minimum supérieure à 10000 

SELECT idprofil, MIN(salaire) as salaire_minimum, MAX(salaire) as salaire_maximum 

FROM new_schema.utilisateur 

GROUP BY idprofil 

HAVING (MAX(salaire) - MIN(salaire)) > 10000; 

