/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: db_welons_prototype
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category_lookup`
--

DROP TABLE IF EXISTS `category_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_lookup`
--

LOCK TABLES `category_lookup` WRITE;
/*!40000 ALTER TABLE `category_lookup` DISABLE KEYS */;
INSERT INTO `category_lookup` VALUES
(12,''),
(9,'ACCESSORY'),
(10,'CIVIL WORK'),
(7,'CONSUMABLE'),
(5,'DOOR/WINDOW'),
(8,'ELECTRICAL MATERIALS'),
(3,'FLOORING'),
(4,'FOAM BOARD'),
(11,'INSTALLATION FEE'),
(6,'INTERIOR'),
(14,'MAIN'),
(1,'MAINFRAME'),
(13,'None'),
(2,'ROOFING');
/*!40000 ALTER TABLE `category_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color_lookup`
--

DROP TABLE IF EXISTS `color_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `color_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `color` (`color`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_lookup`
--

LOCK TABLES `color_lookup` WRITE;
/*!40000 ALTER TABLE `color_lookup` DISABLE KEYS */;
INSERT INTO `color_lookup` VALUES
(9,''),
(7,'BLACK'),
(5,'BLUE'),
(1,'BROWN'),
(3,'GRAY'),
(10,'None'),
(4,'RED'),
(2,'WHITE'),
(6,'YELLOW');
/*!40000 ALTER TABLE `color_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_to_acc_lookup`
--

DROP TABLE IF EXISTS `credit_to_acc_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_to_acc_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_to_acc` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_to_acc_lookup`
--

LOCK TABLES `credit_to_acc_lookup` WRITE;
/*!40000 ALTER TABLE `credit_to_acc_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_to_acc_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispatch`
--

DROP TABLE IF EXISTS `dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispatch` (
  `project_control_no` varchar(255) NOT NULL,
  `installer_id` int(11) DEFAULT NULL,
  `trucking_service_id` int(11) DEFAULT NULL,
  `packing_list` varchar(255) DEFAULT NULL,
  `date_approved` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`project_control_no`),
  KEY `installer_id` (`installer_id`),
  KEY `trucking_service_id` (`trucking_service_id`),
  CONSTRAINT `dispatch_ibfk_1` FOREIGN KEY (`project_control_no`) REFERENCES `project` (`control_no`),
  CONSTRAINT `dispatch_ibfk_2` FOREIGN KEY (`installer_id`) REFERENCES `installer_lookup` (`id`),
  CONSTRAINT `dispatch_ibfk_3` FOREIGN KEY (`trucking_service_id`) REFERENCES `trucking_service_lookup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispatch`
--

LOCK TABLES `dispatch` WRITE;
/*!40000 ALTER TABLE `dispatch` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `installer_lookup`
--

DROP TABLE IF EXISTS `installer_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `installer_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `installer` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `installer_lookup`
--

LOCK TABLES `installer_lookup` WRITE;
/*!40000 ALTER TABLE `installer_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `installer_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_id` int(11) NOT NULL,
  `specs_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `remarks_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `qt_desc_id` int(11) DEFAULT NULL,
  `total_qty` int(11) NOT NULL DEFAULT 0,
  `official_srp` decimal(15,2) NOT NULL DEFAULT 0.00,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `unit_id` (`unit_id`),
  KEY `color_id` (`color_id`),
  KEY `qt_desc_id` (`qt_desc_id`),
  KEY `name_id` (`name_id`),
  KEY `specs_id` (`specs_id`),
  KEY `remarks_id` (`remarks_id`),
  CONSTRAINT `item_ibfk_10` FOREIGN KEY (`remarks_id`) REFERENCES `remarks_lookup` (`id`),
  CONSTRAINT `item_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category_lookup` (`id`),
  CONSTRAINT `item_ibfk_4` FOREIGN KEY (`unit_id`) REFERENCES `unit_lookup` (`id`),
  CONSTRAINT `item_ibfk_6` FOREIGN KEY (`color_id`) REFERENCES `color_lookup` (`id`),
  CONSTRAINT `item_ibfk_7` FOREIGN KEY (`qt_desc_id`) REFERENCES `qt_desc_lookup` (`id`),
  CONSTRAINT `item_ibfk_8` FOREIGN KEY (`name_id`) REFERENCES `name_lookup` (`id`),
  CONSTRAINT `item_ibfk_9` FOREIGN KEY (`specs_id`) REFERENCES `specs_lookup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES
(2,99,9,1,1,1,2,NULL,100,100.00,NULL),
(4,100,11,1,1,2,2,NULL,100,120.00,'./static/2024-08-31-203457_hyprshot.png');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `name_lookup`
--

DROP TABLE IF EXISTS `name_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `name_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `name_lookup`
--

LOCK TABLES `name_lookup` WRITE;
/*!40000 ALTER TABLE `name_lookup` DISABLE KEYS */;
INSERT INTO `name_lookup` VALUES
(75,'ACU'),
(84,'ACU BRACKET'),
(85,'ACU PROVISION'),
(66,'ADDITIONAL ELECTRICAL WORKS'),
(65,'ANCHOR BOLT'),
(24,'AWNING WINDOW'),
(143,'BLACK SCREWS'),
(131,'BOLT AND NUT'),
(124,'BOLTS AND SCREWS'),
(101,'BOTTOM LONG BEAM'),
(100,'BOTTOM SHORT BEAM'),
(106,'BOTTOM SQUARE TUBE'),
(107,'BOTTOM SQUARE TUBE (SEAMLESS FLOORING)'),
(126,'BOTTOM TUBE SCREW'),
(136,'BREAKER'),
(137,'BREAKER COVER'),
(10,'CANOPY'),
(57,'CARPENTRY WORKS'),
(127,'CARRIAGE BOLTS'),
(111,'CEILING'),
(73,'CEILING WORKS'),
(47,'CLEAR TEMPERED GLASS'),
(77,'CLEARING'),
(99,'COLUMN'),
(20,'COLUMN GUTTER'),
(72,'CONCRETE WORKS'),
(104,'CONNECT (CASTING)'),
(19,'CONNECTING PLATE SET'),
(21,'CORNER LINE'),
(120,'CORNER LINE CEILING'),
(121,'CORNER LINE COLUMN'),
(35,'CUSTOMIZED DOOR'),
(86,'CUSTOMIZED DOOR FRAME'),
(41,'CUSTOMIZED GLASS WORKS'),
(36,'CUSTOMIZED JOINT COVER'),
(42,'CUSTOMIZED ROOFING WORKS'),
(13,'CUSTOMIZED STAIR WITH DOUBLE LANDING'),
(59,'CUSTOMIZED STAIRS'),
(44,'CUSTOMIZED TOILET AND BATH'),
(14,'DECKING'),
(94,'DECORATIVE BOARD'),
(92,'DEMOBILIZATION'),
(115,'DOOR & WINDOW BOARD'),
(90,'DOOR COVER'),
(117,'DOOR FRAME TUBE'),
(133,'DOOR HOLE COVER'),
(132,'DOOR LOCK'),
(91,'DOUBLE SWING STEEL DOOR'),
(71,'EARTH WORKS'),
(142,'ELECTRICAL TAPE'),
(134,'ELECTRICAL WIRE'),
(69,'ELECTRICAL WORK PROVISION TO ACU'),
(50,'ELECTRICAL WORKS'),
(78,'EMBANKMENT '),
(87,'EXPANSION BOLT'),
(55,'EXTERIOR WORKS'),
(34,'EXTRA DOOR INSTALLATION'),
(89,'EXTRA LED LIGHT'),
(16,'EXTRA WINDOW'),
(37,'EXTRA WINDOW INSTALLATION'),
(74,'FINISHES'),
(56,'FIXTURE'),
(128,'FLOOR NAIL'),
(31,'FOOTING LABOR'),
(79,'FOUNDATION WORKS'),
(39,'GLASS INSTALLATION'),
(81,'GLASS WALL'),
(23,'GLASS WALL DOOR'),
(38,'GUTTER INSTALLATION'),
(93,'HOLE PROVISION FOR ACU'),
(54,'INTERIOR WORKS'),
(97,'LACQUER PAINT'),
(70,'LAND PREPARATION '),
(135,'LED LIGHT'),
(53,'MASONRY WORKS'),
(18,'MGO BOARD'),
(112,'MGO FLOOR 2.8M'),
(113,'MGO FLOOR 3.0M'),
(146,'None'),
(76,'OCULAR INSPECTION'),
(68,'OVERHEAD CABINET'),
(63,'OVERHEAD CONTINGENCY & MOBILIZATION'),
(58,'PAINTING WORKS'),
(51,'PLUMBING WORKS'),
(96,'POLYLITE COVER'),
(15,'POST PROVISION FOR ROOF AT DECKED AREA'),
(2,'PREFAB CONTAINER BROWN'),
(3,'PREFAB CONTAINER GRAY'),
(1,'PREFAB CONTAINER WHITE'),
(4,'PREFAB CONTAINER WHITE 3(L)*3(W)*2.8(H) m, 9 sqm'),
(5,'PREFAB CONTAINER WHITE 5.95(L)*3(W)*2.8(H) m, 3.0(T) mm'),
(6,'PREFAB CONTAINER WHITE 5.95(L)*4(W)*2.8(H)'),
(61,'PREFAB DISCOUNT'),
(88,'PREFAB DISMANTLING '),
(7,'PREFAB TOILET AND BATH'),
(26,'PREFAB UNIT INSTALLATION'),
(119,'PRESSING PLATE GROOVE (GUTTER)'),
(11,'RAILING'),
(29,'RAILING INSTALLATION'),
(82,'RAIN WATER TANK / CATCH BASIN'),
(22,'REINFORCED FLOORING'),
(110,'ROOFING'),
(125,'SEALING STRIP'),
(25,'SEAMLESS FLOORING'),
(46,'SECONDARY ROOFING WORKS'),
(129,'SELF TAPPING NAIL'),
(32,'SEPTIC TANK LABOR'),
(95,'SEPTIC WORK WITH PLUMBING WORKS'),
(45,'SEPTIC WORKS'),
(140,'SOCKETS W/ BACK COVER (1 GANG)'),
(141,'SOCKETS W/ BACK COVER (2 GANG)'),
(98,'SOFFIT CEILING WITH FRIEZE COVER'),
(67,'STAINLESS STEEL SINK'),
(12,'STAIRS'),
(27,'STAIRS INSTALLATION'),
(40,'STANDARD FOOTING'),
(43,'STANDARD TOILET AND BATH'),
(116,'STEEL DOOR'),
(52,'STEEL WORKS'),
(64,'SUPPORT POST FOR WALKWAY'),
(122,'SUPPORT TUBE'),
(130,'SUPPORT TUBE BOLTS'),
(138,'SWITCH (1 GANG)'),
(139,'SWITCH (2 GANG)'),
(83,'TECHNICAL DRAWING PLAN'),
(147,'TEST NAME'),
(123,'THERMAL INSULATION COTTON'),
(60,'TILE WORKS'),
(30,'TOILET AND BATH INSTALLATION'),
(103,'TOP LONG BEAM'),
(102,'TOP SHORT BEAM'),
(109,'TOP SQUARE TUBE'),
(108,'TOP SQUARE TUBE (T)'),
(105,'TUBULAR'),
(9,'WALKWAY/RAILING'),
(8,'WALKWAY/RAILING/CANOPY'),
(28,'WALKWAY/RAILING/CANOPY INSTALLATION'),
(114,'WALL BOARD'),
(17,'WALL PANEL BOARD'),
(33,'WALL PANEL INSTALLATION'),
(48,'WATER HEATER'),
(118,'WINDOW');
/*!40000 ALTER TABLE `name_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status_lookup`
--

DROP TABLE IF EXISTS `order_status_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_status_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status_lookup`
--

LOCK TABLES `order_status_lookup` WRITE;
/*!40000 ALTER TABLE `order_status_lookup` DISABLE KEYS */;
INSERT INTO `order_status_lookup` VALUES
(1,'DISPATCHED'),
(2,'FOR DISPATCH'),
(3,'FOR PO'),
(4,'PICKED-UP'),
(5,'RESERVED'),
(6,'WAITING ARRIVAL'),
(7,'NA');
/*!40000 ALTER TABLE `order_status_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `other_works`
--

DROP TABLE IF EXISTS `other_works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `other_works` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `qt_desc_id` int(11) DEFAULT NULL,
  `official_srp` decimal(15,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `unit_id` (`unit_id`),
  KEY `qt_desc_id` (`qt_desc_id`),
  KEY `name_id` (`name_id`),
  CONSTRAINT `other_works_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category_lookup` (`id`),
  CONSTRAINT `other_works_ibfk_3` FOREIGN KEY (`unit_id`) REFERENCES `unit_lookup` (`id`),
  CONSTRAINT `other_works_ibfk_4` FOREIGN KEY (`qt_desc_id`) REFERENCES `qt_desc_lookup` (`id`),
  CONSTRAINT `other_works_ibfk_5` FOREIGN KEY (`name_id`) REFERENCES `name_lookup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `other_works`
--

LOCK TABLES `other_works` WRITE;
/*!40000 ALTER TABLE `other_works` DISABLE KEYS */;
/*!40000 ALTER TABLE `other_works` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `project_control_no` varchar(255) NOT NULL,
  `date_paid` timestamp NOT NULL,
  `balance_due` decimal(10,0) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  `deposit_date` timestamp NULL DEFAULT NULL,
  `deposit_slip` varchar(255) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `credit_to_acc_id` int(11) DEFAULT NULL,
  `payment_status_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`project_control_no`),
  KEY `payment_method_id` (`payment_method_id`),
  KEY `credit_to_acc_id` (`credit_to_acc_id`),
  KEY `payment_status_id` (`payment_status_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`project_control_no`) REFERENCES `project` (`control_no`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method_lookup` (`id`),
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`credit_to_acc_id`) REFERENCES `credit_to_acc_lookup` (`id`),
  CONSTRAINT `payment_ibfk_4` FOREIGN KEY (`payment_status_id`) REFERENCES `payment_status_lookup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method_lookup`
--

DROP TABLE IF EXISTS `payment_method_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_method_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method_lookup`
--

LOCK TABLES `payment_method_lookup` WRITE;
/*!40000 ALTER TABLE `payment_method_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_method_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_status_lookup`
--

DROP TABLE IF EXISTS `payment_status_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_status_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_status_lookup`
--

LOCK TABLES `payment_status_lookup` WRITE;
/*!40000 ALTER TABLE `payment_status_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_status_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefab`
--

DROP TABLE IF EXISTS `prefab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_id` int(11) DEFAULT NULL,
  `specs_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `qt_desc_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `official_srp` decimal(15,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `specs_id` (`specs_id`),
  KEY `color_id` (`color_id`),
  KEY `qt_desc_id` (`qt_desc_id`),
  KEY `name_id` (`name_id`),
  CONSTRAINT `prefab_ibfk_2` FOREIGN KEY (`specs_id`) REFERENCES `specs_lookup` (`id`),
  CONSTRAINT `prefab_ibfk_3` FOREIGN KEY (`color_id`) REFERENCES `color_lookup` (`id`),
  CONSTRAINT `prefab_ibfk_4` FOREIGN KEY (`qt_desc_id`) REFERENCES `qt_desc_lookup` (`id`),
  CONSTRAINT `prefab_ibfk_5` FOREIGN KEY (`name_id`) REFERENCES `name_lookup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefab`
--

LOCK TABLES `prefab` WRITE;
/*!40000 ALTER TABLE `prefab` DISABLE KEYS */;
INSERT INTO `prefab` VALUES
(2,2,1,1,NULL,1,123123.00);
/*!40000 ALTER TABLE `prefab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefab_item`
--

DROP TABLE IF EXISTS `prefab_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefab_item` (
  `prefab_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `qty_per_prefab` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`prefab_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `prefab_item_ibfk_1` FOREIGN KEY (`prefab_id`) REFERENCES `prefab` (`id`),
  CONSTRAINT `prefab_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefab_item`
--

LOCK TABLES `prefab_item` WRITE;
/*!40000 ALTER TABLE `prefab_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `prefab_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `control_no` varchar(255) NOT NULL,
  `project_code` varchar(255) DEFAULT NULL,
  `project_details` text DEFAULT NULL,
  `delivery_fee` decimal(15,2) NOT NULL DEFAULT 0.00,
  `grand_total` decimal(15,2) NOT NULL DEFAULT 0.00,
  `unit_status_id` int(11) NOT NULL DEFAULT 3,
  `order_status_id` int(11) NOT NULL DEFAULT 7,
  PRIMARY KEY (`control_no`),
  UNIQUE KEY `project_code` (`project_code`),
  KEY `unit_status_id` (`unit_status_id`),
  KEY `order_status_id` (`order_status_id`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`unit_status_id`) REFERENCES `unit_status_lookup` (`id`),
  CONSTRAINT `project_ibfk_3` FOREIGN KEY (`order_status_id`) REFERENCES `order_status_lookup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES
('TESTCONTROLNO',NULL,NULL,0.00,0.00,3,7);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_offset_item`
--

DROP TABLE IF EXISTS `project_offset_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_offset_item` (
  `project_control_no` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  KEY `project_control_no` (`project_control_no`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `project_offset_item_ibfk_1` FOREIGN KEY (`project_control_no`) REFERENCES `project` (`control_no`),
  CONSTRAINT `project_offset_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_offset_item`
--

LOCK TABLES `project_offset_item` WRITE;
/*!40000 ALTER TABLE `project_offset_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_offset_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_other_works`
--

DROP TABLE IF EXISTS `project_other_works`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_other_works` (
  `project_control_no` varchar(255) NOT NULL,
  `other_works_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  KEY `project_control_no` (`project_control_no`),
  KEY `other_works_id` (`other_works_id`),
  CONSTRAINT `project_other_works_ibfk_1` FOREIGN KEY (`project_control_no`) REFERENCES `project` (`control_no`),
  CONSTRAINT `project_other_works_ibfk_2` FOREIGN KEY (`other_works_id`) REFERENCES `other_works` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_other_works`
--

LOCK TABLES `project_other_works` WRITE;
/*!40000 ALTER TABLE `project_other_works` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_other_works` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_prefab`
--

DROP TABLE IF EXISTS `project_prefab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_prefab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_control_no` varchar(255) NOT NULL,
  `prefab_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_control_no` (`project_control_no`),
  KEY `prefab_id` (`prefab_id`),
  CONSTRAINT `project_prefab_ibfk_1` FOREIGN KEY (`project_control_no`) REFERENCES `project` (`control_no`),
  CONSTRAINT `project_prefab_ibfk_2` FOREIGN KEY (`prefab_id`) REFERENCES `prefab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_prefab`
--

LOCK TABLES `project_prefab` WRITE;
/*!40000 ALTER TABLE `project_prefab` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_prefab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_prefab_item`
--

DROP TABLE IF EXISTS `project_prefab_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_prefab_item` (
  `project_prefab_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `qty_per_prefab` int(11) NOT NULL,
  KEY `project_prefab_id` (`project_prefab_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `project_prefab_item_ibfk_1` FOREIGN KEY (`project_prefab_id`) REFERENCES `project_prefab` (`id`),
  CONSTRAINT `project_prefab_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_prefab_item`
--

LOCK TABLES `project_prefab_item` WRITE;
/*!40000 ALTER TABLE `project_prefab_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_prefab_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order` (
  `pi_no` varchar(255) NOT NULL,
  `batch_no` int(11) NOT NULL,
  `batch_year` year(4) NOT NULL DEFAULT year(current_timestamp()),
  `date_submitted` timestamp NULL DEFAULT NULL,
  `date_approved` timestamp NULL DEFAULT NULL,
  `cif_cost` decimal(15,2) NOT NULL,
  `handling_cost` decimal(15,2) NOT NULL,
  `total_cost` decimal(15,2) DEFAULT NULL,
  `date_paid` timestamp NULL DEFAULT NULL,
  `arrival_date` timestamp NULL DEFAULT NULL,
  `documents` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pi_no`),
  UNIQUE KEY `batch_no` (`batch_no`,`batch_year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order`
--

LOCK TABLES `purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_item`
--

DROP TABLE IF EXISTS `purchase_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_item` (
  `pi_no` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  KEY `pi_no` (`pi_no`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `purchase_order_item_ibfk_1` FOREIGN KEY (`pi_no`) REFERENCES `purchase_order` (`pi_no`),
  CONSTRAINT `purchase_order_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_item`
--

LOCK TABLES `purchase_order_item` WRITE;
/*!40000 ALTER TABLE `purchase_order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_prefab`
--

DROP TABLE IF EXISTS `purchase_order_prefab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_prefab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pi_no` varchar(255) NOT NULL,
  `prefab_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit_price` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pi_no` (`pi_no`),
  KEY `prefab_id` (`prefab_id`),
  CONSTRAINT `purchase_order_prefab_ibfk_1` FOREIGN KEY (`pi_no`) REFERENCES `purchase_order` (`pi_no`),
  CONSTRAINT `purchase_order_prefab_ibfk_2` FOREIGN KEY (`prefab_id`) REFERENCES `prefab` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_prefab`
--

LOCK TABLES `purchase_order_prefab` WRITE;
/*!40000 ALTER TABLE `purchase_order_prefab` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_prefab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_prefab_item`
--

DROP TABLE IF EXISTS `purchase_order_prefab_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_prefab_item` (
  `purchase_order_prefab` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `qty_per_prefab` int(11) NOT NULL,
  KEY `purchase_order_prefab` (`purchase_order_prefab`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `purchase_order_prefab_item_ibfk_1` FOREIGN KEY (`purchase_order_prefab`) REFERENCES `purchase_order_prefab` (`id`),
  CONSTRAINT `purchase_order_prefab_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_prefab_item`
--

LOCK TABLES `purchase_order_prefab_item` WRITE;
/*!40000 ALTER TABLE `purchase_order_prefab_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_prefab_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt_contact_email`
--

DROP TABLE IF EXISTS `qt_contact_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt_contact_email` (
  `quotation` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  KEY `quotation` (`quotation`),
  CONSTRAINT `qt_contact_email_ibfk_1` FOREIGN KEY (`quotation`) REFERENCES `quotation` (`control_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt_contact_email`
--

LOCK TABLES `qt_contact_email` WRITE;
/*!40000 ALTER TABLE `qt_contact_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt_contact_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt_contact_no`
--

DROP TABLE IF EXISTS `qt_contact_no`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt_contact_no` (
  `quotation` varchar(255) NOT NULL,
  `phone_no` varchar(255) NOT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  KEY `quotation` (`quotation`),
  CONSTRAINT `qt_contact_no_ibfk_1` FOREIGN KEY (`quotation`) REFERENCES `quotation` (`control_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt_contact_no`
--

LOCK TABLES `qt_contact_no` WRITE;
/*!40000 ALTER TABLE `qt_contact_no` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt_contact_no` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt_desc_lookup`
--

DROP TABLE IF EXISTS `qt_desc_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt_desc_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qt_desc` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qt_desc` (`qt_desc`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt_desc_lookup`
--

LOCK TABLES `qt_desc_lookup` WRITE;
/*!40000 ALTER TABLE `qt_desc_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt_desc_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qt_draft`
--

DROP TABLE IF EXISTS `qt_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qt_draft` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `qt_hash` varchar(255) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `last_modified` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `json_path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_name` (`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qt_draft`
--

LOCK TABLES `qt_draft` WRITE;
/*!40000 ALTER TABLE `qt_draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `qt_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation`
--

DROP TABLE IF EXISTS `quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotation` (
  `control_no` varchar(255) NOT NULL,
  `qt_hash` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `site_location` text NOT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `expired` tinyint(1) NOT NULL DEFAULT 0,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `json_path` varchar(255) NOT NULL,
  PRIMARY KEY (`control_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation`
--

LOCK TABLES `quotation` WRITE;
/*!40000 ALTER TABLE `quotation` DISABLE KEYS */;
INSERT INTO `quotation` VALUES
('TESTCONTROLNO','TESTHASH',1,'TESTCLIENT','TESTLOCATION',0,0,0,'TESTJSON');
/*!40000 ALTER TABLE `quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remarks_lookup`
--

DROP TABLE IF EXISTS `remarks_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remarks_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `remarks` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remarks` (`remarks`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remarks_lookup`
--

LOCK TABLES `remarks_lookup` WRITE;
/*!40000 ALTER TABLE `remarks_lookup` DISABLE KEYS */;
INSERT INTO `remarks_lookup` VALUES
(1,'Galvanized'),
(2,'With square pipe head'),
(3,'With U-shaped bayonet'),
(4,'Drilling at both ends'),
(5,'With U-card and aircraft frame'),
(6,'Glass wool'),
(7,'Autohesion'),
(8,'Glass magnesium board'),
(9,'Double sided 0.3/50 foam board'),
(10,'Double sided wood 0.3/50 foam board'),
(11,'Steel door'),
(12,'Plastic steel window'),
(13,'Colour steel'),
(14,'Spare provided'),
(15,'For 2 storey units only. Please don\'t include for single story unit'),
(16,'White'),
(17,'Grayish white'),
(18,'Standard size for single unit'),
(19,'Special size for combined units'),
(20,'For seamless flooring'),
(21,'For ceiling along 6M'),
(22,'For ceiling along 3M'),
(23,'For corners/column'),
(24,'For combined units'),
(25,'Wires for socket'),
(26,'For lighting'),
(27,'Ground wire'),
(28,'Main entrance wire'),
(29,'Powder coating iron'),
(30,'GI tube'),
(31,'For walkway and stair walkway'),
(32,'Stainless steel screw'),
(33,'Powder coating steel'),
(34,'Bilateral perforation'),
(35,'For walkway railing and walkway support'),
(36,'For walkway 3 meter railing and 2 set 1 meter railings'),
(37,'For walkway and walkway support'),
(38,'For 1 meter railing and house column');
/*!40000 ALTER TABLE `remarks_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipment` (
  `container_no` varchar(255) NOT NULL,
  `pi_no` varchar(255) NOT NULL,
  `royalty_fee` decimal(15,2) DEFAULT 5000.00,
  `signing_fee` decimal(15,2) DEFAULT 1500.00,
  `demurrage_charge` decimal(15,2) DEFAULT 0.00,
  `releasing_cost` decimal(15,2) DEFAULT NULL,
  `total_cost` decimal(15,2) DEFAULT NULL,
  `port_arrival_date` timestamp NULL DEFAULT NULL,
  `releasing_date` timestamp NULL DEFAULT NULL,
  `warehouse_arrival_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`container_no`),
  KEY `pi_no` (`pi_no`),
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`pi_no`) REFERENCES `purchase_order` (`pi_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specs_lookup`
--

DROP TABLE IF EXISTS `specs_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specs_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `specs` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specs_lookup`
--

LOCK TABLES `specs_lookup` WRITE;
/*!40000 ALTER TABLE `specs_lookup` DISABLE KEYS */;
INSERT INTO `specs_lookup` VALUES
(1,'5.95*3'),
(2,'3*3'),
(3,'5.95*3 (3.0mm T)'),
(4,'5.95*4'),
(5,'7*3.5'),
(6,'1147*2795*18'),
(7,'1147*3000*18'),
(8,'12M/roll'),
(9,'160*160*2480*2.3'),
(10,'160*160*4.0'),
(11,'160*2680*2.3'),
(12,'160*5630*2.3'),
(13,'20*40*2550'),
(14,'20*40*6000'),
(15,'40*14KG/roll'),
(16,'40*40*2520'),
(17,'40*40*2780'),
(18,'40*40*5740'),
(19,'40*60*1880*1.1'),
(20,'40*80*1880*1.1'),
(21,'40*80*6000*2'),
(22,'50*100*2990*1.2'),
(23,'50*2700*1.0'),
(24,'50*50*2800*1.6'),
(25,'50*5700*1.0'),
(26,'80# 2.48M'),
(27,'920*1200'),
(28,'925*2040'),
(29,'950*2560*50'),
(30,'950*3200*50'),
(31,'980*2785*0.23'),
(32,'280*2950*0.45'),
(33,'LED strip lamp'),
(34,'M10*70mm'),
(35,'M4.2*16mm'),
(36,'M4.2*38mm'),
(37,'M5*25mm'),
(38,'M5*75mm'),
(39,'NEW'),
(40,'NEW (1 GANG)'),
(41,'NEW (2 GANG)'),
(42,'OLD'),
(43,'70*10'),
(44,'4500*1000*160mm'),
(45,'1.7mm thickness'),
(46,'1080*1000*6.5mm'),
(47,'4500*1000*40mm'),
(48,'Outer frame: 1.1mm thickness'),
(49,'Inner frame: 0.8mm thickness'),
(50,'1000*1000*40mm'),
(51,'1040*1000*40mm'),
(52,'3000*60*60mm'),
(53,'1.2mm thickness'),
(54,'2.5cm'),
(55,'3000*1000*65mm'),
(56,'3000*1000*40mm'),
(57,'1000*100*60mm'),
(58,'3.0mm thickness'),
(59,''),
(60,'146022400'),
(61,'TEST SPECS');
/*!40000 ALTER TABLE `specs_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trucking_service_lookup`
--

DROP TABLE IF EXISTS `trucking_service_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trucking_service_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trucking_service` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trucking_service_lookup`
--

LOCK TABLES `trucking_service_lookup` WRITE;
/*!40000 ALTER TABLE `trucking_service_lookup` DISABLE KEYS */;
/*!40000 ALTER TABLE `trucking_service_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_lookup`
--

DROP TABLE IF EXISTS `unit_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unit` (`unit`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_lookup`
--

LOCK TABLES `unit_lookup` WRITE;
/*!40000 ALTER TABLE `unit_lookup` DISABLE KEYS */;
INSERT INTO `unit_lookup` VALUES
(6,''),
(4,'bag'),
(5,'lot'),
(7,'None'),
(1,'pc'),
(2,'roll'),
(3,'set');
/*!40000 ALTER TABLE `unit_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_status_lookup`
--

DROP TABLE IF EXISTS `unit_status_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_status_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_status_lookup`
--

LOCK TABLES `unit_status_lookup` WRITE;
/*!40000 ALTER TABLE `unit_status_lookup` DISABLE KEYS */;
INSERT INTO `unit_status_lookup` VALUES
(1,'ONHAND'),
(2,'PREORDER'),
(3,'NA');
/*!40000 ALTER TABLE `unit_status_lookup` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-14 13:12:35
