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
-- Table structure for table `member_program`
--

DROP TABLE IF EXISTS `member_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_program` (
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
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level_cd` varchar(30) NOT NULL,
  `current_level` int unsigned NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `target_level` int unsigned NOT NULL,
  `taskplan_id` varchar(200) NOT NULL,
  `jira_link` varchar(200) NOT NULL,
  `progress_step` int unsigned NOT NULL,
  `request_approver_id` int unsigned NOT NULL,
  `complete_approver_id` int unsigned NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `member_program_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `member_program_chk_10` CHECK ((`progress_step` >= 0)),
  CONSTRAINT `member_program_chk_11` CHECK ((`request_approver_id` >= 0)),
  CONSTRAINT `member_program_chk_12` CHECK ((`complete_approver_id` >= 0)),
  CONSTRAINT `member_program_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `member_program_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `member_program_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `member_program_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `member_program_chk_6` CHECK ((`member_id` >= 0)),
  CONSTRAINT `member_program_chk_7` CHECK ((`skill_id` >= 0)),
  CONSTRAINT `member_program_chk_8` CHECK ((`current_level` >= 0)),
  CONSTRAINT `member_program_chk_9` CHECK ((`target_level` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_program`
--

LOCK TABLES `member_program` WRITE;
/*!40000 ALTER TABLE `member_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_program` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:00
