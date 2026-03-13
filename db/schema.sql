DROP DATABASE IF EXISTS MovieStore;
CREATE DATABASE MovieStore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE MovieStore;

DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS logs;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Uzytkownicy;

CREATE TABLE Uzytkownicy (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user VARCHAR(150) NOT NULL,
  password VARCHAR(255) NOT NULL,
  admin TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY ux_user (user)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Movies (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  image VARCHAR(255) DEFAULT NULL,
  thumbnail VARCHAR(255) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  rating TINYINT UNSIGNED DEFAULT NULL,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Cart (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_user INT UNSIGNED NOT NULL,
  id_product INT UNSIGNED NOT NULL,
  count INT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  KEY idx_cart_user (id_user),
  KEY idx_cart_product (id_product),
  CONSTRAINT fk_cart_user 
    FOREIGN KEY (id_user) REFERENCES Uzytkownicy(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_cart_product 
    FOREIGN KEY (id_product) REFERENCES Movies(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED DEFAULT NULL,
  ip VARCHAR(45) DEFAULT NULL,
  action VARCHAR(255) DEFAULT NULL,
  time DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_logs_user (user_id),
  CONSTRAINT fk_logs_user 
    FOREIGN KEY (user_id) REFERENCES Uzytkownicy(id)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO Uzytkownicy (user, password, admin)
VALUES ('admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 1);

INSERT INTO Movies (title, image, thumbnail, description, rating, price)
VALUES
(
'The Shawshank Redemption',
'/ImagesMovieShop/2022-11-16_23-20-17_Shawshank.jpg',
'/thumbnails/2022-11-16_23-20-17_Shawshank.jpg',
'Drama about hope and friendship inside Shawshank prison.',
9,
19.99
),
(
'The Dark Knight',
'/ImagesMovieShop/2022-11-17-11-33-44_batmanDK.jpg',
'/thumbnails/2022-11-17-11-33-44_batmanDK.jpg',
'Batman faces the Joker in one of the greatest superhero films ever made.',
9,
24.99
),
(
'Inception',
'/ImagesMovieShop/2022-11-17-11-35-50_incepcja.jpg',
'/thumbnails/2022-11-17-11-35-50_incepcja.jpg',
'A mind-bending thriller about dreams within dreams.',
8,
22.99
);