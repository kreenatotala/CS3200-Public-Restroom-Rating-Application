CREATE DATABASE  IF NOT EXISTS `pr` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pr`;
-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: localhost    Database: pr
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `street` varchar(20) DEFAULT NULL,
  `zipcode` int NOT NULL,
  `regionName` varchar(255) DEFAULT NULL,
  `restroom` int DEFAULT NULL,
  KEY `address_region` (`regionName`),
  KEY `address_restroom` (`restroom`),
  CONSTRAINT `address_region` FOREIGN KEY (`regionName`) REFERENCES `region` (`regionName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `address_restroom` FOREIGN KEY (`restroom`) REFERENCES `restroom` (`rrID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `adminName` varchar(20) DEFAULT NULL,
  `admin_Id` int DEFAULT NULL,
  KEY `admin_Id` (`admin_Id`),
  CONSTRAINT `admin_Id` FOREIGN KEY (`admin_Id`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorties`
--

DROP TABLE IF EXISTS `favorties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorties` (
  `user` int DEFAULT NULL,
  `restroom` int DEFAULT NULL,
  `favorite_list` varchar(100) DEFAULT NULL,
  KEY `favorties_user` (`user`),
  KEY `favorties_restroom` (`restroom`),
  CONSTRAINT `favorties_restroom` FOREIGN KEY (`restroom`) REFERENCES `restroom` (`rrID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favorties_user` FOREIGN KEY (`user`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorties`
--

LOCK TABLES `favorties` WRITE;
/*!40000 ALTER TABLE `favorties` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `memberName` varchar(20) DEFAULT NULL,
  `member_Id` int DEFAULT NULL,
  KEY `member_Id` (`member_Id`),
  CONSTRAINT `member_Id` FOREIGN KEY (`member_Id`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `ratingID` int NOT NULL AUTO_INCREMENT,
  `rating` int DEFAULT NULL,
  `rr` int DEFAULT NULL,
  PRIMARY KEY (`ratingID`),
  KEY `rating_restroom` (`rr`),
  CONSTRAINT `rating_restroom` FOREIGN KEY (`rr`) REFERENCES `restroom` (`rrID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `regionName` varchar(255) NOT NULL,
  PRIMARY KEY (`regionName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES ('Allston'),('Back Bay'),('Bay Village'),('Beacon Hill'),('Brighton'),('Charlestown'),('Chinatown–Leather District'),('Dorchester'),('Downtown'),('East Boston'),('Fenway-Kenmore'),('Hyde Park'),('Jamaica Plain'),('Mattapan'),('Mission Hill'),('North End'),('Roslindale'),('Roxbury'),('South Boston'),('South End'),('West End'),('West Roxbury'),('Wharf District');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restroom`
--

DROP TABLE IF EXISTS `restroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restroom` (
  `rrID` int NOT NULL AUTO_INCREMENT,
  `rrName` varchar(100) DEFAULT NULL,
  `gender` enum('male','female','family') NOT NULL,
  `rating` int DEFAULT NULL,
  `review` varchar(500) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rrID`),
  KEY `restroom_region` (`region`),
  CONSTRAINT `restroom_region` FOREIGN KEY (`region`) REFERENCES `region` (`regionName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restroom`
--

LOCK TABLES `restroom` WRITE;
/*!40000 ALTER TABLE `restroom` DISABLE KEYS */;
INSERT INTO `restroom` VALUES (1,'Northeastern Curry Student Center','female',5,'Very clean, great mirrors!','Back Bay'),(2,'the golden palace','family',1,'wow, so good!','North End');
/*!40000 ALTER TABLE `restroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `reviewID` int NOT NULL AUTO_INCREMENT,
  `content` varchar(200) DEFAULT NULL,
  `rr` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  KEY `review_restroom` (`rr`),
  CONSTRAINT `review_restroom` FOREIGN KEY (`rr`) REFERENCES `restroom` (`rrID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews_and_rates`
--

DROP TABLE IF EXISTS `reviews_and_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews_and_rates` (
  `user` int DEFAULT NULL,
  `restroom` int DEFAULT NULL,
  KEY `reviews_and_rates_user` (`user`),
  KEY `reviews_and_rates_restroom` (`restroom`),
  CONSTRAINT `reviews_and_rates_restroom` FOREIGN KEY (`restroom`) REFERENCES `restroom` (`rrID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_and_rates_user` FOREIGN KEY (`user`) REFERENCES `user` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews_and_rates`
--

LOCK TABLES `reviews_and_rates` WRITE;
/*!40000 ALTER TABLE `reviews_and_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews_and_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) DEFAULT NULL,
  `password` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'kreena','totala');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-09 23:40:50
