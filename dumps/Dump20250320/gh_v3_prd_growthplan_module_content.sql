-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 107.109.40.131    Database: gh_v3_prd
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
-- Table structure for table `growthplan_module_content`
--

DROP TABLE IF EXISTS `growthplan_module_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `growthplan_module_content` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL,
  `status_cd` varchar(200) NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `growthplan_content_id` int unsigned NOT NULL,
  `module_name` varchar(100) NOT NULL,
  `content` varchar(200) NOT NULL,
  `duration` varchar(30) NOT NULL,
  `weightage` int unsigned NOT NULL,
  `approval_yn` varchar(1) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `training_id` int unsigned NOT NULL,
  `training_yn` varchar(1) NOT NULL,
  `approver_id` int unsigned NOT NULL,
  `module_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `growthplan_module_content_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_6` CHECK ((`growthplan_content_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_7` CHECK ((`weightage` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_8` CHECK ((`training_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_9` CHECK ((`approver_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `growthplan_module_content`
--

LOCK TABLES `growthplan_module_content` WRITE;
/*!40000 ALTER TABLE `growthplan_module_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `growthplan_module_content` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:16
