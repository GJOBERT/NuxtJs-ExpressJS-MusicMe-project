/* DATABASE INIT */
DROP DATABASE IF EXISTS `music_me`;

CREATE DATABASE `music_me`;
USE `music_me`;

CREATE TABLE IF NOT EXISTS `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `token_id` varchar(255) NOT NULL,                      
    `firstname` varchar(255) NOT NULL,
    `lastname` varchar(255) NOT NULL,
    `birthday` date NOT NULL,
    `email` varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL,
    `avatar` MEDIUMBLOB,
    `isAdmin` tinyint(1) NOT NULL DEFAULT '0',

    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `products` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `title` varchar(255) NOT NULL,
    `description` varchar(255) NOT NULL,
    `artist` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,
    `year` int(11) DEFAULT '0',
    `image` MEDIUMBLOB,
    `num_available` int(11) NOT NULL DEFAULT '0',
	`num_total` int(11) NOT NULL DEFAULT '0',  
    `num_reserved` int(11) NOT NULL DEFAULT '0',
    `category_id` int(11) NOT NULL,


    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `orders` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `uniq_id` varchar(255) NOT NULL,
    `product_id` varchar (255) NOT NULL,
    `client_id` int(11) NOT NULL,
	`quantity` int(11) NOT NULL,
	`is_delivered` tinyint(1) NOT NULL DEFAULT '0',
	`order_date` date NOT NULL,
	`deliver_date` date NOT NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `favorites` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `client_id` varchar(255) NOT NULL,
    `product_id` varchar (255) NOT NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `categories` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,

    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/* --- TABLES --- */


/* Users */

INSERT INTO users (token_id, firstname, lastname, birthday, email, password, avatar, isAdmin) 
VALUES ('80238594', 'Jean', 'Peuplu', '1995-03-30', 'jean@mail.com', '$2b$10$xS7zy4j4m0tQqbrbRbnDFOr1LJuPV4lbRiKhYOgEx6sBSXvjlwiIa', null, 1);

INSERT INTO users (token_id, firstname, lastname, birthday, email, password, avatar, isAdmin) 
VALUES ('45084378', 'John', 'Atan', '1989-01-31', 'john@mail.com', '$2b$10$UO32x.8HIb74wqiTHJcYLOVzINqEaJKB3LbEGTXC8hPfwjye5t1Vu', null, 0);

INSERT INTO users (token_id, firstname, lastname, birthday, email, password, avatar, isAdmin) 
VALUES ('34328934', 'Vincent', 'Tim', '1993-06-05', 'vincent@mail.com', '$2b$10$5sRuRK6OKywQnHDUVosK2OZbHP8yRn8BwggS1moWoGfsB/5IkKs/2', null, 0);

INSERT INTO users (token_id, firstname, lastname, birthday, email, password, avatar, isAdmin) 
VALUES ('57934203', 'Canard', 'Tissho', '1996-07-17', 'canard@mail.com', '$2b$10$.pHAV4jbGeY4oDgEcbbr7O6ohWTEPELyY.QP9jWqHMxN1oyaLwNom', null, 0);

INSERT INTO users (token_id, firstname, lastname, birthday, email, password, avatar, isAdmin) 
VALUES ('75402383', 'Pierre', 'Caillou', '2000-09-11', 'pierre@mail.com', '$2b$10$qAf8zTEhvBlC5xz0O4tATuAOseP360O/1nsorH19i3E0qKJw0Y5Je', null, 0);

INSERT INTO users (token_id, firstname, lastname, birthday, email, password, avatar, isAdmin) 
VALUES ('65438294', 'Paula', 'Roïde', '1999-04-12', 'paula@mail.com', '$2b$10$EmJG7ZL.5MyBhW/ko5pei.XdJ4t7gT26B9wqTBpTIFyVTogSeNIRe', null, 0);


/* Products */

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ('Babar au pays des kangourous', "C'est l'histoire d'un éléphant qui voyage en Australie quand tout à coup...", 19, 'Hulio Chaberto', 1970, null, 10, 10, 0, 1);

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Popi et l'ardoise magique", "Popi aime dessiner sur son ardoise, quand tout à coup...", 19, 'Gaby Jobersky', 1999, null, 10, 10, 0, 3);

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("L'homme et le canard", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Kryss Mantis', 2017, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 2", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'Acid Cactus', 2017, null, 10, 10, 0, 3);

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);

INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 INSERT INTO products (title, description, price, artist, year, image, num_available, num_total, num_reserved, category_id) 
VALUES ("Test 3", "Une enquête palpitante au sein de DuckCity afin de retrouver l'assassin du grand duc du Trou", 19, 'The sacred pinguinz', 1974, null, 10, 10, 0, 3);
 

/* Categories */

INSERT INTO categories (name)
VALUES ('Flamenco');

INSERT INTO categories (name)
VALUES ('Alternative');

INSERT INTO categories (name)
VALUES ('Stoner rock');

INSERT INTO categories (name)
VALUES ('Metal');

INSERT INTO categories (name)
VALUES ('Pop');