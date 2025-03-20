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
-- Table structure for table `content_course_approver`
--

DROP TABLE IF EXISTS `content_course_approver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_course_approver` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `course_id` int unsigned NOT NULL,
  `approver_id` int unsigned NOT NULL,
  `status_cd` varchar(50) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `content_course_approver_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_course_approver_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_course_approver_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_course_approver_chk_4` CHECK ((`course_id` >= 0)),
  CONSTRAINT `content_course_approver_chk_5` CHECK ((`approver_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_course_approver`
--

LOCK TABLES `content_course_approver` WRITE;
/*!40000 ALTER TABLE `content_course_approver` DISABLE KEYS */;
INSERT INTO `content_course_approver` VALUES (1,0,'Y',0,'2024-03-04 10:54:37.005802',61,'2024-03-04 10:54:37.005802',3397,747,'status.draft','course.approver'),(2,0,'Y',0,'2024-03-04 11:03:09.805826',61,'2024-03-04 11:03:09.805826',3397,747,'status.draft','course.approver');
/*!40000 ALTER TABLE `content_course_approver` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:41
