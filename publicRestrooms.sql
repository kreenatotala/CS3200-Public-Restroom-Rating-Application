Drop database if exists pr;
CREATE DATABASE IF NOT EXISTS pr;
USE pr;

CREATE TABLE user (
userId INT AUTO_INCREMENT PRIMARY KEY,
userName varchar(20),
password varchar(10)
);


CREATE TABLE admin (
adminName varchar(20),
admin_Id INT,
CONSTRAINT admin_Id FOREIGN KEY (admin_Id)
    REFERENCES user (userId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE member (
memberName varchar(20),
member_Id INT,
CONSTRAINT member_Id FOREIGN KEY (member_Id)
    REFERENCES user (userId) ON DELETE CASCADE ON UPDATE CASCADE
);
   
CREATE TABLE region (
  regionName varchar(255) NOT NULL PRIMARY KEY);
  
INSERT INTO region (regionName) VALUES ('Allston');
INSERT INTO region (regionName) VALUES ('Back Bay');
INSERT INTO region (regionName) VALUES ('Bay Village');
INSERT INTO region (regionName) VALUES ('Beacon Hill');
INSERT INTO region (regionName) VALUES ('Brighton');
INSERT INTO region (regionName) VALUES ('Charlestown');
INSERT INTO region (regionName) VALUES ('Chinatown–Leather District');
INSERT INTO region (regionName) VALUES ('Dorchester');
INSERT INTO region (regionName) VALUES ('Downtown');
INSERT INTO region (regionName) VALUES ('East Boston');
INSERT INTO region (regionName) VALUES ('Fenway-Kenmore');
INSERT INTO region (regionName) VALUES ('Hyde Park');
INSERT INTO region (regionName) VALUES ('Jamaica Plain');
INSERT INTO region (regionName) VALUES ('Mattapan');
INSERT INTO region (regionName) VALUES ('Mission Hill');
INSERT INTO region (regionName) VALUES ('North End');
INSERT INTO region (regionName) VALUES ('Roslindale');
INSERT INTO region (regionName) VALUES ('Roxbury');
INSERT INTO region (regionName) VALUES ('South Boston');
INSERT INTO region (regionName) VALUES ('South End');
INSERT INTO region (regionName) VALUES ('West End');
INSERT INTO region (regionName) VALUES ('West Roxbury');
INSERT INTO region (regionName) VALUES ('Wharf District');

CREATE TABLE restroom (
rrID INT AUTO_INCREMENT PRIMARY KEY,
rrName varchar(100),
gender enum('male', 'female', 'family') NOT NULL,
rating INT,
review varchar(500),
region varchar(255),
CONSTRAINT restroom_region FOREIGN KEY (region) 
	REFERENCES region (regionName) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE rating (
ratingID INT AUTO_INCREMENT PRIMARY KEY,
rating INT,
rr int,
CONSTRAINT rating_restroom FOREIGN KEY (rr) 
	REFERENCES restroom (rrID) ON DELETE CASCADE ON UPDATE CASCADE);
    
CREATE TABLE review (
reviewID INT AUTO_INCREMENT PRIMARY KEY,
content varchar(200),
rr int,
CONSTRAINT review_restroom FOREIGN KEY (rr) 
	REFERENCES restroom (rrID) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE address (
street varchar(20),
zipcode INT NOT NULL,
regionName varchar(255),
restroom INT,
CONSTRAINT address_region FOREIGN KEY (regionName)
    REFERENCES region (regionName) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT address_restroom FOREIGN KEY (restroom)
    REFERENCES restroom (rrID) ON DELETE CASCADE ON UPDATE CASCADE
);  

CREATE TABLE favorties (
user INT, 
restroom INT, 
favorite_list varchar(100),
CONSTRAINT favorties_user FOREIGN KEY (user)
    REFERENCES user (userID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT favorties_restroom FOREIGN KEY (restroom)
    REFERENCES restroom (rrID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reviews_and_rates (
user INT, 
restroom INT, 
CONSTRAINT reviews_and_rates_user FOREIGN KEY (user)
    REFERENCES user (userID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT reviews_and_rates_restroom FOREIGN KEY (restroom)
    REFERENCES restroom (rrID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Search by region
DELIMITER //

CREATE PROCEDURE searchRegion(region varchar(255))
BEGIN
	SELECT * FROM restroom WHERE region = region;
END //

DELIMITER ;

-- creates new user 
DELIMITER //

CREATE PROCEDURE addUser(username varchar(50), pass varchar(50))
BEGIN
	INSERT INTO user (userName, password) VALUES (username, pass);
END //

DELIMITER ;

CALL addUser("kreena", "totala");

-- creates new restroom entry 
DELIMITER //

CREATE PROCEDURE addRestroom(name varchar(100), 
	gender varchar(50), region varchar(255), review varchar(500), rating int)
BEGIN
	INSERT INTO restroom (rrName, gender, region, review, rating) VALUES 
		(name, gender, region, review, rating);
END //

DELIMITER ;

CALL addRestroom("Northeastern Curry Student Center", "female", "Back Bay", "Very clean, great mirrors!", 5);

-- updates a restroom name 
DELIMITER //
CREATE PROCEDURE updateRestroomName(id int, name varchar(100))
BEGIN
	UPDATE restroom SET rrName = name WHERE rrID = id;
END //
DELIMITER ;

-- updates a restroom gender 
DELIMITER //
CREATE PROCEDURE updateRestroomGender(id int, gender varchar(50))
BEGIN
	UPDATE restroom SET gender = gender WHERE rrID = id;
END //
DELIMITER ;

-- updates a restroom region 
DELIMITER //
CREATE PROCEDURE updateRestroomRegion(id int, region varchar(255))
BEGIN
	UPDATE restroom SET region = region WHERE rrID = id;
END //
DELIMITER ;

-- updates a restroom rating 
DELIMITER //
CREATE PROCEDURE updateRestroomRating(id int, rating int)
BEGIN
	UPDATE restroom SET rating = rating WHERE rrID = id;
END //
DELIMITER ;

-- updates a restroom review 
DELIMITER //
CREATE PROCEDURE updateRestroomReview(id int, review varchar(100))
BEGIN
	UPDATE restroom SET review = review WHERE rrID = id;
END //
DELIMITER ;

-- deletes a restroom review
DELIMITER //
CREATE PROCEDURE deleteRestroom(id int)
BEGIN
	DELETE FROM restroom WHERE rrID = id;
END //
DELIMITER ;