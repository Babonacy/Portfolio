-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: plytoteka
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `albumy`
--

DROP TABLE IF EXISTS `albumy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albumy` (
  `id_albumu` int unsigned NOT NULL AUTO_INCREMENT,
  `id_zespolu1` int unsigned DEFAULT NULL,
  `tytul` varchar(30) NOT NULL,
  `data_wyd` year DEFAULT NULL,
  `dlugosc` int unsigned DEFAULT '0',
  `ile_utworow` int unsigned DEFAULT '0',
  `wydawca` varchar(40) DEFAULT NULL,
  `typ` enum('album studyjny','soundtrack','kompilacja','album koncertowy','remix','cover','demo','album internetowy','album promocyjny','minialbum','split') DEFAULT NULL,
  PRIMARY KEY (`id_albumu`),
  KEY `id_zespolu_idx` (`id_zespolu1`),
  CONSTRAINT `id_zespolu1` FOREIGN KEY (`id_zespolu1`) REFERENCES `zespoly` (`id_zespolu`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albumy`
--

LOCK TABLES `albumy` WRITE;
/*!40000 ALTER TABLE `albumy` DISABLE KEYS */;
INSERT INTO `albumy` VALUES (1,1,'Californication',1999,2505,10,'Warner Bros Records','album studyjny'),(2,1,'The Getaway',2016,2187,9,'Warner Bros Records','album studyjny'),(3,2,'News of the World',1977,2314,10,'EMI/Parlophone','album studyjny'),(4,2,'A Kind of Magic',1986,2494,10,'EMI/Parlophone','album studyjny'),(5,3,'Living Things',2012,2245,10,'Warner Bros Records','album studyjny'),(6,3,'Live from SoHo',2008,1140,5,'Warner Bros','minialbum'),(7,3,'Reanimation',2002,1034,5,'Warner Bros Records','remix'),(8,3,'Live in Texas',2003,2174,10,'Warner Bros Records','album koncertowy'),(9,4,'Wish You Were Here',1975,2658,5,'Harvest Records','album studyjny'),(10,4,'The Division Bell',1994,1602,5,'EMI','album studyjny'),(11,5,'Rubber Soul',1965,1696,10,'Parlophone','album studyjny'),(12,5,'Yellow Submarine',1969,1843,10,'Capitol','album studyjny'),(13,6,'Highway to Hell',1979,2434,10,'Atlantic Records','album studyjny'),(14,6,'Ballbreake',1995,2491,10,'Albert Production','album studyjny'),(15,7,'Master of Puppetse',1986,3083,7,'Elektra Records','album studyjny'),(16,7,'Reload',1986,3434,9,'Elektra','album studyjny'),(17,8,'Slippery When Wet',1986,2137,9,'Mercury','album studyjny'),(18,8,'Crush',2000,2092,9,'Island','album studyjny'),(19,NULL,'Burnin’',1973,1167,5,'Island','album studyjny'),(20,NULL,'Survival',1979,1123,5,'Island','album studyjny'),(21,NULL,'A Night on the Town',1976,1473,6,'Warner Bros','album studyjny'),(22,NULL,'Blondes Have More Fun',1978,1652,6,'Warner Bros','album studyjny'),(23,NULL,'Encore',2004,1868,6,'Aftermath','album studyjny'),(24,NULL,'Revival',2017,2167,7,'Aftermath','album studyjny'),(25,NULL,'Caribou',1974,1450,6,'MCA','album studyjny'),(26,NULL,'Here and There',1976,1349,5,'MCA','album koncertowy'),(27,NULL,'Thriller',1982,1518,5,'Epic','album studyjny'),(28,NULL,'Dangerous',1991,1975,6,'Epic','album studyjny'),(29,NULL,'Pot Luck',1962,1508,6,'RCA Victor','album studyjny'),(30,NULL,'Fun in Acapulco',1963,1630,6,'RCA Victor','album studyjny'),(34,6,'Testowy',1980,1050,3,'asdasd','cover'),(36,5,'Nie witam',1960,1100,3,'xyz','kompilacja');
/*!40000 ALTER TABLE `albumy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artysci`
--

DROP TABLE IF EXISTS `artysci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artysci` (
  `id_artysty` int unsigned NOT NULL AUTO_INCREMENT,
  `imie` varchar(15) NOT NULL,
  `nazwisko` varchar(20) NOT NULL,
  `pseudonim` varchar(25) DEFAULT NULL,
  `data_ur` date NOT NULL,
  `pocz_kariery` year DEFAULT NULL,
  PRIMARY KEY (`id_artysty`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artysci`
--

LOCK TABLES `artysci` WRITE;
/*!40000 ALTER TABLE `artysci` DISABLE KEYS */;
INSERT INTO `artysci` VALUES (1,'BoB','Marley','Tuff Gong','1945-02-06',1962),(2,'Roderick','Stewart','Rod The Bod','1945-01-10',1961),(3,'Marshall','Mathers','Eminem','1972-10-17',1988),(4,'Elton','John','','1947-03-25',1962),(5,'Michael','Jackson','King of Pop','1958-08-29',1964),(6,'Elvis','Presley','King of Rock and Roll','1935-01-08',1954),(7,'John','Bongiovi Jr','Captain Kidd','1962-03-02',1983),(8,'Tico','Torres','','1953-10-07',1980),(9,'David','Bryan','','1962-02-07',1983),(10,'Hugh','McDonald','','1951-12-28',1994),(11,'Richie','Sambora','','1959-07-11',1983),(12,'Alec','Such','','1951-11-14',1983),(13,'James','Hetfield','','1962-08-03',1978),(14,'Lars','Ulrich','','1963-12-26',1981),(15,'Kirk','Hammett','The Ripper','1962-11-18',1980),(16,'Ron','McGovney','','1962-11-02',1981),(17,'Dave','Mustaine','','1961-09-13',1981),(18,'Brian','Johnson','','1947-10-05',1976),(19,'Cliff','Williams','','1949-12-14',1966),(20,'Angus','Young','','1955-03-31',1973),(21,'Phil','Rudd','','1954-05-19',1975),(22,'William','Bailey Jr','Axl Rose ','1962-02-06',1979),(23,'Dave','Evans','','1953-07-20',1973),(24,'John','Lennon','','1940-10-09',1957),(25,'Paul','McCartney','','1942-06-18',1957),(26,'George','Harrison','','1943-02-25',1957),(27,'Ringo','Starr','','1940-07-07',1957),(28,'Syd','Barrett','Syd','1946-01-06',1963),(29,'David','Gilmour','Harold','1946-03-06',1967),(30,'Nick','Mason','','1944-01-27',1963),(31,'Roger','Waters','','1943-09-06',1965),(32,'Chester','Bennington','Chazy Chaz','1976-03-20',1993),(33,'Mike','Shinoda','Glue','1977-02-11',1996),(34,'Brad','Delson','BBB','1977-12-01',1996),(35,'Dave','Farrell','Phoenix','1977-02-08',1966),(36,'Joseph','Hahn','','1977-03-15',1996),(37,'Farrokh','Bulsara','Freddie Mercury','1946-09-05',1969),(38,'Brian','May','Bri','1947-07-19',1968),(39,'Roger','Taylor','','1949-07-26',1968),(40,'John','Deacon','','1951-08-19',1965),(41,'Anthony','Kiedis','Cole Dammett','1962-11-01',1983),(42,'John','Frusciante','','1970-03-05',1988),(43,'Micheal','Balzary','Flea','1962-10-16',1983),(44,'Chad','Smith','','1961-10-25',1984),(45,'Josh','Klinghoffer','','1979-10-03',1994),(46,'Dave','Navarro','','1967-06-07',1986);
/*!40000 ALTER TABLE `artysci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `czlonkowie`
--

DROP TABLE IF EXISTS `czlonkowie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `czlonkowie` (
  `id_artysty` int unsigned NOT NULL,
  `id_zespolu` int unsigned NOT NULL,
  `pocz_wsp` year NOT NULL,
  `koniec_wsp` year DEFAULT NULL,
  KEY `id_artysty_idx` (`id_artysty`),
  KEY `id_zespolu_idx` (`id_zespolu`),
  CONSTRAINT `id_artysty` FOREIGN KEY (`id_artysty`) REFERENCES `artysci` (`id_artysty`),
  CONSTRAINT `id_zespolu` FOREIGN KEY (`id_zespolu`) REFERENCES `zespoly` (`id_zespolu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `czlonkowie`
--

LOCK TABLES `czlonkowie` WRITE;
/*!40000 ALTER TABLE `czlonkowie` DISABLE KEYS */;
INSERT INTO `czlonkowie` VALUES (7,8,1983,NULL),(8,8,1983,NULL),(9,8,1983,NULL),(10,8,2016,NULL),(11,8,1983,2013),(12,8,1983,2001),(13,7,1981,NULL),(14,7,1981,NULL),(15,7,1983,NULL),(16,7,1981,1982),(17,7,1982,1983),(18,6,1980,NULL),(19,6,1977,NULL),(20,6,1973,NULL),(21,6,1975,NULL),(22,6,2016,2016),(23,6,1973,1974),(24,5,1960,1969),(25,5,1960,1970),(26,5,1960,1970),(27,5,1962,1970),(28,4,1965,1968),(29,4,1968,2022),(30,4,1965,2022),(31,4,1965,2005),(32,3,1999,2017),(33,3,1996,NULL),(34,3,1996,NULL),(35,3,1996,NULL),(36,3,1996,NULL),(37,2,1970,1991),(38,2,1970,NULL),(39,2,1970,NULL),(40,2,1971,2017),(41,1,1983,NULL),(42,1,1988,NULL),(43,1,1983,NULL),(44,1,1989,NULL),(45,1,2009,2019),(46,1,1993,1998),(23,4,1981,1982),(20,8,1980,NULL);
/*!40000 ALTER TABLE `czlonkowie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skladowe`
--

DROP TABLE IF EXISTS `skladowe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skladowe` (
  `id_albumu1` int unsigned NOT NULL,
  `id_utworu` int unsigned NOT NULL,
  `dlugosc` int unsigned NOT NULL,
  `gatunek` enum('rock','jazz','pop','metal','disco polo','reggae','blues','rap','country','muzyka klasyczna','punk') NOT NULL,
  KEY `id_albumu1_idx` (`id_albumu1`),
  KEY `id_utworu_idx` (`id_utworu`),
  CONSTRAINT `id_albumu1` FOREIGN KEY (`id_albumu1`) REFERENCES `albumy` (`id_albumu`),
  CONSTRAINT `id_utworu` FOREIGN KEY (`id_utworu`) REFERENCES `utwory` (`id_utworu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skladowe`
--

LOCK TABLES `skladowe` WRITE;
/*!40000 ALTER TABLE `skladowe` DISABLE KEYS */;
INSERT INTO `skladowe` VALUES (1,1,238,'rock'),(1,2,270,'rock'),(1,3,245,'rock'),(1,4,217,'rock'),(1,5,198,'rock'),(1,6,321,'rock'),(1,7,271,'rock'),(1,8,283,'rock'),(1,9,187,'rock'),(1,10,275,'rock'),(2,11,250,'rock'),(2,12,305,'rock'),(2,13,211,'rock'),(2,14,173,'rock'),(2,15,267,'rock'),(2,16,241,'rock'),(2,17,197,'rock'),(2,18,231,'rock'),(2,19,312,'rock'),(3,20,121,'rock'),(3,21,179,'rock'),(3,22,249,'rock'),(3,23,267,'rock'),(3,24,243,'rock'),(3,25,221,'rock'),(3,26,207,'rock'),(3,27,207,'rock'),(3,28,241,'rock'),(3,29,379,'rock'),(4,30,310,'rock'),(4,31,274,'rock'),(4,32,252,'rock'),(4,33,245,'rock'),(4,34,234,'rock'),(4,35,267,'rock'),(4,36,202,'rock'),(4,37,210,'rock'),(4,38,197,'rock'),(4,39,303,'rock'),(5,40,205,'rock'),(5,41,200,'rock'),(5,42,250,'rock'),(5,43,216,'rock'),(5,44,280,'rock'),(5,45,264,'rock'),(5,46,179,'rock'),(5,47,226,'rock'),(5,48,127,'rock'),(5,49,298,'rock'),(6,50,145,'rock'),(6,51,245,'rock'),(6,52,220,'rock'),(6,53,246,'rock'),(6,54,284,'rock'),(7,55,244,'rap'),(7,56,189,'rap'),(7,57,206,'rap'),(7,58,174,'rap'),(7,59,221,'rap'),(8,60,145,'rock'),(8,61,245,'rock'),(8,62,220,'metal'),(8,63,246,'rock'),(8,64,284,'metal'),(8,65,244,'metal'),(8,66,189,'rock'),(8,67,206,'rock'),(8,68,174,'rock'),(8,69,221,'metal'),(9,70,814,'rock'),(9,71,451,'rock'),(9,72,308,'rock'),(9,73,334,'rock'),(9,74,751,'rock'),(10,75,358,'rock'),(10,76,272,'rock'),(10,77,329,'rock'),(10,78,274,'rock'),(10,79,369,'rock'),(11,80,150,'rock'),(11,81,125,'rock'),(11,82,202,'rock'),(11,83,175,'rock'),(11,84,167,'rock'),(11,85,148,'rock'),(11,86,175,'rock'),(11,87,188,'rock'),(11,88,187,'rock'),(11,89,179,'rock'),(12,90,167,'rock'),(12,91,145,'rock'),(12,92,234,'rock'),(12,93,197,'rock'),(12,94,177,'rock'),(12,95,168,'rock'),(12,96,185,'rock'),(12,97,148,'rock'),(12,98,181,'rock'),(12,99,241,'rock'),(13,100,241,'metal'),(13,101,221,'metal'),(13,102,234,'rock'),(13,103,199,'rock'),(13,104,270,'metal'),(13,105,267,'rock'),(13,106,244,'metal'),(13,107,221,'metal'),(13,108,297,'metal'),(14,109,241,'metal'),(14,110,221,'metal'),(14,111,234,'rock'),(14,112,199,'rock'),(14,113,270,'rock'),(14,114,267,'rock'),(14,115,244,'metal'),(14,116,221,'rock'),(14,117,297,'rock'),(14,118,297,'metal'),(15,119,312,'metal'),(15,120,515,'metal'),(15,121,431,'metal'),(15,122,472,'metal'),(15,123,410,'metal'),(15,124,466,'metal'),(15,125,477,'metal'),(16,126,312,'metal'),(16,127,415,'metal'),(16,128,331,'metal'),(16,129,372,'metal'),(16,130,310,'metal'),(16,131,416,'metal'),(16,132,427,'metal'),(16,133,377,'metal'),(16,134,474,'metal'),(17,135,224,'rock'),(17,136,234,'rock'),(17,137,305,'rock'),(17,138,315,'rock'),(17,139,248,'rock'),(17,140,186,'rock'),(17,141,197,'rock'),(17,142,231,'rock'),(17,143,197,'rock'),(18,144,244,'rock'),(18,145,212,'rock'),(18,146,321,'rock'),(18,147,241,'rock'),(18,148,175,'rock'),(18,149,211,'rock'),(18,150,234,'rock'),(18,151,255,'rock'),(18,152,199,'rock'),(19,153,240,'reggae'),(19,154,232,'reggae'),(19,155,201,'reggae'),(19,156,263,'reggae'),(19,157,231,'reggae'),(20,158,221,'reggae'),(20,159,203,'reggae'),(20,160,222,'reggae'),(20,161,210,'reggae'),(20,162,267,'reggae'),(21,163,239,'rock'),(21,164,251,'rock'),(21,165,274,'rock'),(21,166,234,'rock'),(21,167,266,'rock'),(21,168,209,'rock'),(22,169,331,'rock'),(22,170,276,'rock'),(22,171,264,'rock'),(22,172,258,'disco polo'),(22,173,279,'rock'),(22,174,244,'rock'),(23,175,321,'rap'),(23,176,301,'rap'),(23,177,278,'rap'),(23,178,328,'rap'),(23,179,374,'rap'),(23,180,266,'rap'),(24,181,304,'rap'),(24,182,353,'rap'),(24,183,308,'rap'),(24,184,314,'rap'),(24,185,278,'rap'),(24,186,329,'rap'),(24,187,281,'rap'),(25,188,240,'rock'),(25,189,268,'rock'),(25,190,278,'rock'),(25,191,197,'rock'),(25,192,243,'rock'),(25,193,224,'rock'),(26,194,247,'rock'),(26,195,224,'rock'),(26,196,387,'rock'),(26,197,221,'rock'),(26,198,270,'rock'),(27,199,367,'pop'),(27,200,284,'pop'),(27,201,213,'pop'),(27,202,357,'pop'),(27,203,297,'pop'),(28,204,357,'pop'),(28,205,397,'pop'),(28,206,313,'pop'),(28,207,234,'pop'),(28,208,377,'pop'),(28,209,297,'pop'),(29,210,314,'rock'),(29,211,274,'rock'),(29,212,243,'rock'),(29,213,287,'rock'),(29,214,187,'rock'),(29,215,203,'rock'),(30,216,344,'rock'),(30,217,374,'rock'),(30,218,246,'rock'),(30,219,258,'rock'),(30,220,211,'rock'),(30,221,197,'rock'),(13,7,240,'blues'),(34,1,250,'pop'),(34,5,500,'disco polo'),(34,12,300,'muzyka klasyczna'),(36,223,300,'disco polo'),(36,216,300,'country'),(36,219,500,'muzyka klasyczna');
/*!40000 ALTER TABLE `skladowe` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_dlugosc` AFTER INSERT ON `skladowe` FOR EACH ROW UPDATE `albumy` SET `albumy`.`dlugosc`=(SELECT SUM(`skladowe`.`dlugosc`) FROM `skladowe` WHERE `skladowe`.`id_albumu1`=`albumy`.`id_albumu` GROUP BY `id_albumu1`); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ilosc` AFTER INSERT ON `skladowe` FOR EACH ROW UPDATE `albumy` SET `albumy`.`ile_utworow`=(SELECT count(`skladowe`.`id_utworu`) FROM `skladowe` WHERE `skladowe`.`id_albumu1`=`albumy`.`id_albumu` GROUP BY `id_albumu1`); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_dlugosc_upd` AFTER UPDATE ON `skladowe` FOR EACH ROW UPDATE `albumy` SET `albumy`.`dlugosc`=(SELECT SUM(`skladowe`.`dlugosc`) FROM `skladowe` WHERE `skladowe`.`id_albumu1`=`albumy`.`id_albumu` GROUP BY `id_albumu1`); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ilosc_upd` AFTER UPDATE ON `skladowe` FOR EACH ROW UPDATE `albumy` SET `albumy`.`ile_utworow`=(SELECT count(`skladowe`.`id_utworu`) FROM `skladowe` WHERE `skladowe`.`id_albumu1`=`albumy`.`id_albumu` GROUP BY `id_albumu1`); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_dlugosc_del` AFTER DELETE ON `skladowe` FOR EACH ROW UPDATE `albumy` SET `albumy`.`dlugosc`=(SELECT SUM(`skladowe`.`dlugosc`) FROM `skladowe` WHERE `skladowe`.`id_albumu1`=`albumy`.`id_albumu` GROUP BY `id_albumu1`); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ilosc_del` AFTER DELETE ON `skladowe` FOR EACH ROW UPDATE `albumy` SET `albumy`.`ile_utworow`=(SELECT count(`skladowe`.`id_utworu`) FROM `skladowe` WHERE `skladowe`.`id_albumu1`=`albumy`.`id_albumu` GROUP BY `id_albumu1`); */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `utwory`
--

DROP TABLE IF EXISTS `utwory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utwory` (
  `id_utworu` int unsigned NOT NULL AUTO_INCREMENT,
  `tytul` varchar(40) NOT NULL,
  `autor_tekstu` varchar(20) DEFAULT 'niewiadomo',
  `jezyk` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_utworu`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utwory`
--

LOCK TABLES `utwory` WRITE;
/*!40000 ALTER TABLE `utwory` DISABLE KEYS */;
INSERT INTO `utwory` VALUES (1,'Around the World','Anthony Kiedis','EN'),(2,'Parallel Universe','Anthony Kiedis','EN'),(3,'Scar Tissue','Anthony Kiedis','EN'),(4,'Otherside','Anthony Kiedis','EN'),(5,'Get on Top','Anthony Kiedis','EN'),(6,'Californication','Anthony Kiedis','EN'),(7,'Easily','Anthony Kiedis','EN'),(8,'Porcelain','Anthony Kiedis','EN'),(9,'I Like Dirt','Anthony Kiedis','EN'),(10,'Savior','Anthony Kiedis','EN'),(11,'The Getaway','Anthony Kiedis','EN'),(12,'Dark Necessities','Anthony Kiedis','EN'),(13,'We Turn Red','Anthony Kiedis','EN'),(14,'The Longest Wave','Anthony Kiedis','EN'),(15,'Goodbye Angels','Anthony Kiedis','EN'),(16,'Sick Love','Anthony Kiedis','EN'),(17,'Go Robot','Anthony Kiedis','EN'),(18,'Detroit','Anthony Kiedis','EN'),(19,'Encore','Anthony Kiedis','EN'),(20,'We Will Rock You','Brian May','EN'),(21,'We Are the Champions','Brian May','EN'),(22,'Sheer Heart Attack','Brian May','EN'),(23,'All Dead, All Dead','Brian May','EN'),(24,'Spread Your Wings','Brian May','EN'),(25,'Fight from the Inside','Brian May','EN'),(26,'Get Down, Make Love','Brian May','EN'),(27,'Sleeping on the Sidewalk','Brian May','EN'),(28,'Who Needs You','Brian May','EN'),(29,'It’s Late','Brian May','EN'),(30,'One Vision','Brian May','EN'),(31,'A Kind Of Magic','Brian May','EN'),(32,'One Year of Love','Brian May','EN'),(33,'Pain Is So Close to Pleasure','Brian May','EN'),(34,'Friends Will Be Friends','Brian May','EN'),(35,'Who Wants to Live Forever','Brian May','EN'),(36,'Gimme the Prize','Brian May','EN'),(37,'Don’t Lose Your Head','Brian May','EN'),(38,'Princes of the Universe','Brian May','EN'),(39,'Forever','Brian May','EN'),(40,'Lost in the Echo','Chester Bennington','EN'),(41,'In My Remains','Chester Bennington','EN'),(42,'Burn It Down','Chester Bennington','EN'),(43,'Lies Greed Misery','Chester Bennington','EN'),(44,'I\'ll Be Gone','Chester Bennington','EN'),(45,'Castle of Glass','Chester Bennington','EN'),(46,'Victimized','Chester Bennington','EN'),(47,'Roads Untraveled','Chester Bennington','EN'),(48,'Skin To Bone','Chester Bennington','EN'),(49,'Tinfoil','Chester Bennington','EN'),(50,'Wake','Chester Bennington','EN'),(51,'Given Up','Chester Bennington','EN'),(52,'Shadow of the Day','Chester Bennington','EN'),(53,'My December','Chester Bennington','EN'),(54,'In Pieces','Chester Bennington','EN'),(55,'Enth E Nd','Chester Bennington','EN'),(56,'Frgt/10','Chester Bennington','EN'),(57,'X-ecutioner style','Chester Bennington','EN'),(58,'H! Vltg3','Chester Bennington','EN'),(59,'NtrMssion','Chester Bennington','EN'),(60,'Don\'t Stay','Chester Bennington','EN'),(61,'Somewhere I Belong','Chester Bennington','EN'),(62,'Lying from You','Chester Bennington','EN'),(63,'Papercut','Chester Bennington','EN'),(64,'Runaway','Chester Bennington','EN'),(65,'Faint','Chester Bennington','EN'),(66,'From the Inside','Chester Bennington','EN'),(67,'By Myself','Chester Bennington','EN'),(68,'Numb','Chester Bennington','EN'),(69,'Crawling','Chester Bennington','EN'),(70,'Shine on You Crazy Diamond Part I-V','Syd Barrett','EN'),(71,'Welcome to the Machine','Syd Barrett','EN'),(72,'Have a Cigar','Syd Barrett','EN'),(73,'Wish You Were Here','Syd Barrett','EN'),(74,'Shine on You Crazy Diamond Part VI-IX','Syd Barrett','EN'),(75,'Cluster One','Syd Barrett','EN'),(76,'Marooned','Syd Barrett','EN'),(77,'A Great Day for Freedom','Syd Barrett','EN'),(78,'Take It Back','Syd Barrett','EN'),(79,'Keep Talking','Syd Barrett','EN'),(80,'Drive My Car','John Lennon','EN'),(81,'Norwegian Wood','John Lennon','EN'),(82,'Nowhere Man','John Lennon','EN'),(83,'Think for Yourself','John Lennon','EN'),(84,'The Word','John Lennon','EN'),(85,'Michelle','John Lennon','EN'),(86,'Girl','John Lennon','EN'),(87,'I\'m Looking Through You','John Lennon','EN'),(88,'In My Life','John Lennon','EN'),(89,'Wait','John Lennon','EN'),(90,'Yellow Submarine','John Lennon','EN'),(91,'Only a Northern Song','John Lennon','EN'),(92,'All Together Now','John Lennon','EN'),(93,'Hey Bulldog','John Lennon','EN'),(94,'It\'s All Too Much','John Lennon','EN'),(95,'All You Need Is Love','John Lennon','EN'),(96,'Pepperland','John Lennon','EN'),(97,'Sea of Time','John Lennon','EN'),(98,'Sea of Holes','John Lennon','EN'),(99,'Sea of Monsters','John Lennon','EN'),(100,'Highway to Hell','Bon Scott','EN'),(101,'Girls Got Rhythm','Bon Scott','EN'),(102,'Touch Too Much','Bon Scott','EN'),(103,'Beating Around the Bush','Bon Scott','EN'),(104,'Shot Down in Flames','Bon Scott','EN'),(105,'Get It Hot','Bon Scott','EN'),(106,'If You Want Blood','Bon Scott','EN'),(107,'Love Hungry Man','Bon Scott','EN'),(108,'Night Prowler','Bon Scott','EN'),(109,'Hard as a Rock','Bon Scott','EN'),(110,'Cover You in Oil','Bon Scott','EN'),(111,'Whiskey on the Rocks','Bon Scott','EN'),(112,'The Furor','Bon Scott','EN'),(113,'Boogie Man','Bon Scott','EN'),(114,'The Honey Roll','Bon Scott','EN'),(115,'Burnin’ Alive','Bon Scott','EN'),(116,'Hail Caesar','Bon Scott','EN'),(117,'Love Bomb','Bon Scott','EN'),(118,'Caught with Your Pants Down','Bon Scott','EN'),(119,'Battery','James Hetfield','EN'),(120,'Master of Puppets','James Hetfield','EN'),(121,'Welcome Home','James Hetfield','EN'),(122,'Disposable Heroes','James Hetfield','EN'),(123,'Leper Messiah','James Hetfield','EN'),(124,'Orion','James Hetfield','EN'),(125,'Damage, Inc.','James Hetfield','EN'),(126,'Fuel','James Hetfield','EN'),(127,'The Memory Remains','James Hetfield','EN'),(128,'Devil\'s Dance','James Hetfield','EN'),(129,'The Unforgiven II','James Hetfield','EN'),(130,'Better Than You','James Hetfield','EN'),(131,'Slither','James Hetfield','EN'),(132,'Carpe Diem Baby','James Hetfield','EN'),(133,'Bad Seed','James Hetfield','EN'),(134,'Prince Charming','James Hetfield','EN'),(135,'Let It Rock','Jon Bon Jovi','EN'),(136,'You Give Love a Bad Name','Jon Bon Jovi','EN'),(137,'Livin\' on a Prayer','Jon Bon Jovi','EN'),(138,'Social Disease','Jon Bon Jovi','EN'),(139,'Wanted Dead or Alive','Jon Bon Jovi','EN'),(140,'Raise Your Hands','Jon Bon Jovi','EN'),(141,'Without Love','Jon Bon Jovi','EN'),(142,'I\'d Die for You','Jon Bon Jovi','EN'),(143,'Never Say Goodbye','Jon Bon Jovi','EN'),(144,'It\'s My Life','Jon Bon Jovi','EN'),(145,'Say It Isn\'t So','Jon Bon Jovi','EN'),(146,'Thank You for Loving Me','Jon Bon Jovi','EN'),(147,'Two Story Town','Jon Bon Jovi','EN'),(148,'Next 100 Years','Jon Bon Jovi','EN'),(149,'Just Older','Jon Bon Jovi','EN'),(150,'Mystery Train','Jon Bon Jovi','EN'),(151,'Save the World','Jon Bon Jovi','EN'),(152,'She\'s a Mystery','Jon Bon Jovi','EN'),(153,'Get Up, Stand Up','Bob Marley','EN'),(154,'Hallelujah Time','Bob Marley','EN'),(155,'I Shot the Sheriff','Bob Marley','EN'),(156,'Burnin\' And Lootin','Bob Marley','EN'),(157,'Put It On','Bob Marley','EN'),(158,'So Much Trouble In The World','Bob Marley','EN'),(159,'Zimbabwe','Bob Marley','EN'),(160,'Top Rankin','Bob Marley','EN'),(161,'Babylon System','Bob Marley','EN'),(162,'Survival','Bob Marley','EN'),(163,'Tonight\'s the Night','Rod Stewart','EN'),(164,'The First Cut Is the Deepest','Rod Stewart','EN'),(165,'Fool for You','Rod Stewart','EN'),(166,'The Killing of Georgie','Rod Stewart','EN'),(167,'The Balltrap','Rod Stewart','EN'),(168,'Big Bayou','Rod Stewart','EN'),(169,'Dirty Weeken','Rod Stewart','EN'),(170,'Ain’t Love a Bitch','Rod Stewart','EN'),(171,'The Best Days of My Life','Rod Stewart','EN'),(172,'Attractive Female Wanted','Rod Stewart','EN'),(173,'Last Summer','Rod Stewart','EN'),(174,'Scarred and Scared','Rod Stewart','EN'),(175,'Evil Deeds','Eminem','EN'),(176,'Never Enough','Eminem','EN'),(177,'Yellow Brick Road','Eminem','EN'),(178,'Like Toy Soldiers','Eminem','EN'),(179,'Mosh','Eminem','EN'),(180,'Paul','Eminem','EN'),(181,'Believe','Eminem','EN'),(182,'Chloraseptic','Eminem','EN'),(183,'Untouchable','Eminem','EN'),(184,'River','Eminem','EN'),(185,'Remind Me','Eminem','EN'),(186,'Bad Husband','Eminem','EN'),(187,'Tragic Endings','Eminem','EN'),(188,'The Bitch is Back','Elton John','EN'),(189,'Pinky','Elton John','EN'),(190,'Grimsby','Elton John','EN'),(191,'Dixie Lily','Elton John','EN'),(192,'You\'re So Static','Elton John','EN'),(193,'Stinker','Elton John','EN'),(194,'Skyline Pigeon','Elton John','EN'),(195,'Border Song','Elton John','EN'),(196,'Honky Cat','Elton John','EN'),(197,'Love Song','Elton John','EN'),(198,'Crocodile Rock','Elton John','EN'),(199,'Wanna Be Startin’ Somethin','Micheal Jackson','EN'),(200,'Baby Be Mine','Micheal Jackson','EN'),(201,'The Girl Is Mine','Micheal Jackson','EN'),(202,'Thriller','Micheal Jackson','EN'),(203,'Beat It','Micheal Jackson','EN'),(204,'Jam','Micheal Jackson','EN'),(205,'Why You Wanna Trip On Me','Micheal Jackson','EN'),(206,'In the Closet','Micheal Jackson','EN'),(207,'She Drives Me Wild','Micheal Jackson','EN'),(208,'Can\'t Let Her Get Away','Micheal Jackson','EN'),(209,'Black or White','Micheal Jackson','EN'),(210,'Kiss Me Quick','Elvis Presley','EN'),(211,'Just For Old Time Sake','Elvis Presley','EN'),(212,'I\'m Yours','Elvis Presley','EN'),(213,'Something Blue','Elvis Presley','EN'),(214,'Suspicion','Elvis Presley','EN'),(215,'Night Rider','Elvis Presley','EN'),(216,'Mexico','Elvis Presley','EN'),(217,'El Toro','Elvis Presley','EN'),(218,'Marguerita','Elvis Presley','EN'),(219,'Bossa Nova Baby','Elvis Presley','EN'),(220,'Guadalajara','Elvis Presley','EN'),(221,'Love Me Tonight','Elvis Presley','EN'),(223,'1234','Ja','PL');
/*!40000 ALTER TABLE `utwory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wystapienia`
--

DROP TABLE IF EXISTS `wystapienia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wystapienia` (
  `id_artysty1` int unsigned NOT NULL,
  `id_albumu` int unsigned NOT NULL,
  KEY `id_artysty_idx` (`id_artysty1`),
  KEY `id_albumu_idx` (`id_albumu`),
  CONSTRAINT `id_albumu` FOREIGN KEY (`id_albumu`) REFERENCES `albumy` (`id_albumu`),
  CONSTRAINT `id_artysty1` FOREIGN KEY (`id_artysty1`) REFERENCES `artysci` (`id_artysty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wystapienia`
--

LOCK TABLES `wystapienia` WRITE;
/*!40000 ALTER TABLE `wystapienia` DISABLE KEYS */;
INSERT INTO `wystapienia` VALUES (1,19),(1,20),(2,21),(2,22),(3,23),(3,24),(4,25),(4,26),(5,27),(5,28),(6,29),(6,30);
/*!40000 ALTER TABLE `wystapienia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zespoly`
--

DROP TABLE IF EXISTS `zespoly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zespoly` (
  `id_zespolu` int unsigned NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(25) NOT NULL,
  `data_zal` year DEFAULT NULL,
  `pochodzenie` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_zespolu`),
  UNIQUE KEY `nazwa_UNIQUE` (`nazwa`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zespoly`
--

LOCK TABLES `zespoly` WRITE;
/*!40000 ALTER TABLE `zespoly` DISABLE KEYS */;
INSERT INTO `zespoly` VALUES (1,'Red Hot Chili Peppers',1983,'USA'),(2,'Queen',1970,'Wielka Brytania'),(3,'Linkin Park',1996,'USA'),(4,'Pink Floyd',1965,'Wielka Brytania'),(5,'The Beatles',1960,'Wielka Brytania'),(6,'AC/DC',1973,'Australia'),(7,'Metallica',1981,'USA'),(8,'Bon Jovi',1983,'USA');
/*!40000 ALTER TABLE `zespoly` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-27  9:35:26
