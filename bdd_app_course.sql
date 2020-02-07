START TRANSACTION;

DROP DATABASE IF EXISTS bdd_app_course;
CREATE DATABASE IF NOT EXISTS bdd_app_course;
use bdd_app_course;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id_user` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255)  NOT NULL,
    `firstname` varchar(255) NOT NULL,
    `address` varchar(255) NOT NULL,
    `zipcode` int NOT NULL,
    `city` varchar(255)  NOT NULL,
    `email` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    `date_add` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_update` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_delete` DATETIME,
    `activate` BOOLEAN default 1,
    PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`name`, `firstname`, `address`, `zipcode`, `city`, `email`, `password`)  
           VALUES ('Laslaa', 'Mohammed', '16 Rue pasteur', 62950, 'Noyelles-Godault', 'mohamed@gmail.com', 'mlaslaa' ),
                  ('Dufour', 'Olivier', '23 Rue malfidano', 62320, 'Rouvroy', 'olivier@gmail.com', 'odufour' ),
                  ('Devise', 'Théo', '12 Rue victor hugo', 62000, 'Arras', 'theo@gmail.com', 'tdevise' );

                  set @Laslaa := last_insert_id();
                  set @Dufour := last_insert_id()+1;
                  set @Devise := last_insert_id()+2;


DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
    `id_list` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255)  NOT NULL,
    `total_price` int NOT NULL,
    `date_add` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_update` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_delete` DATETIME,
    `activate` BOOLEAN default 1,
    `id_user` int NOT NULL,
    PRIMARY KEY (`id_list`),
    FOREIGN KEY (`id_user`) REFERENCES users(`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `list`(`name`, `total_price`, `id_user`) 
         VALUES ('Coursedu07022020', '229', @Laslaa),
                ('Coursedu08022020', '109', @Dufour),
                ('Coursedu09022020', '159', @Devise);

        set @Coursedu07022020 := last_insert_id();
        set @Coursedu08022020 := last_insert_id()+1;
        set @Coursedu09022020 := last_insert_id()+2;

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
    `id_cat` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `date_add` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_update` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_delete` DATETIME,
    `activate` BOOLEAN default 1,
    PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `category`(`name`) 
               VALUES ('menager'), ('boulangerie'), ('nourriture'), ('epicerie');

                set @menager := last_insert_id();
                set @boulangerie := last_insert_id()+1;
                set @nourriture := last_insert_id()+2;
                set @epicerie := last_insert_id()+3;


DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
    `id_art` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `price` float NOT NULL,
    `id_cat` int NOT NULL,
    `date_add` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_update` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_delete` DATETIME,
    `activate` BOOLEAN default 1,
    PRIMARY KEY (`id_art`),
    FOREIGN KEY (`id_cat`) REFERENCES category(`id_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `article`(`name`, `price`, `id_cat`) 
              VALUES ('Banane', '1.69', @nourriture),
                     ('Liquide vaisselle', '1.99', @menager),
                     ('Sachet de congélation', '2.49', @menager),
                     ('Baguette', '0.85', @boulangerie),
                     ('Céréale', '1.69', @nourriture),
                     ('Pain', '1.69', @boulangerie),
                     ('Confiserie', '1.69', @nourriture),
                     ('Café', '1.69', @nourriture),
                     ('Serpillère', '1.69', @menager),
                     ('Lait', '1.69', @menager),
                     ('Poivre', '1.69', @epicerie),
                     ('Fraise', '1.69', @nourriture),
                     ('Curry', '1.69', @epicerie);

                     set @Banane := last_insert_id();
                     set @Sachet := last_insert_id()+1;
                     set @Cereale := last_insert_id()+2;
                     set @Pain := last_insert_id()+3;
                     set @Cafe := last_insert_id()+4;
                     set @Serpillere := last_insert_id()+5;
                     set @Lait := last_insert_id()+6;
                     set @Poivre := last_insert_id()+7;
                     set @Fraise := last_insert_id()+8;
                     set @Curry := last_insert_id()+9;


DROP TABLE IF EXISTS `list_art`;
CREATE TABLE `list_art` (
    `id_list_art` int NOT NULL AUTO_INCREMENT,
    `quantity` int NOT NULL,
    `id_list` int NOT NULL,
    `id_art` int NOT NULL,
    `date_add` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_update` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    `date_delete` DATETIME,
    `activate` BOOLEAN default 1,
    PRIMARY KEY (`id_list_art`),
    FOREIGN KEY (`id_list`) REFERENCES list(`id_list`),
    FOREIGN KEY (`id_art`) REFERENCES article(`id_art`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `list_art`(`quantity`, `id_list`, `id_art`) 
            VALUES (2, @Coursedu07022020, @Banane),
            (2, @Coursedu07022020, @Banane),
            (1, @Coursedu08022020, @Cereale),
            (3, @Coursedu07022020, @Sachet),
            (1, @Coursedu07022020, @Banane),
            (1, @Coursedu09022020, @Poivre),
            (1, @Coursedu08022020, @Serpillere),
            (1, @Coursedu08022020, @Curry),
            (2, @Coursedu07022020, @Banane),
            (3, @Coursedu09022020, @Curry),
            (1, @Coursedu09022020, @Banane),
            (2, @Coursedu08022020, @Pain),
            (1, @Coursedu07022020, @Poivre),
            (1, @Coursedu08022020, @Banane),
            (1, @Coursedu07022020, @Pain),
            (1, @Coursedu09022020, @Banane),
            (3, @Coursedu08022020, @Banane),
            (1, @Coursedu09022020, @Pain),
            (3, @Coursedu08022020, @Banane),
            (1, @Coursedu08022020, @Curry),
            (1, @Coursedu09022020, @Banane);



COMMIT;


/* mysql -u root -p bdd_app_course  < C:\wamp64\www\exercise_sql\bdd_app_course.sql Insert with comand line*/ 