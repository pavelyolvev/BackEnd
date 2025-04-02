-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: stroi_calc
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calculation`
--

DROP TABLE IF EXISTS `calculation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calculation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `address_object_constractions` varchar(400) NOT NULL,
  `number` int NOT NULL,
  `created_date` datetime NOT NULL,
  `calculation_state_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calculation`
--

LOCK TABLES `calculation` WRITE;
/*!40000 ALTER TABLE `calculation` DISABLE KEYS */;
INSERT INTO `calculation` VALUES (1,1,'г.Самара, Московское шоссе, 77А',1,'2025-03-31 18:50:21',1),(2,1,'г. Москва, ул. Ленина, д. 10',2,'2025-03-31 19:23:31',1),(3,1,'г. Москва, ул. Ленина, д. 10',3,'2025-03-17 12:07:56',2),(4,1,'Введите адрес',4,'2025-03-17 12:09:15',2),(5,1,'Введите адрес',5,'2025-03-17 12:11:15',2),(6,1,'Введите адрес',6,'2025-03-17 12:46:01',2),(9,1,'jkb',7,'2025-03-26 11:35:22',1),(10,1,'',8,'2025-03-26 11:57:25',1),(11,1,'',9,'2025-03-26 11:59:18',1),(12,1,'',10,'2025-03-26 12:03:37',1),(13,1,'',11,'2025-03-26 12:23:19',1),(14,1,'',12,'2025-03-26 12:25:06',1),(15,1,'',13,'2025-03-27 18:32:29',1),(16,1,'',14,'2025-03-27 18:41:02',1),(17,1,'',15,'2025-03-27 18:41:42',1),(18,1,'',16,'2025-03-27 18:56:46',1),(19,1,'',17,'2025-03-27 19:00:43',1),(20,1,'',18,'2025-03-27 19:04:37',1),(21,1,'',19,'2025-03-27 19:06:55',1),(22,1,'',20,'2025-03-27 19:09:16',1),(23,1,'',21,'2025-03-27 19:15:41',1),(24,1,'',22,'2025-03-27 19:16:45',1),(25,1,'',23,'2025-03-27 19:18:40',1),(26,1,'',24,'2025-03-27 19:21:20',1),(27,1,'',25,'2025-03-27 19:21:55',1),(28,1,'',26,'2025-03-28 07:59:52',1),(29,1,'',27,'2025-03-28 08:09:09',1),(30,1,'',28,'2025-03-28 08:15:19',1),(31,1,'',29,'2025-03-28 08:15:45',1),(32,1,'',30,'2025-03-28 08:16:38',1),(33,1,'',31,'2025-03-28 08:23:04',1),(34,1,'',32,'2025-03-28 08:25:50',1),(35,1,'',33,'2025-03-28 08:26:26',1),(36,1,'',34,'2025-03-28 08:31:26',1),(37,1,'',35,'2025-03-28 08:38:39',1),(38,1,'',36,'2025-03-28 08:43:07',1),(39,1,'г. Москва, ул. Ленина, д. 10',37,'2025-03-28 15:27:28',1),(42,1,'as',38,'2025-03-28 21:36:24',1),(43,1,'as',39,'2025-03-28 21:37:07',1),(45,1,'',40,'2025-03-28 22:14:41',1),(46,1,'',41,'2025-03-28 22:34:35',1),(48,1,'',43,'2025-03-28 22:35:50',1),(50,1,'2этажа',45,'2025-03-29 12:54:45',1),(55,1,'',46,'2025-04-02 07:23:30',1),(62,1,'2этажа',47,'2025-04-02 11:08:07',1),(64,1,'',48,'2025-04-02 14:33:12',1),(70,1,'2этажа',49,'2025-04-02 17:20:49',1);
/*!40000 ALTER TABLE `calculation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calculation_state`
--

DROP TABLE IF EXISTS `calculation_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calculation_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calculation_state`
--

LOCK TABLES `calculation_state` WRITE;
/*!40000 ALTER TABLE `calculation_state` DISABLE KEYS */;
INSERT INTO `calculation_state` VALUES (1,'Актуален'),(2,'Не актуален'),(3,'Заключен договор');
/*!40000 ALTER TABLE `calculation_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `second_name` varchar(45) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `e-mail` varchar(45) NOT NULL,
  `adress` varchar(45) NOT NULL,
  `users_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Иванов','Иван','Иванович','+79131231212','ivanov@mail.ru','г. Самара, Московское шоссе, д77',1),(3,'Иванова','Анна','Сергеевна','+79376341252','Anna@psuti.ru','г. Самара, Московское шоссе, д.18А',1);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_characteristics`
--

DROP TABLE IF EXISTS `material_characteristics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_characteristics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `measurement_unit_id` int NOT NULL,
  `materials_id` int NOT NULL,
  `length` float DEFAULT NULL,
  `wedth` float DEFAULT NULL,
  `thickness` float DEFAULT NULL,
  `volume` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_characteristics`
--

LOCK TABLES `material_characteristics` WRITE;
/*!40000 ALTER TABLE `material_characteristics` DISABLE KEYS */;
INSERT INTO `material_characteristics` VALUES (1,'Доска',3,1,3000,100,50,0.015),(2,'Доска',3,1,3000,150,50,0.0225),(3,'Доска',3,1,3000,200,50,0.03),(4,'Доска',3,1,3000,250,50,0.0375),(5,'Доска',3,1,3000,300,50,0.045),(6,'Доска',3,1,6000,100,50,0.03),(7,'Доска',3,1,6000,150,50,0.045),(8,'Доска',3,1,6000,200,50,0.06),(9,'Доска',3,1,6000,250,50,0.075),(10,'Доска',3,1,6000,300,50,0.09),(11,'OSB',2,2,NULL,NULL,9,NULL),(12,'OSB',2,2,NULL,NULL,10,NULL),(13,'OSB',2,2,NULL,NULL,15,NULL),(14,'OSB',2,2,NULL,NULL,18,NULL),(15,'Кнауф ТеплоКнауф 100 мм',2,3,NULL,NULL,100,NULL),(16,'Технониколь 100 мм',2,3,NULL,NULL,100,NULL),(17,'Эковер 100 мм',2,3,NULL,NULL,100,NULL),(18,'Эковер 150 мм',2,3,NULL,NULL,150,NULL),(19,'Эковер 200 мм',2,3,NULL,NULL,200,NULL),(20,'Фасад 200 мм',2,3,NULL,NULL,200,NULL),(21,'Эковер 250 мм',2,3,NULL,NULL,250,NULL),(22,'Ондутис',2,5,NULL,NULL,NULL,NULL),(23,'Пароизоляция Axton (b)',2,5,NULL,NULL,NULL,NULL),(24,'Пароизоляционная пленка Ютафол Н 96 Сильвер',2,5,NULL,NULL,NULL,NULL),(25,'Пароизоляция В',2,5,NULL,NULL,NULL,NULL),(26,'Ветро-влагозащитная мембрана Brane А',2,4,NULL,NULL,NULL,NULL),(27,'Паропроницаемая ветро-влагозащита A Optima',2,4,NULL,NULL,NULL,NULL),(28,'Гидро-ветрозащита Тип А',2,4,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `material_characteristics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `material_type` varchar(200) DEFAULT NULL,
  `structural_element_type` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'Доска','Пиломатериал','Каркас'),(2,'OSB','OSB','Каркас'),(3,'Утеплитель','Утеплитель','Каркас'),(4,'Ветрозащита','Ветрозащита','Каркас'),(5,'Пароизоляция','Пароизоляци','Каркас');
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurement_units`
--

DROP TABLE IF EXISTS `measurement_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `measurement_units` (
  `id` int NOT NULL AUTO_INCREMENT,
  `measurement_units_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurement_units`
--

LOCK TABLES `measurement_units` WRITE;
/*!40000 ALTER TABLE `measurement_units` DISABLE KEYS */;
INSERT INTO `measurement_units` VALUES (1,'м'),(2,'м2'),(3,'м3'),(4,'мм');
/*!40000 ALTER TABLE `measurement_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openings`
--

DROP TABLE IF EXISTS `openings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `openings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(200) NOT NULL,
  `width` float NOT NULL,
  `height` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openings`
--

LOCK TABLES `openings` WRITE;
/*!40000 ALTER TABLE `openings` DISABLE KEYS */;
INSERT INTO `openings` VALUES (3,'window',3,2),(4,'externalDoor',1,2),(5,'internalDoor',1,1),(6,'window',1,2),(7,'externalDoor',2,1),(8,'internalDoor',2,1),(9,'window',1,2),(10,'externalDoor',2,1),(11,'internalDoor',1,1),(12,'window',1,2),(13,'externalDoor',2,1),(14,'internalDoor',1,1),(15,'window',1,2),(16,'externalDoor',2,1),(17,'internalDoor',1,1),(18,'window',1,1),(19,'externalDoor',1,1),(20,'internalDoor',1,1),(21,'window',1,1),(22,'externalDoor',1,1),(23,'internalDoor',1,1),(24,'window',1,1),(25,'externalDoor',1,1),(26,'internalDoor',1,1),(27,'window',1,1),(28,'externalDoor',1,1),(29,'internalDoor',1,1),(30,'window',1,1),(31,'externalDoor',1,1),(32,'internalDoor',1,1),(33,'window',1,1),(34,'externalDoor',1,1),(35,'internalDoor',1,1),(36,'window',1,1),(37,'externalDoor',1,1),(38,'internalDoor',1,1),(39,'window',1,1),(40,'externalDoor',1,1),(41,'internalDoor',1,1),(42,'window',1,1),(43,'externalDoor',1,1),(44,'internalDoor',1,1),(45,'window',1,1),(46,'externalDoor',1,1),(47,'internalDoor',1,1),(48,'window',1,1),(49,'externalDoor',1,1),(50,'internalDoor',1,1),(51,'window',1,1),(52,'externalDoor',1,1),(53,'internalDoor',1,1),(54,'window',1,1),(55,'externalDoor',1,1),(56,'internalDoor',1,1),(57,'window',1,1),(58,'externalDoor',1,1),(59,'internalDoor',1,1),(60,'window',1,1),(61,'externalDoor',1,1),(62,'internalDoor',1,1),(63,'window',1,1),(64,'externalDoor',1,1),(65,'internalDoor',1,1),(66,'window',1,1),(67,'externalDoor',1,1),(68,'internalDoor',1,1),(69,'window',1,1),(70,'externalDoor',1,1),(71,'internalDoor',1,1),(72,'window',1,1),(73,'externalDoor',1,1),(74,'internalDoor',1,1),(75,'window',1,1),(76,'externalDoor',1,1),(77,'internalDoor',1,1),(78,'window',1,1),(79,'externalDoor',1,1),(80,'internalDoor',1,1),(81,'window',1,1),(82,'externalDoor',1,1),(83,'internalDoor',1,1),(84,'window',1,1),(85,'externalDoor',1,1),(86,'internalDoor',1,1),(87,'window',1,1),(88,'externalDoor',1,1),(89,'internalDoor',1,1),(90,'window',1,1),(91,'externalDoor',1,1),(92,'internalDoor',1,1),(93,'window',1,1),(94,'externalDoor',1,1),(95,'internalDoor',1,1),(264,'window',1.5,1.5),(265,'externalDoor',1,2.1),(266,'internalDoor',0.8,2),(267,'window',1,1),(268,'externalDoor',2,2),(269,'internalDoor',3,3),(270,'window',1.5,1.5),(271,'externalDoor',1,2.1),(272,'internalDoor',0.8,2),(273,'window',1,1),(274,'externalDoor',2,2),(275,'internalDoor',3,3),(278,'window',1,2),(281,'window',1.5,1.5),(282,'externalDoor',1,2.1),(283,'internalDoor',0.8,2),(284,'window',1,1),(285,'externalDoor',2,2),(286,'internalDoor',3,3);
/*!40000 ALTER TABLE `openings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `openings_in_a_structural_element_frame`
--

DROP TABLE IF EXISTS `openings_in_a_structural_element_frame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `openings_in_a_structural_element_frame` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structural_element_frame_id` bigint NOT NULL,
  `openings_id` bigint NOT NULL,
  `amount` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openings_in_a_structural_element_frame`
--

LOCK TABLES `openings_in_a_structural_element_frame` WRITE;
/*!40000 ALTER TABLE `openings_in_a_structural_element_frame` DISABLE KEYS */;
INSERT INTO `openings_in_a_structural_element_frame` VALUES (1,5,3,1),(2,5,4,3),(3,5,5,1),(4,6,6,3),(5,6,7,2),(6,6,8,3),(7,7,9,3),(8,7,10,1),(9,7,11,1),(10,8,12,3),(11,8,13,1),(12,8,14,1),(13,9,15,3),(14,9,16,1),(15,9,17,1),(16,12,18,1),(17,12,19,1),(18,12,20,1),(19,13,21,1),(20,13,22,1),(21,13,23,1),(22,14,24,1),(23,14,25,1),(24,14,26,1),(25,15,27,1),(26,15,28,1),(27,15,29,1),(28,16,30,1),(29,16,31,1),(30,16,32,1),(31,17,33,1),(32,17,34,1),(33,17,35,1),(34,18,36,1),(35,18,37,1),(36,18,38,1),(37,19,39,1),(38,19,40,1),(39,19,41,1),(40,20,42,1),(41,20,43,1),(42,20,44,1),(43,21,45,1),(44,21,46,1),(45,21,47,1),(46,22,48,1),(47,22,49,1),(48,22,50,1),(49,23,51,1),(50,23,52,1),(51,23,53,1),(52,24,54,1),(53,24,55,1),(54,24,56,1),(55,25,57,1),(56,25,58,1),(57,25,59,1),(58,26,60,1),(59,26,61,1),(60,26,62,1),(61,27,63,1),(62,27,64,1),(63,27,65,1),(64,28,66,1),(65,28,67,1),(66,28,68,1),(67,29,69,1),(68,29,70,1),(69,29,71,1),(70,30,72,1),(71,30,73,1),(72,30,74,1),(73,31,75,1),(74,31,76,1),(75,31,77,1),(76,32,78,1),(77,32,79,1),(78,32,80,1),(79,33,81,1),(80,33,82,1),(81,33,83,1),(82,34,84,1),(83,34,85,1),(84,34,86,1),(85,35,87,1),(86,35,88,1),(87,35,89,1),(88,38,90,1),(89,38,91,1),(90,38,92,1),(91,39,93,1),(92,39,94,1),(93,39,95,1),(262,111,264,5),(263,111,265,1),(264,111,266,5),(265,112,267,1),(266,112,268,2),(267,112,269,3),(268,113,270,5),(269,113,271,1),(270,113,272,5),(271,114,273,1),(272,114,274,2),(273,114,275,3),(274,118,278,3),(276,121,281,5),(277,121,282,1),(278,121,283,5),(279,122,284,1),(280,122,285,2),(281,122,286,3);
/*!40000 ALTER TABLE `openings_in_a_structural_element_frame` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_lists`
--

DROP TABLE IF EXISTS `price_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_lists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `material_characteristics_id` int NOT NULL,
  `date` date NOT NULL,
  `purchase_price` float NOT NULL,
  `selling_price` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `material_characteristics_id_UNIQUE` (`material_characteristics_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_lists`
--

LOCK TABLES `price_lists` WRITE;
/*!40000 ALTER TABLE `price_lists` DISABLE KEYS */;
INSERT INTO `price_lists` VALUES (1,1,'2025-03-27',12000,12000),(2,2,'2025-03-27',12000,12000),(3,3,'2025-03-27',12000,12000),(4,4,'2025-03-27',12000,12000),(5,5,'2025-03-27',12000,12000),(6,6,'2025-03-27',12000,12000),(7,7,'2025-03-27',12000,12000),(8,8,'2025-03-27',12000,12000),(9,9,'2025-03-27',12000,12000),(10,10,'2025-03-27',12000,12000),(11,11,'2025-03-27',256,256),(12,12,'2025-03-27',288,288),(13,13,'2025-03-27',384,384),(14,14,'2025-03-27',480,480),(15,15,'2025-03-27',3000,3000),(16,16,'2025-03-27',3500,3500),(17,17,'2025-03-27',2800,2800),(18,18,'2025-03-27',2800,2800),(19,19,'2025-03-27',2800,2800),(20,20,'2025-03-27',3200,3200),(21,21,'2025-03-27',2800,2800),(22,22,'2025-03-27',33,33),(23,23,'2025-03-27',20,20),(24,24,'2025-03-27',21,21),(25,25,'2025-03-27',11,11),(26,26,'2025-03-27',57,57),(27,27,'2025-03-27',21,21),(28,28,'2025-03-27',53,53);
/*!40000 ALTER TABLE `price_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `material_characteristics_id` bigint NOT NULL,
  `material` varchar(200) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `price` float DEFAULT NULL,
  `measurement_unit_id` int DEFAULT NULL,
  `full_price` float DEFAULT NULL,
  `structural_element_frame_id` int NOT NULL,
  `structural_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=829 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES (1,1,'Доска 50*100*3000',0,16800,3,6888,18,'internalWall'),(2,6,'Доска 50*100*3000',0,16800,3,6888,18,'internalWall'),(4,3,'Доска 50*200*6000',2,16800,3,40320,18,'overlaps'),(5,8,'Доска 50*200*6000',2,16800,3,40320,18,'overlaps'),(7,1,'Доска 50*100*3000',0.41,16800,3,6888,19,'internalWall'),(8,6,'Доска 50*100*3000',0.41,16800,3,6888,19,'internalWall'),(10,3,'Доска 50*200*6000',2.4,16800,3,40320,19,'overlaps'),(11,8,'Доска 50*200*6000',2.4,16800,3,40320,19,'overlaps'),(13,1,'Доска 50*100*3000',0.41,16800,3,6888,20,'internalWall'),(14,6,'Доска 50*100*3000',0.41,16800,3,6888,20,'internalWall'),(16,3,'Доска 50*200*6000',2.4,16800,3,40320,20,'overlaps'),(17,8,'Доска 50*200*6000',2.4,16800,3,40320,20,'overlaps'),(19,1,'Доска 50*100*3000',0.41,16800,3,6888,21,'internalWall'),(20,6,'Доска 50*100*3000',0.41,16800,3,6888,21,'internalWall'),(22,3,'Доска 50*200*6000',2.4,16800,3,40320,21,'overlaps'),(23,8,'Доска 50*200*6000',2.4,16800,3,40320,21,'overlaps'),(25,1,'Доска 50*100*3000',0.41,16800,3,6888,22,'internalWall'),(26,6,'Доска 50*100*3000',0.41,16800,3,6888,22,'internalWall'),(28,3,'Доска 50*200*6000',2.4,16800,3,40320,22,'overlaps'),(29,8,'Доска 50*200*6000',2.4,16800,3,40320,22,'overlaps'),(31,1,'Доска 50*100*3000',0.41,16800,3,6888,23,'internalWall'),(32,6,'Доска 50*100*3000',0.41,16800,3,6888,23,'internalWall'),(34,3,'Доска 50*200*6000',2.4,16800,3,40320,23,'overlaps'),(35,8,'Доска 50*200*6000',2.4,16800,3,40320,23,'overlaps'),(40,1,'Доска 50*100*3000',0.41,16800,3,6888,24,'internalWall'),(41,6,'Доска 50*100*3000',0.41,16800,3,6888,24,'internalWall'),(43,3,'Доска 50*200*6000',2.4,16800,3,40320,24,'overlaps'),(44,8,'Доска 50*200*6000',2.4,16800,3,40320,24,'overlaps'),(49,1,'Доска 50*100*3000',0.41,16800,3,6888,25,'internalWall'),(50,6,'Доска 50*100*3000',0.41,16800,3,6888,25,'internalWall'),(52,3,'Доска 50*200*6000',2.4,16800,3,40320,25,'overlaps'),(53,8,'Доска 50*200*6000',2.4,16800,3,40320,25,'overlaps'),(82,1,'Доска 50*100*3000',1.11,16800,3,18648,29,'externalWall'),(83,6,'Доска 50*100*3000',1.11,16800,3,18648,29,'externalWall'),(85,1,'Доска 50*100*3000',0.41,16800,3,6888,29,'internalWall'),(86,6,'Доска 50*100*3000',0.41,16800,3,6888,29,'internalWall'),(88,3,'Доска 50*200*6000',2.4,16800,3,40320,29,'overlaps'),(89,8,'Доска 50*200*6000',2.4,16800,3,40320,29,'overlaps'),(91,1,'Доска 50*100*3000',1.11,16800,3,18648,30,'externalWall'),(92,6,'Доска 50*100*3000',1.11,16800,3,18648,30,'externalWall'),(94,1,'Доска 50*100*3000',0.41,16800,3,6888,30,'internalWall'),(95,6,'Доска 50*100*3000',0.41,16800,3,6888,30,'internalWall'),(97,3,'Доска 50*200*6000',2.4,16800,3,40320,30,'overlaps'),(98,8,'Доска 50*200*6000',2.4,16800,3,40320,30,'overlaps'),(100,1,'Доска 50*100*3000',1.11,16800,3,18648,33,'externalWall'),(101,6,'Доска 50*100*3000',1.11,16800,3,18648,33,'externalWall'),(103,15,'Кнауф ТеплоКнауф 100 мм',9.7,4200,3,40740,33,'externalWall'),(104,11,'OSB 9 мм',207,358.4,3,74188.8,33,'externalWall'),(105,22,'Ондутис',103.5,46.2,3,4781.7,33,'externalWall'),(106,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,33,'externalWall'),(107,1,'Доска 50*100*3000',0.41,16800,3,6888,33,'internalWall'),(108,6,'Доска 50*100*3000',0.41,16800,3,6888,33,'internalWall'),(110,11,'OSB 9 мм',103.5,358.4,3,37094.4,33,'internalWall'),(111,3,'Доска 50*200*6000',2.4,16800,3,40320,33,'overlaps'),(112,8,'Доска 50*200*6000',2.4,16800,3,40320,33,'overlaps'),(114,19,'Эковер 200 мм',24.64,3920,3,96588.8,33,'overlaps'),(115,11,'OSB 9 мм',257.6,358.4,3,92323.8,33,'overlaps'),(116,22,'Ондутис',64.4,46.2,3,2975.28,33,'overlaps'),(117,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,33,'overlaps'),(118,1,'Доска 50*100*3000',1.11,16800,3,18648,34,'externalWall'),(119,15,'Кнауф ТеплоКнауф 100 мм',9.7,4200,3,40740,34,'externalWall'),(120,11,'OSB 9 мм',207,358.4,3,74188.8,34,'externalWall'),(121,22,'Ондутис',103.5,46.2,3,4781.7,34,'externalWall'),(122,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,34,'externalWall'),(123,1,'Доска 50*100*3000',0.41,16800,3,6888,34,'internalWall'),(124,11,'OSB 9 мм',103.5,358.4,3,37094.4,34,'internalWall'),(125,8,'Доска 50*200*6000',2.4,16800,3,40320,34,'overlaps'),(126,19,'Эковер 200 мм',24.64,3920,3,96588.8,34,'overlaps'),(127,11,'OSB 9 мм',257.6,358.4,3,92323.8,34,'overlaps'),(128,22,'Ондутис',64.4,46.2,3,2975.28,34,'overlaps'),(129,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,34,'overlaps'),(130,1,'Доска 50*100*3000',1.11,16800,3,18648,35,'externalWall'),(131,15,'Кнауф ТеплоКнауф 100 мм',9.7,4200,3,40740,35,'externalWall'),(132,11,'OSB 9 мм',207,358.4,3,74188.8,35,'externalWall'),(133,22,'Ондутис',103.5,46.2,3,4781.7,35,'externalWall'),(134,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,35,'externalWall'),(135,1,'Доска 50*100*3000',0.41,16800,3,6888,35,'internalWall'),(136,11,'OSB 9 мм',103.5,358.4,3,37094.4,35,'internalWall'),(137,8,'Доска 50*200*6000',2.4,16800,3,40320,35,'overlaps'),(138,19,'Эковер 200 мм',24.64,3920,3,96588.8,35,'overlaps'),(139,11,'OSB 9 мм',257.6,358.4,3,92323.8,35,'overlaps'),(140,22,'Ондутис',64.4,46.2,3,2975.28,35,'overlaps'),(141,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,35,'overlaps'),(150,3,'Доска 50*200*3000',2.13,16800,3,35784,36,'externalWall'),(151,19,'Эковер 200 мм',19.8,3920,3,77616,36,'externalWall'),(152,11,'OSB 9 мм',207,358.4,3,74188.8,36,'externalWall'),(153,22,'Ондутис',103.5,46.2,3,4781.7,36,'externalWall'),(154,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,36,'externalWall'),(155,1,'Доска 50*100*3000',0.38,16800,3,6384,36,'internalWall'),(156,11,'OSB 9 мм',103.5,358.4,3,37094.4,36,'internalWall'),(157,9,'Доска 50*250*6000',3,16800,3,50400,36,'overlaps'),(158,21,'Эковер 250 мм',30.8,3920,3,120736,36,'overlaps'),(159,11,'OSB 9 мм',257.6,358.4,3,92323.8,36,'overlaps'),(160,22,'Ондутис',64.4,46.2,3,2975.28,36,'overlaps'),(161,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,36,'overlaps'),(162,1,'Доска 50*100*3000',1.06,16800,3,17808,37,'externalWall'),(163,15,'Кнауф ТеплоКнауф 100 мм',9.9,4200,3,41580,37,'externalWall'),(164,11,'OSB 9 мм',207,358.4,3,74188.8,37,'externalWall'),(165,22,'Ондутис',103.5,46.2,3,4781.7,37,'externalWall'),(166,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,37,'externalWall'),(167,1,'Доска 50*100*3000',0.38,16800,3,6384,37,'internalWall'),(168,11,'OSB 9 мм',103.5,358.4,3,37094.4,37,'internalWall'),(169,8,'Доска 50*200*6000',2.4,16800,3,40320,37,'overlaps'),(170,19,'Эковер 200 мм',12.32,3920,3,48294.4,37,'overlaps'),(171,11,'OSB 9 мм',128.8,358.4,3,46161.9,37,'overlaps'),(172,22,'Ондутис',64.4,46.2,3,2975.28,37,'overlaps'),(173,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,37,'overlaps'),(174,1,'Доска 50*100*3000',1.11,16800,3,18648,39,'externalWall'),(175,15,'Кнауф ТеплоКнауф 100 мм',3.1,4200,3,13020,39,'externalWall'),(176,11,'OSB 9 мм',69,358.4,3,24729.6,39,'externalWall'),(177,22,'Ондутис',34.5,46.2,3,1593.9,39,'externalWall'),(178,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,39,'externalWall'),(179,1,'Доска 50*100*3000',0.41,16800,3,6888,39,'internalWall'),(180,11,'OSB 9 мм',34.5,358.4,3,12364.8,39,'internalWall'),(181,8,'Доска 50*200*6000',2.4,16800,3,40320,39,'overlaps'),(182,19,'Эковер 200 мм',24.64,3920,3,96588.8,39,'overlaps'),(183,11,'OSB 9 мм',257.6,358.4,3,92323.8,39,'overlaps'),(184,22,'Ондутис',64.4,46.2,3,2975.28,39,'overlaps'),(185,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,39,'overlaps'),(187,1,'Доска 50*100*3000',1.06,16800,3,17808,41,'externalWall'),(188,15,'Кнауф ТеплоКнауф 100 мм',3.3,4200,3,13860,41,'externalWall'),(189,11,'OSB 9 мм',69,358.4,3,24729.6,41,'externalWall'),(190,22,'Ондутис',34.5,46.2,3,1593.9,41,'externalWall'),(191,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,41,'externalWall'),(192,1,'Доска 50*100*3000',0.38,16800,3,6384,41,'internalWall'),(193,8,'Доска 50*200*6000',2.4,16800,3,40320,41,'overlaps'),(194,19,'Эковер 200 мм',24.64,3920,3,96588.8,41,'overlaps'),(195,11,'OSB 9 мм',257.6,358.4,3,92323.8,41,'overlaps'),(196,22,'Ондутис',64.4,46.2,3,2975.28,41,'overlaps'),(197,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,41,'overlaps'),(200,1,'Доска 50*100*3000',1.06,16800,3,17808,43,'externalWall'),(201,1,'Доска 50*100*3000',0.38,16800,3,6384,43,'internalWall'),(208,3,'Доска 50*200*3000',2.37,16800,3,39816,45,'externalWall'),(209,19,'Эковер 200 мм',5,3920,3,19600,45,'externalWall'),(210,12,'OSB 10 мм',69,403.2,3,27820.8,45,'externalWall'),(211,22,'Ондутис',34.5,46.2,3,1593.9,45,'externalWall'),(212,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,45,'externalWall'),(213,1,'Доска 50*100*3000',0.53,16800,3,8904,45,'internalWall'),(214,11,'OSB 9 мм',34.5,358.4,3,12364.8,45,'internalWall'),(215,8,'Доска 50*200*6000',2.4,16800,3,40320,45,'overlaps'),(216,19,'Эковер 200 мм',24.64,3920,3,96588.8,45,'overlaps'),(217,11,'OSB 9 мм',257.6,358.4,3,92323.8,45,'overlaps'),(218,22,'Ондутис',64.4,46.2,3,2975.28,45,'overlaps'),(219,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,45,'overlaps'),(220,1,'Доска 50*100*3000',1.17,16800,3,19656,46,'externalWall'),(221,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,46,'externalWall'),(222,11,'OSB 9 мм',69,358.4,3,24729.6,46,'externalWall'),(223,22,'Ондутис',34.5,46.2,3,1593.9,46,'externalWall'),(224,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,46,'externalWall'),(225,1,'Доска 50*100*3000',0.56,16800,3,9408,46,'internalWall'),(226,11,'OSB 9 мм',34.5,358.4,3,12364.8,46,'internalWall'),(227,8,'Доска 50*200*6000',2.4,16800,3,40320,46,'overlaps'),(228,19,'Эковер 200 мм',12.32,3920,3,48294.4,46,'overlaps'),(229,11,'OSB 9 мм',128.8,358.4,3,46161.9,46,'overlaps'),(230,22,'Ондутис',64.4,46.2,3,2975.28,46,'overlaps'),(231,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,46,'overlaps'),(234,3,'Доска 50*200*3000',2.37,16800,3,39816,51,'externalWall'),(235,19,'Эковер 200 мм',5,3920,3,19600,51,'externalWall'),(236,12,'OSB 10 мм',69,403.2,3,27820.8,51,'externalWall'),(237,22,'Ондутис',34.5,46.2,3,1593.9,51,'externalWall'),(238,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,51,'externalWall'),(239,1,'Доска 50*100*3000',0.53,16800,3,8904,51,'internalWall'),(240,11,'OSB 9 мм',34.5,358.4,3,12364.8,51,'internalWall'),(241,8,'Доска 50*200*6000',2.4,16800,3,40320,51,'overlaps'),(242,19,'Эковер 200 мм',24.64,3920,3,96588.8,51,'overlaps'),(243,11,'OSB 9 мм',257.6,358.4,3,92323.8,51,'overlaps'),(244,22,'Ондутис',64.4,46.2,3,2975.28,51,'overlaps'),(245,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,51,'overlaps'),(246,1,'Доска 50*100*3000',1.17,16800,3,19656,52,'externalWall'),(247,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,52,'externalWall'),(248,11,'OSB 9 мм',69,358.4,3,24729.6,52,'externalWall'),(249,22,'Ондутис',34.5,46.2,3,1593.9,52,'externalWall'),(250,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,52,'externalWall'),(251,1,'Доска 50*100*3000',0.56,16800,3,9408,52,'internalWall'),(252,11,'OSB 9 мм',34.5,358.4,3,12364.8,52,'internalWall'),(253,8,'Доска 50*200*6000',2.4,16800,3,40320,52,'overlaps'),(254,19,'Эковер 200 мм',12.32,3920,3,48294.4,52,'overlaps'),(255,11,'OSB 9 мм',128.8,358.4,3,46161.9,52,'overlaps'),(256,22,'Ондутис',64.4,46.2,3,2975.28,52,'overlaps'),(257,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,52,'overlaps'),(258,3,'Доска 50*200*3000',2.37,16800,3,39816,53,'externalWall'),(259,19,'Эковер 200 мм',5,3920,3,19600,53,'externalWall'),(260,12,'OSB 10 мм',69,403.2,3,27820.8,53,'externalWall'),(261,22,'Ондутис',34.5,46.2,3,1593.9,53,'externalWall'),(262,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,53,'externalWall'),(263,1,'Доска 50*100*3000',0.53,16800,3,8904,53,'internalWall'),(264,11,'OSB 9 мм',34.5,358.4,3,12364.8,53,'internalWall'),(265,8,'Доска 50*200*6000',2.4,16800,3,40320,53,'overlaps'),(266,19,'Эковер 200 мм',24.64,3920,3,96588.8,53,'overlaps'),(267,11,'OSB 9 мм',257.6,358.4,3,92323.8,53,'overlaps'),(268,22,'Ондутис',64.4,46.2,3,2975.28,53,'overlaps'),(269,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,53,'overlaps'),(270,1,'Доска 50*100*3000',1.17,16800,3,19656,54,'externalWall'),(271,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,54,'externalWall'),(272,11,'OSB 9 мм',69,358.4,3,24729.6,54,'externalWall'),(273,22,'Ондутис',34.5,46.2,3,1593.9,54,'externalWall'),(274,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,54,'externalWall'),(275,1,'Доска 50*100*3000',0.56,16800,3,9408,54,'internalWall'),(276,11,'OSB 9 мм',34.5,358.4,3,12364.8,54,'internalWall'),(277,8,'Доска 50*200*6000',2.4,16800,3,40320,54,'overlaps'),(278,19,'Эковер 200 мм',12.32,3920,3,48294.4,54,'overlaps'),(279,11,'OSB 9 мм',128.8,358.4,3,46161.9,54,'overlaps'),(280,22,'Ондутис',64.4,46.2,3,2975.28,54,'overlaps'),(281,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,54,'overlaps'),(282,3,'Доска 50*200*3000',2.37,16800,3,39816,55,'externalWall'),(283,19,'Эковер 200 мм',5,3920,3,19600,55,'externalWall'),(284,12,'OSB 10 мм',69,403.2,3,27820.8,55,'externalWall'),(285,22,'Ондутис',34.5,46.2,3,1593.9,55,'externalWall'),(286,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,55,'externalWall'),(287,1,'Доска 50*100*3000',0.53,16800,3,8904,55,'internalWall'),(288,11,'OSB 9 мм',34.5,358.4,3,12364.8,55,'internalWall'),(289,8,'Доска 50*200*6000',2.4,16800,3,40320,55,'overlaps'),(290,19,'Эковер 200 мм',24.64,3920,3,96588.8,55,'overlaps'),(291,11,'OSB 9 мм',257.6,358.4,3,92323.8,55,'overlaps'),(292,22,'Ондутис',64.4,46.2,3,2975.28,55,'overlaps'),(293,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,55,'overlaps'),(294,1,'Доска 50*100*3000',1.17,16800,3,19656,56,'externalWall'),(295,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,56,'externalWall'),(296,11,'OSB 9 мм',69,358.4,3,24729.6,56,'externalWall'),(297,22,'Ондутис',34.5,46.2,3,1593.9,56,'externalWall'),(298,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,56,'externalWall'),(299,1,'Доска 50*100*3000',0.56,16800,3,9408,56,'internalWall'),(300,11,'OSB 9 мм',34.5,358.4,3,12364.8,56,'internalWall'),(301,8,'Доска 50*200*6000',2.4,16800,3,40320,56,'overlaps'),(302,19,'Эковер 200 мм',12.32,3920,3,48294.4,56,'overlaps'),(303,11,'OSB 9 мм',128.8,358.4,3,46161.9,56,'overlaps'),(304,22,'Ондутис',64.4,46.2,3,2975.28,56,'overlaps'),(305,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,56,'overlaps'),(306,3,'Доска 50*200*3000',2.37,16800,3,39816,57,'externalWall'),(307,19,'Эковер 200 мм',5,3920,3,19600,57,'externalWall'),(308,12,'OSB 10 мм',69,403.2,3,27820.8,57,'externalWall'),(309,22,'Ондутис',34.5,46.2,3,1593.9,57,'externalWall'),(310,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,57,'externalWall'),(311,1,'Доска 50*100*3000',0.53,16800,3,8904,57,'internalWall'),(312,11,'OSB 9 мм',34.5,358.4,3,12364.8,57,'internalWall'),(313,8,'Доска 50*200*6000',2.4,16800,3,40320,57,'overlaps'),(314,19,'Эковер 200 мм',24.64,3920,3,96588.8,57,'overlaps'),(315,11,'OSB 9 мм',257.6,358.4,3,92323.8,57,'overlaps'),(316,22,'Ондутис',64.4,46.2,3,2975.28,57,'overlaps'),(317,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,57,'overlaps'),(318,1,'Доска 50*100*3000',1.17,16800,3,19656,58,'externalWall'),(319,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,58,'externalWall'),(320,11,'OSB 9 мм',69,358.4,3,24729.6,58,'externalWall'),(321,22,'Ондутис',34.5,46.2,3,1593.9,58,'externalWall'),(322,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,58,'externalWall'),(323,1,'Доска 50*100*3000',0.56,16800,3,9408,58,'internalWall'),(324,11,'OSB 9 мм',34.5,358.4,3,12364.8,58,'internalWall'),(325,8,'Доска 50*200*6000',2.4,16800,3,40320,58,'overlaps'),(326,19,'Эковер 200 мм',12.32,3920,3,48294.4,58,'overlaps'),(327,11,'OSB 9 мм',128.8,358.4,3,46161.9,58,'overlaps'),(328,22,'Ондутис',64.4,46.2,3,2975.28,58,'overlaps'),(329,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,58,'overlaps'),(330,3,'Доска 50*200*3000',2.37,16800,3,39816,59,'externalWall'),(331,19,'Эковер 200 мм',5,3920,3,19600,59,'externalWall'),(332,12,'OSB 10 мм',69,403.2,3,27820.8,59,'externalWall'),(333,22,'Ондутис',34.5,46.2,3,1593.9,59,'externalWall'),(334,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,59,'externalWall'),(335,1,'Доска 50*100*3000',0.53,16800,3,8904,59,'internalWall'),(336,11,'OSB 9 мм',34.5,358.4,3,12364.8,59,'internalWall'),(337,8,'Доска 50*200*6000',2.4,16800,3,40320,59,'overlaps'),(338,19,'Эковер 200 мм',24.64,3920,3,96588.8,59,'overlaps'),(339,11,'OSB 9 мм',257.6,358.4,3,92323.8,59,'overlaps'),(340,22,'Ондутис',64.4,46.2,3,2975.28,59,'overlaps'),(341,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,59,'overlaps'),(342,1,'Доска 50*100*3000',1.17,16800,3,19656,60,'externalWall'),(343,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,60,'externalWall'),(344,11,'OSB 9 мм',69,358.4,3,24729.6,60,'externalWall'),(345,22,'Ондутис',34.5,46.2,3,1593.9,60,'externalWall'),(346,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,60,'externalWall'),(347,1,'Доска 50*100*3000',0.56,16800,3,9408,60,'internalWall'),(348,11,'OSB 9 мм',34.5,358.4,3,12364.8,60,'internalWall'),(349,8,'Доска 50*200*6000',2.4,16800,3,40320,60,'overlaps'),(350,19,'Эковер 200 мм',12.32,3920,3,48294.4,60,'overlaps'),(351,11,'OSB 9 мм',128.8,358.4,3,46161.9,60,'overlaps'),(352,22,'Ондутис',64.4,46.2,3,2975.28,60,'overlaps'),(353,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,60,'overlaps'),(378,3,'Доска 50*200*3000',2.58,16800,3,43344,63,'externalWall'),(379,19,'Эковер 200 мм',5.66,3920,3,22187.2,63,'externalWall'),(380,12,'OSB 10 мм',75.9,403.2,3,30602.9,63,'externalWall'),(381,22,'Ондутис',37.95,46.2,3,1753.29,63,'externalWall'),(382,26,'Ветро-влагозащитная мембрана Brane А',37.95,79.8,3,3028.41,63,'externalWall'),(383,1,'Доска 50*100*3000',0.53,16800,3,8904,63,'internalWall'),(384,11,'OSB 9 мм',34.5,358.4,3,12364.8,63,'internalWall'),(385,8,'Доска 50*200*6000',2.4,16800,3,40320,63,'overlaps'),(386,19,'Эковер 200 мм',24.64,3920,3,96588.8,63,'overlaps'),(387,11,'OSB 9 мм',257.6,358.4,3,92323.8,63,'overlaps'),(388,22,'Ондутис',64.4,46.2,3,2975.28,63,'overlaps'),(389,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,63,'overlaps'),(390,1,'Доска 50*100*3000',1.17,16800,3,19656,64,'externalWall'),(391,15,'Кнауф ТеплоКнауф 100 мм',2.4,4200,3,10080,64,'externalWall'),(392,11,'OSB 9 мм',69,358.4,3,24729.6,64,'externalWall'),(393,22,'Ондутис',34.5,46.2,3,1593.9,64,'externalWall'),(394,26,'Ветро-влагозащитная мембрана Brane А',34.5,79.8,3,2753.1,64,'externalWall'),(395,1,'Доска 50*100*3000',0.56,16800,3,9408,64,'internalWall'),(396,11,'OSB 9 мм',34.5,358.4,3,12364.8,64,'internalWall'),(397,8,'Доска 50*200*6000',2.4,16800,3,40320,64,'overlaps'),(398,19,'Эковер 200 мм',12.32,3920,3,48294.4,64,'overlaps'),(399,11,'OSB 9 мм',128.8,358.4,3,46161.9,64,'overlaps'),(400,22,'Ондутис',64.4,46.2,3,2975.28,64,'overlaps'),(401,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,64,'overlaps'),(711,1,'Доска 50*100*3000',1.06,12000,3,12720,99,'externalWall'),(712,1,'Доска 50*100*3000',0.38,12000,3,4560,99,'internalWall'),(739,3,'Доска 50*200*3000',2.52,12000,3,30240,111,'externalWall'),(740,19,'Эковер 200 мм',17.13,2800,2,47964,111,'externalWall'),(741,12,'OSB 10 мм',207,288,2,59616,111,'externalWall'),(742,22,'Ондутис',103.5,33,2,3415.5,111,'externalWall'),(743,26,'Ветро-влагозащитная мембрана Brane А',103.5,57,2,5899.5,111,'externalWall'),(744,1,'Доска 50*100*3000',0.53,12000,3,6360,111,'internalWall'),(745,12,'OSB 10 мм',103.5,288,2,29808,111,'internalWall'),(746,8,'Доска 50*200*6000',2.4,12000,3,28800,111,'overlaps'),(747,19,'Эковер 200 мм',24.64,2800,2,68992,111,'overlaps'),(748,12,'OSB 10 мм',257.6,288,2,74188.8,111,'overlaps'),(749,22,'Ондутис',64.4,33,2,2125.2,111,'overlaps'),(750,26,'Ветро-влагозащитная мембрана Brane А',64.4,57,2,3670.8,111,'overlaps'),(751,1,'Доска 50*100*3000',1.17,12000,3,14040,112,'externalWall'),(752,15,'Кнауф ТеплоКнауф 100 мм',9,3000,2,27000,112,'externalWall'),(753,11,'OSB 9 мм',207,256,2,52992,112,'externalWall'),(754,22,'Ондутис',103.5,33,2,3415.5,112,'externalWall'),(755,26,'Ветро-влагозащитная мембрана Brane А',103.5,57,2,5899.5,112,'externalWall'),(756,1,'Доска 50*100*3000',0.56,12000,3,6720,112,'internalWall'),(757,11,'OSB 9 мм',103.5,256,2,26496,112,'internalWall'),(758,8,'Доска 50*200*6000',2.4,12000,3,28800,112,'overlaps'),(759,19,'Эковер 200 мм',12.32,2800,2,34496,112,'overlaps'),(760,11,'OSB 9 мм',128.8,256,2,32972.8,112,'overlaps'),(761,22,'Ондутис',64.4,33,2,2125.2,112,'overlaps'),(762,26,'Ветро-влагозащитная мембрана Brane А',64.4,57,2,3670.8,112,'overlaps'),(763,3,'Доска 50*200*3000',2.52,12000,3,30240,113,'externalWall'),(764,19,'Эковер 200 мм',17.13,2800,2,47964,113,'externalWall'),(765,12,'OSB 10 мм',207,288,2,59616,113,'externalWall'),(766,22,'Ондутис',103.5,33,2,3415.5,113,'externalWall'),(767,26,'Ветро-влагозащитная мембрана Brane А',103.5,57,2,5899.5,113,'externalWall'),(768,1,'Доска 50*100*3000',0.53,12000,3,6360,113,'internalWall'),(769,12,'OSB 10 мм',103.5,288,2,29808,113,'internalWall'),(770,8,'Доска 50*200*6000',2.4,12000,3,28800,113,'overlaps'),(771,19,'Эковер 200 мм',24.64,2800,2,68992,113,'overlaps'),(772,12,'OSB 10 мм',257.6,288,2,74188.8,113,'overlaps'),(773,22,'Ондутис',64.4,33,2,2125.2,113,'overlaps'),(774,26,'Ветро-влагозащитная мембрана Brane А',64.4,57,2,3670.8,113,'overlaps'),(775,1,'Доска 50*100*3000',1.17,12000,3,14040,114,'externalWall'),(776,15,'Кнауф ТеплоКнауф 100 мм',9,3000,2,27000,114,'externalWall'),(777,11,'OSB 9 мм',207,256,2,52992,114,'externalWall'),(778,22,'Ондутис',103.5,33,2,3415.5,114,'externalWall'),(779,26,'Ветро-влагозащитная мембрана Brane А',103.5,57,2,5899.5,114,'externalWall'),(780,1,'Доска 50*100*3000',0.56,12000,3,6720,114,'internalWall'),(781,11,'OSB 9 мм',103.5,256,2,26496,114,'internalWall'),(782,8,'Доска 50*200*6000',2.4,12000,3,28800,114,'overlaps'),(783,19,'Эковер 200 мм',12.32,2800,2,34496,114,'overlaps'),(784,11,'OSB 9 мм',128.8,256,2,32972.8,114,'overlaps'),(785,22,'Ондутис',64.4,33,2,2125.2,114,'overlaps'),(786,26,'Ветро-влагозащитная мембрана Brane А',64.4,57,2,3670.8,114,'overlaps'),(793,3,'Доска 50*200*3000',0.42,12000,3,5040,118,'externalWall'),(794,19,'Эковер 200 мм',0.12,2800,2,336,118,'externalWall'),(795,13,'OSB 15 мм',13.8,384,2,5299.2,118,'externalWall'),(796,22,'Ондутис',6.9,33,2,227.7,118,'externalWall'),(797,26,'Ветро-влагозащитная мембрана Brane А',6.9,57,2,393.3,118,'externalWall'),(798,1,'Доска 50*100*3000',0.3,12000,3,3600,118,'internalWall'),(805,3,'Доска 50*200*3000',2.52,12000,3,30240,121,'externalWall'),(806,19,'Эковер 200 мм',17.13,2800,2,47964,121,'externalWall'),(807,12,'OSB 10 мм',207,288,2,59616,121,'externalWall'),(808,22,'Ондутис',103.5,33,2,3415.5,121,'externalWall'),(809,26,'Ветро-влагозащитная мембрана Brane А',103.5,57,2,5899.5,121,'externalWall'),(810,1,'Доска 50*100*3000',0.53,12000,3,6360,121,'internalWall'),(811,12,'OSB 10 мм',103.5,288,2,29808,121,'internalWall'),(812,8,'Доска 50*200*6000',2.4,12000,3,28800,121,'overlaps'),(813,19,'Эковер 200 мм',24.64,2800,2,68992,121,'overlaps'),(814,12,'OSB 10 мм',257.6,288,2,74188.8,121,'overlaps'),(815,22,'Ондутис',64.4,33,2,2125.2,121,'overlaps'),(816,26,'Ветро-влагозащитная мембрана Brane А',64.4,57,2,3670.8,121,'overlaps'),(817,1,'Доска 50*100*3000',1.17,12000,3,14040,122,'externalWall'),(818,15,'Кнауф ТеплоКнауф 100 мм',9,3000,2,27000,122,'externalWall'),(819,11,'OSB 9 мм',207,256,2,52992,122,'externalWall'),(820,22,'Ондутис',103.5,33,2,3415.5,122,'externalWall'),(821,26,'Ветро-влагозащитная мембрана Brane А',103.5,57,2,5899.5,122,'externalWall'),(822,1,'Доска 50*100*3000',0.56,12000,3,6720,122,'internalWall'),(823,11,'OSB 9 мм',103.5,256,2,26496,122,'internalWall'),(824,8,'Доска 50*200*6000',2.4,12000,3,28800,122,'overlaps'),(825,19,'Эковер 200 мм',12.32,2800,2,34496,122,'overlaps'),(826,11,'OSB 9 мм',128.8,256,2,32972.8,122,'overlaps'),(827,22,'Ондутис',64.4,33,2,2125.2,122,'overlaps'),(828,26,'Ветро-влагозащитная мембрана Brane А',64.4,57,2,3670.8,122,'overlaps');
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'Уволен'),(2,'Числится в штате');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structural_element_basement`
--

DROP TABLE IF EXISTS `structural_element_basement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structural_element_basement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `results_id` int NOT NULL,
  `Perimeter_of_external_walls` float NOT NULL,
  `internal_wall_length` float NOT NULL,
  `concrete_piles` varchar(200) NOT NULL,
  `concrete` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structural_element_basement`
--

LOCK TABLES `structural_element_basement` WRITE;
/*!40000 ALTER TABLE `structural_element_basement` DISABLE KEYS */;
/*!40000 ALTER TABLE `structural_element_basement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structural_element_frame`
--

DROP TABLE IF EXISTS `structural_element_frame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structural_element_frame` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount_floor` int NOT NULL,
  `floor_number` int NOT NULL,
  `floor_height` int NOT NULL,
  `perimeter_of_external_walls` float NOT NULL,
  `base_area` float NOT NULL,
  `external_wall_thickness` float NOT NULL,
  `internal_wall_length` float NOT NULL,
  `internal_wall_thickness` float NOT NULL,
  `OSB_external_wall` varchar(200) DEFAULT NULL,
  `steam_waterproofing_external_wall` varchar(200) DEFAULT NULL,
  `windscreen_extern_wall` varchar(200) DEFAULT NULL,
  `insulation_external_wall` varchar(200) DEFAULT NULL,
  `overlap_thickness` varchar(200) DEFAULT NULL,
  `OSB_thickness` varchar(200) DEFAULT NULL,
  `steam_waterproofing_thickness` varchar(200) DEFAULT NULL,
  `windscreen_thickness` varchar(200) DEFAULT NULL,
  `insulation_thickness` varchar(200) DEFAULT NULL,
  `OSB_internal_wall` varchar(200) DEFAULT NULL,
  `calculation_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structural_element_frame`
--

LOCK TABLES `structural_element_frame` WRITE;
/*!40000 ALTER TABLE `structural_element_frame` DISABLE KEYS */;
INSERT INTO `structural_element_frame` VALUES (5,2,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',9),(6,2,2,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',9),(7,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',10),(8,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',11),(9,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',12),(10,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',13),(11,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',14),(12,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',15),(13,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',16),(14,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',17),(15,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',18),(16,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',19),(17,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',20),(18,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',21),(19,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',22),(20,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',23),(21,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',24),(22,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',25),(23,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',26),(24,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',27),(25,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',28),(26,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',29),(27,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',30),(28,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',31),(29,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',32),(30,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',33),(31,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',34),(32,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',35),(33,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',36),(34,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',37),(35,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',38),(36,2,1,3,30,56,200,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','250','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 250 мм','9',39),(37,2,2,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',39),(38,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',42),(39,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',43),(40,1,1,3,30,56,100,15,100,NULL,NULL,NULL,NULL,'200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм',NULL,45),(41,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм',NULL,46),(43,1,1,3,30,56,100,15,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,48),(99,1,1,3,30,56,100,15,100,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,55),(111,2,1,3,30,56,200,15,100,'10','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','200','10','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','10',62),(112,2,2,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',62),(113,2,1,3,30,56,200,15,100,'10','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','200','10','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','10',50),(114,2,2,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',50),(118,1,1,2,3,2,200,12,100,'15','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм',NULL,NULL,NULL,NULL,NULL,NULL,64),(121,2,1,3,30,56,200,15,100,'10','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','200','10','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','10',70),(122,2,2,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',70);
/*!40000 ALTER TABLE `structural_element_frame` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_name` varchar(200) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `second_name` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `e-mail` varchar(200) NOT NULL,
  `password` varchar(300) NOT NULL,
  `login` varchar(300) NOT NULL,
  `state_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Иванов','Иван','Иванович','88005553535','ivanov@test.ru','password','ivanov',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_usersgroup`
--

DROP TABLE IF EXISTS `users_usersgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_usersgroup` (
  `users_id` int NOT NULL,
  `usersgroup_id` int NOT NULL,
  PRIMARY KEY (`users_id`),
  UNIQUE KEY `users_id_UNIQUE` (`users_id`),
  UNIQUE KEY `usersgroup_id_UNIQUE` (`usersgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_usersgroup`
--

LOCK TABLES `users_usersgroup` WRITE;
/*!40000 ALTER TABLE `users_usersgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_usersgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usersgroup`
--

DROP TABLE IF EXISTS `usersgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersgroup` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usersgroup`
--

LOCK TABLES `usersgroup` WRITE;
/*!40000 ALTER TABLE `usersgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `usersgroup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-02 17:21:06
