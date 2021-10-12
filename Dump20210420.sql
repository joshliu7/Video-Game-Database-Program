CREATE DATABASE  IF NOT EXISTS `videogames` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `videogames`;
-- MySQL dump 10.13  Distrib 8.0.24, for Win64 (x86_64)
--
-- Host: localhost    Database: videogames
-- ------------------------------------------------------
-- Server version	8.0.24

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
-- Table structure for table `admin_user`
--

DROP TABLE IF EXISTS `admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_user` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  PRIMARY KEY (`admin_id`),
  KEY `admin_user_fk_app_user` (`username`),
  CONSTRAINT `admin_user_fk_app_user` FOREIGN KEY (`username`) REFERENCES `app_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_user`
--

LOCK TABLES `admin_user` WRITE;
/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user` (
  `username` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user`
--

LOCK TABLES `app_user` WRITE;
/*!40000 ALTER TABLE `app_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `developer` (
  `dev_name` varchar(100) NOT NULL,
  `triple_a` tinyint(1) NOT NULL,
  PRIMARY KEY (`dev_name`),
  UNIQUE KEY `dev_name` (`dev_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES ('2K Games',1),('Bandai Namco',1),('Bethesda Game Studios',1),('BioWare',1),('Blizzard Entertainment',1),('Bungie',1),('Capcom',1),('CD Project Red',1),('Dodge Roll',0),('EA Sports',1),('Edmund McMillen',0),('Epic Games',1),('Facepunch Studios',0),('Firaxis Games',0),('FromSoftware',1),('Hopoo Games',0),('Infinity Ward',0),('Kinetic Games',0),('Mega Crit Games',0),('Mojang Studios',0),('Moon Studios',0),('Mossmouth',0),('Motion Twin',0),('Naughty Dog',1),('NetherRealm Studios',1),('Neversoft',0),('Nintendo',1),('Pearl Abyss',0),('PUBG Studio',0),('Re-Logic',0),('Red Barrels',0),('Respawn Entertainment',1),('Riot Games',1),('Rockstar Games',1),('Rocksteady Studios',1),('Square Enix',1),('Studio Wildcard',0),('Supergiant Games',0),('Team Cherry',0),('Treyarch',1),('Ubisoft',1),('Unknown Worlds Entertainment',0),('Valve Corporation',1),('Visual Concepts',1),('ZeniMax Online Studios',1);
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites_list`
--

DROP TABLE IF EXISTS `favorites_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites_list` (
  `games_list_id` int NOT NULL AUTO_INCREMENT,
  `public` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(100) NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`games_list_id`),
  KEY `favorites_list_fk_app_user` (`username`),
  KEY `favorites_list_fk_game` (`game_id`),
  CONSTRAINT `favorites_list_fk_app_user` FOREIGN KEY (`username`) REFERENCES `app_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favorites_list_fk_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites_list`
--

LOCK TABLES `favorites_list` WRITE;
/*!40000 ALTER TABLE `favorites_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `game_name` varchar(100) NOT NULL,
  `game_rating` double NOT NULL,
  `competitive` tinyint(1) NOT NULL,
  `genre_name` varchar(100) NOT NULL,
  `dev_name` varchar(100) NOT NULL,
  PRIMARY KEY (`game_id`),
  KEY `game_fk_genre` (`genre_name`),
  KEY `game_fk_developer` (`dev_name`),
  CONSTRAINT `game_fk_developer` FOREIGN KEY (`dev_name`) REFERENCES `developer` (`dev_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `game_fk_genre` FOREIGN KEY (`genre_name`) REFERENCES `genre` (`genre_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'The Legend of Zelda: Ocarina of Time',9.2,0,'Action Adventure','Nintendo'),(2,'Tony Hawk Pro Skater 2',7.4,0,'Sports','Neversoft'),(3,'Grand Theft Auto IV',7.5,0,'Action Adventure','Rockstar Games'),(4,'Soulcalibur VI',8.6,1,'Fighting','Bandai Namco'),(5,'Super Mario Galaxy',9,0,'Platformer','Nintendo'),(6,'Super Mario Galaxy 2',9.1,0,'Platformer','Nintendo'),(7,'Red Dead Redemption 2',7.7,0,'Action Adventure','Rockstar Games'),(8,'Grand Theft Auto V',7.8,0,'Action Adventure','Rockstar Games'),(9,'The Legend of Zelda: Breath of the Wild',8.4,0,'Action Adventure','Nintendo'),(10,'Tony Hawks Pro Skater 3',7.4,0,'Sports','Neversoft'),(11,'PUBG',8.6,1,'Battle Royale','PUBG Studio'),(12,'Super Mario Odyssey',9,0,'Action Adventure','Nintendo'),(13,'Half-Life',9.2,0,'First Person Shooter','Valve Corporation'),(14,'BioShock',8.9,0,'Action RPG','2K Games'),(15,'Resident Evil 4',9.4,0,'Horror','Capcom'),(16,'Batman: Arkham City',8.7,0,'Action Adventure','Rocksteady Studios'),(17,'Mass Effect 2',8.9,0,'Action RPG','BioWare'),(18,'The Elder Scrolls V: Skyrim',8.5,0,'Action RPG','Bethesda Game Studios'),(19,'Half-Life 2',9,0,'First Person Shooter','Valve Corporation'),(20,'The Last of Us',9.8,0,'Action Adventure','Naughty Dog'),(21,'Portal 2',8.4,0,'Strategy','Valve Corporation'),(22,'BioShock Infinite',8.4,0,'Action RPG','2K Games'),(23,'Valorant',8,1,'First Person Shooter','Riot Games'),(24,'Dota 2',9,1,'Moba','Valve Corporation'),(25,'Counter-Strike: Global Offensive',8.3,1,'First Person Shooter','Valve Corporation'),(26,'Fortnite',8.1,1,'Battle Royale','Epic Games'),(27,'League of Legends',7.8,1,'Moba','Riot Games'),(28,'StarCraft 2',8.5,1,'Strategy','Blizzard Entertainment'),(29,'Overwatch',9.1,1,'First Person Shooter','Blizzard Entertainment'),(30,'Hearthstone',8.8,1,'Strategy','Blizzard Entertainment'),(31,'Rainbow Six Siege',7.9,1,'First Person Shooter','Ubisoft'),(32,'Call of Duty: Black Ops 4',8.3,1,'First Person Shooter','Treyarch'),(33,'Apex Legends',8.8,1,'Battle Royale','Respawn Entertainment'),(34,'World of WarCraft',9.1,0,'MMORPG','Blizzard Entertainment'),(35,'Super Smash Bros Ultimate',9.3,1,'Fighting','Nintendo'),(36,'Super Smash Bros Melee',9.2,1,'Fighting','Nintendo'),(37,'Injustice 2',8.8,1,'Fighting','NetherRealm Studios'),(38,'Mortal Kombat 11',8.6,1,'Fighting','NetherRealm Studios'),(39,'Mortal Kombat X',8.3,1,'Fighting','NetherRealm Studios'),(40,'Mortal Kombat XL',8.5,1,'Fighting','NetherRealm Studios'),(41,'Tekken 7',8.2,1,'Fighting','Bandai Namco'),(42,'Tekken 3',9.6,1,'Fighting','Bandai Namco'),(43,'Tekken 6',8,1,'Fighting','Bandai Namco'),(44,'Dark Souls 3',8.9,0,'Soulslike','FromSoftware'),(45,'Dark Souls',8.4,0,'Soulslike','FromSoftware'),(46,'Dark Souls 2',9.1,0,'Soulslike','FromSoftware'),(47,'Sekiro: Shadows Die Twice',9,0,'Soulslike','FromSoftware'),(48,'Monster Hunter Rise',8.9,0,'Action RPG','Capcom'),(49,'Monster Hunter: World',9,0,'Action RPG','Capcom'),(50,'Monster Hunter Generations',8.5,0,'Action RPG','Capcom'),(51,'Monster Hunter Generations Ultimate',8,0,'Action RPG','Capcom'),(52,'Destiny 2',8.5,0,'First Person Shooter','Bungie'),(53,'The Elder Scrolls Online',7.1,0,'MMORPG','ZeniMax Online Studios'),(54,'The Elder Scrolls IV: Oblivion',9.4,0,'Action RPG','Bethesda Game Studios'),(55,'Enter the Gungeon',8.7,0,'Roguelike','Dodge Roll'),(56,'Dead Cells',8.9,0,'Roguelike','Motion Twin'),(57,'The Binding of Isaac',8.8,0,'Roguelike','Edmund McMillen'),(58,'Spelunky',9,0,'Roguelike','Mossmouth'),(59,'The Witcher 3: Wild Hunt',9.3,0,'Action RPG','CD Project Red'),(60,'Slay the Spire',8.9,0,'Roguelike','Mega Crit Games'),(61,'Hades',9.3,0,'Roguelike','Supergiant Games'),(62,'Team Fortress 2',9.2,1,'First Person Shooter','Valve Corporation'),(63,'Risk of Rain 2',8.5,0,'Roguelike','Hopoo Games'),(64,'Rust',6.9,1,'Survival','Facepunch Studios'),(65,'Terraria',8.3,0,'Survival','Re-Logic'),(66,'Minecraft',9.3,0,'Survival','Mojang Studios'),(67,'Call of Duty: Warzone',7.9,1,'Battle Royale','Infinity Ward'),(68,'NBA 2k20',7.8,1,'Sports','Visual Concepts'),(69,'NFL 20',7.7,1,'Sports','EA Sports'),(70,'Fifa 20',7.9,1,'Sports','EA Sports'),(71,'NBA 2k19',8.2,1,'Sports','Visual Concepts'),(72,'Hollow Knight',9.2,0,'Platformer','Team Cherry'),(73,'Ori and the Blind Forest',8.8,0,'Platformer','Moon Studios'),(74,'Phasmophobia',8.7,0,'Horror','Kinetic Games'),(75,'Resident Evil 2',8.9,0,'Horror','Capcom'),(76,'Outlast',8,0,'Horror','Red Barrels'),(77,'Civilization VI',8.8,1,'Strategy','Firaxis Games'),(78,'Black Desert Online',7.3,0,'MMORPG','Pearl Abyss'),(79,'Final Fantasy XIV Online',4.9,0,'MMORPG','Square Enix'),(80,'Subnautica',8.7,0,'Survival','Unknown Worlds Entertainment'),(81,'ARK: Survival Evolved',6.9,1,'Survival','Studio Wildcard');
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_name` varchar(100) NOT NULL,
  PRIMARY KEY (`genre_name`),
  UNIQUE KEY `genre_name` (`genre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES ('Action Adventure'),('Action RPG'),('Battle Royale'),('Fighting'),('First Person Shooter'),('Horror'),('MMORPG'),('Moba'),('Platformer'),('Roguelike'),('Soulslike'),('Sports'),('Strategy'),('Survival');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `player_name` varchar(100) NOT NULL,
  `tournament_id` int NOT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `player_id` (`player_id`),
  KEY `player_fk_tournament` (`tournament_id`),
  CONSTRAINT `player_fk_tournament` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`tournament_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendations_list`
--

DROP TABLE IF EXISTS `recommendations_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendations_list` (
  `games_list_id` int NOT NULL AUTO_INCREMENT,
  `public` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(100) NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`games_list_id`),
  KEY `recommendations_list_fk_app_user` (`username`),
  KEY `recommendations_list_fk_game` (`game_id`),
  CONSTRAINT `recommendations_list_fk_app_user` FOREIGN KEY (`username`) REFERENCES `app_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recommendations_list_fk_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendations_list`
--

LOCK TABLES `recommendations_list` WRITE;
/*!40000 ALTER TABLE `recommendations_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendations_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regular_user`
--

DROP TABLE IF EXISTS `regular_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regular_user` (
  `regular_user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  PRIMARY KEY (`regular_user_id`),
  KEY `regular_user_fk_app_user` (`username`),
  CONSTRAINT `regular_user_fk_app_user` FOREIGN KEY (`username`) REFERENCES `app_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regular_user`
--

LOCK TABLES `regular_user` WRITE;
/*!40000 ALTER TABLE `regular_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `regular_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament`
--

DROP TABLE IF EXISTS `tournament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tournament` (
  `tournament_id` int NOT NULL AUTO_INCREMENT,
  `tournament_name` varchar(100) NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`tournament_id`),
  KEY `tournament_fk_game` (`game_id`),
  CONSTRAINT `tournament_fk_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament`
--

LOCK TABLES `tournament` WRITE;
/*!40000 ALTER TABLE `tournament` DISABLE KEYS */;
INSERT INTO `tournament` VALUES (1,'Zelda Cup',1),(2,'Tony Hawk Cup',2),(3,'Grand Theft Auto IV Cup',3);
/*!40000 ALTER TABLE `tournament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watch_list`
--

DROP TABLE IF EXISTS `watch_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `watch_list` (
  `games_list_id` int NOT NULL AUTO_INCREMENT,
  `public` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(100) NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`games_list_id`),
  KEY `watch_list_fk_app_user` (`username`),
  KEY `watch_list_fk_game` (`game_id`),
  CONSTRAINT `watch_list_fk_app_user` FOREIGN KEY (`username`) REFERENCES `app_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `watch_list_fk_game` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch_list`
--

LOCK TABLES `watch_list` WRITE;
/*!40000 ALTER TABLE `watch_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `watch_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'videogames'
--

--
-- Dumping routines for database 'videogames'
--
/*!50003 DROP FUNCTION IF EXISTS `check_admin_or_regular` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_admin_or_regular`(
username VARCHAR(50)
) RETURNS varchar(50) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE a VARCHAR(50);
DECLARE b VARCHAR(50);
SELECT username INTO a FROM admin_user WHERE admin_user.username = username;
SELECT username INTO b FROM regular_user WHERE regular_user.username = username;
IF ISNULL(a) AND ISNULL(b) 
THEN RETURN 'neither';
ELSEIF ISNULL(b) 
THEN RETURN 'admin';
ELSEIF ISNULL(a) 
THEN RETURN 'regular';
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_valid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_valid`(
game_name VARCHAR(50)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result VARCHAR(50);
SELECT game_name INTO result FROM game WHERE game.game_name = game_name;
IF ISNULL(result)
THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_valid_dev` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_valid_dev`(
dev_name VARCHAR(50)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result VARCHAR(50);
SELECT dev_name INTO result FROM developer WHERE developer.dev_name = dev_name;
IF ISNULL(result)
THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_valid_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_valid_genre`(
genre_name VARCHAR(50)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result VARCHAR(50);
SELECT genre_name INTO result FROM genre WHERE genre.genre_name = genre_name;
IF ISNULL(result)
THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `game_name_to_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `game_name_to_id`(game_name VARCHAR(100)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result INT;
SELECT game_id INTO result FROM game WHERE 
game.game_name = game_name;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `login`(username VARCHAR(100), user_password VARCHAR(100)) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result VARCHAR(100);
SELECT username INTO result FROM app_user WHERE app_user.username = username 
AND app_user.user_password = user_password;
IF ISNULL(result)
THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `prefer_competitive_or_casual` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `prefer_competitive_or_casual`() RETURNS varchar(100) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
	DECLARE A INT;
	DECLARE B INT;
    
    SELECT COUNT(*) FROM favorites_list NATURAL JOIN game WHERE competitive = TRUE INTO A;
	SELECT COUNT(*) FROM favorites_list NATURAL JOIN game WHERE competitive = FALSE INTO B;

	IF A > B
	THEN RETURN 'Competitive games are prefered';
	ELSEIF A < B
    THEN RETURN 'Casual games are prefered';
	ELSEIF A = B
    THEN RETURN 'Neither game is prefered';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `tourney_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `tourney_id`(tournament_name VARCHAR(100)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result INT;
SELECT tournament_id INTO result FROM tournament WHERE tournament.tournament_name = tournament_name;
RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `unique_account` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `unique_account`(
username VARCHAR(100)
) RETURNS tinyint(1)
    READS SQL DATA
    DETERMINISTIC
BEGIN
DECLARE result VARCHAR(100);
SELECT username INTO result FROM app_user WHERE app_user.username = username;
IF ISNULL(result)
THEN RETURN TRUE;
ELSE RETURN FALSE;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_admin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_admin`(
username VARCHAR(50), 
user_password VARCHAR(50)
)
BEGIN
INSERT INTO admin_user (username, user_password) 
VALUES (username, user_password);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_regular` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_regular`(
username VARCHAR(50), 
user_password VARCHAR(50)
)
BEGIN
INSERT INTO regular_user (username, user_password) 
VALUES (username, user_password);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_to_database` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_database`(
game_id INT, game_name VARCHAR(50), 
game_rating DOUBLE, competitive BOOLEAN, 
genre_name VARCHAR(50), dev_name VARCHAR(50)
)
BEGIN
INSERT INTO game (game_id, game_name, game_rating, competitive, genre_name, dev_name) 
VALUES (game_id, game_name, game_rating, competitive, genre_name, dev_name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_to_favorites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_favorites`(game_id INT, username VARCHAR(100))
BEGIN 
INSERT INTO favorites_list(username, game_id)
VALUES (username, game_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_to_recommendations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_recommendations`(genre_name VARCHAR(100), username VARCHAR(100))
BEGIN 
DECLARE A INT;

    SELECT game_id INTO A FROM game WHERE game.genre_name = genre_name 
    AND game_id NOT IN (
	SELECT game_id FROM recommendations_list WHERE recommendations_list.username = username
    UNION (SELECT game_id FROM  favorites_list WHERE favorites_list.username = username)
	UNION  (SELECT game_id FROM  watch_list WHERE watch_list.username = username)) 
    ORDER BY game_rating DESC LIMIT 1;
    
    INSERT INTO recommendations_list (username, game_id)
	VALUES (username, A);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_to_watch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_watch`(game_id INT, username VARCHAR(100))
BEGIN 
INSERT INTO watch_list (username, game_id)
VALUES (username, game_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_account` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_account`(username VARCHAR(100), user_password VARCHAR(100))
BEGIN
INSERT INTO app_user (username, user_password)
VALUES (username, user_password);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_from_database` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_from_database`(
game_name VARCHAR(50)
)
BEGIN
DELETE FROM game WHERE game.game_name = game_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_from_faves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_from_faves`(game_name VARCHAR(50), username VARCHAR(50))
BEGIN
DECLARE A INT;
SELECT game_id FROM favorites_list NATURAL JOIN game WHERE game.game_name = game_name INTO A;
DELETE FROM favorites_list WHERE favorites_list.username = username AND favorites_list.game_id = A;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_from_watch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_from_watch`(game_name VARCHAR(50), username VARCHAR(50))
BEGIN
DECLARE A INT;
SELECT game_id FROM watch_list NATURAL JOIN game WHERE game.game_name = game_name INTO A;
DELETE FROM watch_list WHERE watch_list.username = username AND watch_list.game_id = A;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `most_popular_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `most_popular_game`()
BEGIN
    SELECT game_name FROM favorites_list NATURAL JOIN game GROUP BY game_name 
    ORDER BY COUNT(game_name) DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `most_popular_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `most_popular_genre`()
BEGIN
    SELECT genre_name FROM favorites_list NATURAL JOIN game GROUP BY genre_name 
    ORDER BY COUNT(genre_name) DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `private_favorites_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `private_favorites_list`(username VARCHAR(100))
BEGIN 
UPDATE favorites_list
SET public = FALSE
WHERE favorites_list.username = username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `private_recommendations_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `private_recommendations_list`(username VARCHAR(100))
BEGIN 
UPDATE recommendations_list
SET public = FALSE
WHERE recommendations_list.username = username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `private_watch_list` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `private_watch_list`(username VARCHAR(100))
BEGIN 
UPDATE watch_list
SET public = FALSE
WHERE watch_list.username = username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register`(tournament_id INT, player_name VARCHAR(100))
BEGIN
INSERT INTO player (tournament_id, player_name) VALUES
(tournament_id, player_name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_title` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_title`(game_name VARCHAR(100))
BEGIN
SELECT * FROM game WHERE game.game_name = game_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_database` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_database`(
game_id INT,
game_name VARCHAR(50),
game_name2 VARCHAR(50),
game_rating DOUBLE,
competitive BOOLEAN,
genre_name VARCHAR(50),
dev_name VARCHAR(50)
)
BEGIN
UPDATE game 
SET game.game_id = game_id,
game_name = game_name,
game_rating = game_rating,
competitive = competitive,
genre_name = genre_name,
dev_name = dev_name
WHERE game.game_name = game_name2;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_games_dev` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_games_dev`(dev_name VARCHAR(100))
BEGIN
SELECT * FROM game WHERE game.dev_name = dev_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_games_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_games_genre`(genre_name VARCHAR(100))
BEGIN
SELECT * FROM game WHERE game.genre_name = genre_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-20 23:47:22
