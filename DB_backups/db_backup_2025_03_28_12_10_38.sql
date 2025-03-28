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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calculation`
--

LOCK TABLES `calculation` WRITE;
/*!40000 ALTER TABLE `calculation` DISABLE KEYS */;
INSERT INTO `calculation` VALUES (1,1,'г.Самара, Московское шоссе, 77А',1,'2025-03-14 19:06:07',1),(2,1,'г. Москва, ул. Ленина, д. 10',2,'2025-03-17 12:05:00',1),(3,1,'г. Москва, ул. Ленина, д. 10',3,'2025-03-17 12:07:56',1),(4,1,'Введите адрес',4,'2025-03-17 12:09:15',1),(5,1,'Введите адрес',5,'2025-03-17 12:11:15',1),(6,1,'Введите адрес',6,'2025-03-17 12:46:01',1),(9,1,'jkb',7,'2025-03-26 11:35:22',1),(10,1,'',8,'2025-03-26 11:57:25',1),(11,1,'',9,'2025-03-26 11:59:18',1),(12,1,'',10,'2025-03-26 12:03:37',1),(13,1,'',11,'2025-03-26 12:23:19',1),(14,1,'',12,'2025-03-26 12:25:06',1),(15,1,'',13,'2025-03-27 18:32:29',1),(16,1,'',14,'2025-03-27 18:41:02',1),(17,1,'',15,'2025-03-27 18:41:42',1),(18,1,'',16,'2025-03-27 18:56:46',1),(19,1,'',17,'2025-03-27 19:00:43',1),(20,1,'',18,'2025-03-27 19:04:37',1),(21,1,'',19,'2025-03-27 19:06:55',1),(22,1,'',20,'2025-03-27 19:09:16',1),(23,1,'',21,'2025-03-27 19:15:41',1),(24,1,'',22,'2025-03-27 19:16:45',1),(25,1,'',23,'2025-03-27 19:18:40',1),(26,1,'',24,'2025-03-27 19:21:20',1),(27,1,'',25,'2025-03-27 19:21:55',1),(28,1,'',26,'2025-03-28 07:59:52',1),(29,1,'',27,'2025-03-28 08:09:09',1),(30,1,'',28,'2025-03-28 08:15:19',1),(31,1,'',29,'2025-03-28 08:15:45',1),(32,1,'',30,'2025-03-28 08:16:38',1),(33,1,'',31,'2025-03-28 08:23:04',1),(34,1,'',32,'2025-03-28 08:25:50',1),(35,1,'',33,'2025-03-28 08:26:26',1),(36,1,'',34,'2025-03-28 08:31:26',1),(37,1,'',35,'2025-03-28 08:38:39',1),(38,1,'',36,'2025-03-28 08:43:07',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Иванов','Иван','Иванович','+79171234567','ivanov@gmail.com','г. Москва, ул. Ленина, д. 10',1),(2,'Сергеев','Сергей','Сергеевич','+79173211234','Sergey@gmail.com','г. Самара, Московское шоссе, д77',1),(3,'Иванова','Анна','Сергеевна','+79376341252','Anna@psuti.ru','г. Самара, Московское шоссе, д.18А',1),(4,'Тестов','Тест','Тестович','89634326532','test@mail.ru','г. Самара, Московское шоссе, д.18А',1);
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
INSERT INTO `material_characteristics` VALUES (1,'Доска',4,1,3000,100,50,0.015),(2,'Доска',4,1,3000,150,50,0.0225),(3,'Доска',4,1,3000,200,50,0.03),(4,'Доска',4,1,3000,250,50,0.0375),(5,'Доска',4,1,3000,300,50,0.045),(6,'Доска',4,1,6000,100,50,0.03),(7,'Доска',4,1,6000,150,50,0.045),(8,'Доска',4,1,6000,200,50,0.06),(9,'Доска',4,1,6000,250,50,0.075),(10,'Доска',4,1,6000,300,50,0.09),(11,'OSB',4,2,NULL,NULL,9,NULL),(12,'OSB',4,2,NULL,NULL,10,NULL),(13,'OSB',4,2,NULL,NULL,15,NULL),(14,'OSB',4,2,NULL,NULL,18,NULL),(15,'Кнауф ТеплоКнауф 100 мм',4,3,NULL,NULL,100,NULL),(16,'Технониколь 100 мм',4,3,NULL,NULL,100,NULL),(17,'Эковер 100 мм',4,3,NULL,NULL,100,NULL),(18,'Эковер 150 мм',4,3,NULL,NULL,150,NULL),(19,'Эковер 200 мм',4,3,NULL,NULL,200,NULL),(20,'Фасад 200 мм',4,3,NULL,NULL,200,NULL),(21,'Эковер 250 мм',4,3,NULL,NULL,250,NULL),(22,'Ондутис',2,5,NULL,NULL,NULL,NULL),(23,'Пароизоляция Axton (b)',2,5,NULL,NULL,NULL,NULL),(24,'Пароизоляционная пленка Ютафол Н 96 Сильвер',2,5,NULL,NULL,NULL,NULL),(25,'Пароизоляция В',2,5,NULL,NULL,NULL,NULL),(26,'Ветро-влагозащитная мембрана Brane А',2,4,NULL,NULL,NULL,NULL),(27,'Паропроницаемая ветро-влагозащита A Optima',2,4,NULL,NULL,NULL,NULL),(28,'Гидро-ветрозащита Тип А',2,4,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openings`
--

LOCK TABLES `openings` WRITE;
/*!40000 ALTER TABLE `openings` DISABLE KEYS */;
INSERT INTO `openings` VALUES (3,'window',3,2),(4,'externalDoor',1,2),(5,'internalDoor',1,1),(6,'window',1,2),(7,'externalDoor',2,1),(8,'internalDoor',2,1),(9,'window',1,2),(10,'externalDoor',2,1),(11,'internalDoor',1,1),(12,'window',1,2),(13,'externalDoor',2,1),(14,'internalDoor',1,1),(15,'window',1,2),(16,'externalDoor',2,1),(17,'internalDoor',1,1),(18,'window',1,1),(19,'externalDoor',1,1),(20,'internalDoor',1,1),(21,'window',1,1),(22,'externalDoor',1,1),(23,'internalDoor',1,1),(24,'window',1,1),(25,'externalDoor',1,1),(26,'internalDoor',1,1),(27,'window',1,1),(28,'externalDoor',1,1),(29,'internalDoor',1,1),(30,'window',1,1),(31,'externalDoor',1,1),(32,'internalDoor',1,1),(33,'window',1,1),(34,'externalDoor',1,1),(35,'internalDoor',1,1),(36,'window',1,1),(37,'externalDoor',1,1),(38,'internalDoor',1,1),(39,'window',1,1),(40,'externalDoor',1,1),(41,'internalDoor',1,1),(42,'window',1,1),(43,'externalDoor',1,1),(44,'internalDoor',1,1),(45,'window',1,1),(46,'externalDoor',1,1),(47,'internalDoor',1,1),(48,'window',1,1),(49,'externalDoor',1,1),(50,'internalDoor',1,1),(51,'window',1,1),(52,'externalDoor',1,1),(53,'internalDoor',1,1),(54,'window',1,1),(55,'externalDoor',1,1),(56,'internalDoor',1,1),(57,'window',1,1),(58,'externalDoor',1,1),(59,'internalDoor',1,1),(60,'window',1,1),(61,'externalDoor',1,1),(62,'internalDoor',1,1),(63,'window',1,1),(64,'externalDoor',1,1),(65,'internalDoor',1,1),(66,'window',1,1),(67,'externalDoor',1,1),(68,'internalDoor',1,1),(69,'window',1,1),(70,'externalDoor',1,1),(71,'internalDoor',1,1),(72,'window',1,1),(73,'externalDoor',1,1),(74,'internalDoor',1,1),(75,'window',1,1),(76,'externalDoor',1,1),(77,'internalDoor',1,1),(78,'window',1,1),(79,'externalDoor',1,1),(80,'internalDoor',1,1),(81,'window',1,1),(82,'externalDoor',1,1),(83,'internalDoor',1,1),(84,'window',1,1),(85,'externalDoor',1,1),(86,'internalDoor',1,1),(87,'window',1,1),(88,'externalDoor',1,1),(89,'internalDoor',1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `openings_in_a_structural_element_frame`
--

LOCK TABLES `openings_in_a_structural_element_frame` WRITE;
/*!40000 ALTER TABLE `openings_in_a_structural_element_frame` DISABLE KEYS */;
INSERT INTO `openings_in_a_structural_element_frame` VALUES (1,5,3,1),(2,5,4,3),(3,5,5,1),(4,6,6,3),(5,6,7,2),(6,6,8,3),(7,7,9,3),(8,7,10,1),(9,7,11,1),(10,8,12,3),(11,8,13,1),(12,8,14,1),(13,9,15,3),(14,9,16,1),(15,9,17,1),(16,12,18,1),(17,12,19,1),(18,12,20,1),(19,13,21,1),(20,13,22,1),(21,13,23,1),(22,14,24,1),(23,14,25,1),(24,14,26,1),(25,15,27,1),(26,15,28,1),(27,15,29,1),(28,16,30,1),(29,16,31,1),(30,16,32,1),(31,17,33,1),(32,17,34,1),(33,17,35,1),(34,18,36,1),(35,18,37,1),(36,18,38,1),(37,19,39,1),(38,19,40,1),(39,19,41,1),(40,20,42,1),(41,20,43,1),(42,20,44,1),(43,21,45,1),(44,21,46,1),(45,21,47,1),(46,22,48,1),(47,22,49,1),(48,22,50,1),(49,23,51,1),(50,23,52,1),(51,23,53,1),(52,24,54,1),(53,24,55,1),(54,24,56,1),(55,25,57,1),(56,25,58,1),(57,25,59,1),(58,26,60,1),(59,26,61,1),(60,26,62,1),(61,27,63,1),(62,27,64,1),(63,27,65,1),(64,28,66,1),(65,28,67,1),(66,28,68,1),(67,29,69,1),(68,29,70,1),(69,29,71,1),(70,30,72,1),(71,30,73,1),(72,30,74,1),(73,31,75,1),(74,31,76,1),(75,31,77,1),(76,32,78,1),(77,32,79,1),(78,32,80,1),(79,33,81,1),(80,33,82,1),(81,33,83,1),(82,34,84,1),(83,34,85,1),(84,34,86,1),(85,35,87,1),(86,35,88,1),(87,35,89,1);
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
INSERT INTO `price_lists` VALUES (1,1,'2025-03-27',12000,16800),(2,2,'2025-03-27',12000,16800),(3,3,'2025-03-27',12000,16800),(4,4,'2025-03-27',12000,16800),(5,5,'2025-03-27',12000,16800),(6,6,'2025-03-27',12000,16800),(7,7,'2025-03-27',12000,16800),(8,8,'2025-03-27',12000,16800),(9,9,'2025-03-27',12000,16800),(10,10,'2025-03-27',12000,16800),(11,11,'2025-03-27',256,358.4),(12,12,'2025-03-27',288,403.2),(13,13,'2025-03-27',384,537.6),(14,14,'2025-03-27',480,672),(15,15,'2025-03-27',3000,4200),(16,16,'2025-03-27',3500,4900),(17,17,'2025-03-27',2800,3920),(18,18,'2025-03-27',2800,3920),(19,19,'2025-03-27',2800,3920),(20,20,'2025-03-27',3200,4480),(21,21,'2025-03-27',2800,3920),(22,22,'2025-03-27',33,46.2),(23,23,'2025-03-27',20,28),(24,24,'2025-03-27',21,29.4),(25,25,'2025-03-27',11,15.4),(26,26,'2025-03-27',57,79.8),(27,27,'2025-03-27',21,29.4),(28,28,'2025-03-27',53,53);
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
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES (1,1,'Доска 50*100*3000',0,16800,3,6888,18,'internalWall'),(2,6,'Доска 50*100*3000',0,16800,3,6888,18,'internalWall'),(4,3,'Доска 50*200*6000',2,16800,3,40320,18,'overlaps'),(5,8,'Доска 50*200*6000',2,16800,3,40320,18,'overlaps'),(7,1,'Доска 50*100*3000',0.41,16800,3,6888,19,'internalWall'),(8,6,'Доска 50*100*3000',0.41,16800,3,6888,19,'internalWall'),(10,3,'Доска 50*200*6000',2.4,16800,3,40320,19,'overlaps'),(11,8,'Доска 50*200*6000',2.4,16800,3,40320,19,'overlaps'),(13,1,'Доска 50*100*3000',0.41,16800,3,6888,20,'internalWall'),(14,6,'Доска 50*100*3000',0.41,16800,3,6888,20,'internalWall'),(16,3,'Доска 50*200*6000',2.4,16800,3,40320,20,'overlaps'),(17,8,'Доска 50*200*6000',2.4,16800,3,40320,20,'overlaps'),(19,1,'Доска 50*100*3000',0.41,16800,3,6888,21,'internalWall'),(20,6,'Доска 50*100*3000',0.41,16800,3,6888,21,'internalWall'),(22,3,'Доска 50*200*6000',2.4,16800,3,40320,21,'overlaps'),(23,8,'Доска 50*200*6000',2.4,16800,3,40320,21,'overlaps'),(25,1,'Доска 50*100*3000',0.41,16800,3,6888,22,'internalWall'),(26,6,'Доска 50*100*3000',0.41,16800,3,6888,22,'internalWall'),(28,3,'Доска 50*200*6000',2.4,16800,3,40320,22,'overlaps'),(29,8,'Доска 50*200*6000',2.4,16800,3,40320,22,'overlaps'),(31,1,'Доска 50*100*3000',0.41,16800,3,6888,23,'internalWall'),(32,6,'Доска 50*100*3000',0.41,16800,3,6888,23,'internalWall'),(34,3,'Доска 50*200*6000',2.4,16800,3,40320,23,'overlaps'),(35,8,'Доска 50*200*6000',2.4,16800,3,40320,23,'overlaps'),(40,1,'Доска 50*100*3000',0.41,16800,3,6888,24,'internalWall'),(41,6,'Доска 50*100*3000',0.41,16800,3,6888,24,'internalWall'),(43,3,'Доска 50*200*6000',2.4,16800,3,40320,24,'overlaps'),(44,8,'Доска 50*200*6000',2.4,16800,3,40320,24,'overlaps'),(49,1,'Доска 50*100*3000',0.41,16800,3,6888,25,'internalWall'),(50,6,'Доска 50*100*3000',0.41,16800,3,6888,25,'internalWall'),(52,3,'Доска 50*200*6000',2.4,16800,3,40320,25,'overlaps'),(53,8,'Доска 50*200*6000',2.4,16800,3,40320,25,'overlaps'),(82,1,'Доска 50*100*3000',1.11,16800,3,18648,29,'externalWall'),(83,6,'Доска 50*100*3000',1.11,16800,3,18648,29,'externalWall'),(85,1,'Доска 50*100*3000',0.41,16800,3,6888,29,'internalWall'),(86,6,'Доска 50*100*3000',0.41,16800,3,6888,29,'internalWall'),(88,3,'Доска 50*200*6000',2.4,16800,3,40320,29,'overlaps'),(89,8,'Доска 50*200*6000',2.4,16800,3,40320,29,'overlaps'),(91,1,'Доска 50*100*3000',1.11,16800,3,18648,30,'externalWall'),(92,6,'Доска 50*100*3000',1.11,16800,3,18648,30,'externalWall'),(94,1,'Доска 50*100*3000',0.41,16800,3,6888,30,'internalWall'),(95,6,'Доска 50*100*3000',0.41,16800,3,6888,30,'internalWall'),(97,3,'Доска 50*200*6000',2.4,16800,3,40320,30,'overlaps'),(98,8,'Доска 50*200*6000',2.4,16800,3,40320,30,'overlaps'),(100,1,'Доска 50*100*3000',1.11,16800,3,18648,33,'externalWall'),(101,6,'Доска 50*100*3000',1.11,16800,3,18648,33,'externalWall'),(103,15,'Кнауф ТеплоКнауф 100 мм',9.7,4200,3,40740,33,'externalWall'),(104,11,'OSB 9 мм',207,358.4,3,74188.8,33,'externalWall'),(105,22,'Ондутис',103.5,46.2,3,4781.7,33,'externalWall'),(106,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,33,'externalWall'),(107,1,'Доска 50*100*3000',0.41,16800,3,6888,33,'internalWall'),(108,6,'Доска 50*100*3000',0.41,16800,3,6888,33,'internalWall'),(110,11,'OSB 9 мм',103.5,358.4,3,37094.4,33,'internalWall'),(111,3,'Доска 50*200*6000',2.4,16800,3,40320,33,'overlaps'),(112,8,'Доска 50*200*6000',2.4,16800,3,40320,33,'overlaps'),(114,19,'Эковер 200 мм',24.64,3920,3,96588.8,33,'overlaps'),(115,11,'OSB 9 мм',257.6,358.4,3,92323.8,33,'overlaps'),(116,22,'Ондутис',64.4,46.2,3,2975.28,33,'overlaps'),(117,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,33,'overlaps'),(118,1,'Доска 50*100*3000',1.11,16800,3,18648,34,'externalWall'),(119,15,'Кнауф ТеплоКнауф 100 мм',9.7,4200,3,40740,34,'externalWall'),(120,11,'OSB 9 мм',207,358.4,3,74188.8,34,'externalWall'),(121,22,'Ондутис',103.5,46.2,3,4781.7,34,'externalWall'),(122,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,34,'externalWall'),(123,1,'Доска 50*100*3000',0.41,16800,3,6888,34,'internalWall'),(124,11,'OSB 9 мм',103.5,358.4,3,37094.4,34,'internalWall'),(125,8,'Доска 50*200*6000',2.4,16800,3,40320,34,'overlaps'),(126,19,'Эковер 200 мм',24.64,3920,3,96588.8,34,'overlaps'),(127,11,'OSB 9 мм',257.6,358.4,3,92323.8,34,'overlaps'),(128,22,'Ондутис',64.4,46.2,3,2975.28,34,'overlaps'),(129,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,34,'overlaps'),(130,1,'Доска 50*100*3000',1.11,16800,3,18648,35,'externalWall'),(131,15,'Кнауф ТеплоКнауф 100 мм',9.7,4200,3,40740,35,'externalWall'),(132,11,'OSB 9 мм',207,358.4,3,74188.8,35,'externalWall'),(133,22,'Ондутис',103.5,46.2,3,4781.7,35,'externalWall'),(134,26,'Ветро-влагозащитная мембрана Brane А',103.5,79.8,3,8259.3,35,'externalWall'),(135,1,'Доска 50*100*3000',0.41,16800,3,6888,35,'internalWall'),(136,11,'OSB 9 мм',103.5,358.4,3,37094.4,35,'internalWall'),(137,8,'Доска 50*200*6000',2.4,16800,3,40320,35,'overlaps'),(138,19,'Эковер 200 мм',24.64,3920,3,96588.8,35,'overlaps'),(139,11,'OSB 9 мм',257.6,358.4,3,92323.8,35,'overlaps'),(140,22,'Ондутис',64.4,46.2,3,2975.28,35,'overlaps'),(141,26,'Ветро-влагозащитная мембрана Brane А',64.4,79.8,3,5139.12,35,'overlaps');
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
  `OSB_external_wall` varchar(200) NOT NULL,
  `steam_waterproofing_external_wall` varchar(200) NOT NULL,
  `windscreen_extern_wall` varchar(200) NOT NULL,
  `insulation_external_wall` varchar(200) NOT NULL,
  `overlap_thickness` varchar(200) NOT NULL,
  `OSB_thickness` varchar(200) NOT NULL,
  `steam_waterproofing_thickness` varchar(200) NOT NULL,
  `windscreen_thickness` varchar(200) NOT NULL,
  `insulation_thickness` varchar(200) NOT NULL,
  `OSB_internal_wall` varchar(200) NOT NULL,
  `calculation_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structural_element_frame`
--

LOCK TABLES `structural_element_frame` WRITE;
/*!40000 ALTER TABLE `structural_element_frame` DISABLE KEYS */;
INSERT INTO `structural_element_frame` VALUES (5,2,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',9),(6,2,2,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',9),(7,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',10),(8,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',11),(9,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',12),(10,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',13),(11,1,1,3,30,56,100,15,100,'9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9 мм','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9 мм',14),(12,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',15),(13,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',16),(14,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',17),(15,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',18),(16,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',19),(17,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',20),(18,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',21),(19,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',22),(20,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',23),(21,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',24),(22,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',25),(23,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',26),(24,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',27),(25,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',28),(26,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',29),(27,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',30),(28,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','9',31),(29,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',32),(30,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',33),(31,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',34),(32,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',35),(33,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',36),(34,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',37),(35,1,1,3,30,56,100,15,100,'9','Ондутис','Ветро-влагозащитная мембрана Brane А','Кнауф ТеплоКнауф 100 мм','200','9','Ондутис','Ветро-влагозащитная мембрана Brane А','Эковер 200 мм','9',38);
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

-- Dump completed on 2025-03-28 12:10:39
