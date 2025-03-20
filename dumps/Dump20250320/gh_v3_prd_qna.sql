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
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL,
  `obj_cd` varchar(200) NOT NULL,
  `status_cd` varchar(200) NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(2000) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `qna_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `qna_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `qna_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `qna_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `qna_chk_5` CHECK ((`creator_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

LOCK TABLES `qna` WRITE;
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
INSERT INTO `qna` VALUES (1,'',0,0,0,'','','N',73,'2023-11-10 07:10:24.650751',73,'2023-11-10 07:10:24.650751','http://107.108.92.208:4200','Excellent work. Thanks'),(2,'',0,0,0,'','','N',73,'2023-11-10 07:10:51.828685',73,'2023-11-10 07:10:51.828685','http://107.108.92.208:4200','Wow All the details of project in one screen . Great Job'),(3,'',0,0,0,'','','N',92,'2023-12-07 09:56:42.245741',92,'2023-12-07 09:56:42.245741','http://107.108.92.208:4200','Team member completed skillup and marked 100% progress and showing approval is pending. But I (Part lead ) did not  received approval.'),(4,'',0,0,0,'','','N',775,'2023-12-22 09:55:07.217059',775,'2023-12-22 09:55:07.217059','http://107.108.92.208:4200','Add ML Basics, MLOPS, Deep Learning and more such skills to skill list.'),(5,'',0,0,0,'','','N',748,'2024-01-05 08:40:30.632849',748,'2024-01-05 08:40:30.632849','http://107.108.92.208:4200','very usefull !'),(6,'',0,0,0,'','','N',748,'2024-01-05 08:40:52.799907',748,'2024-01-05 08:40:52.799907','http://107.108.92.208:4200','Simple and clean UI. Loved it'),(7,'',0,0,0,'','','N',748,'2024-01-05 08:41:23.362586',748,'2024-01-05 08:41:23.362586','http://107.108.92.208:4200','Fonts & style could be better.'),(8,'',0,0,0,'','','N',748,'2024-01-05 08:42:25.803883',748,'2024-01-05 08:42:25.803883','http://107.108.92.208:4200','can add a demo page feature for new commers.'),(9,'',0,0,0,'','','N',1104,'2024-02-05 15:04:28.013563',1104,'2024-02-05 15:04:28.013563','http://107.108.92.208:4200','Can you please remove my skill - .Net-Core\n\nIt was incorrectly added'),(10,'',0,0,0,'','','N',355,'2024-03-04 12:12:23.404399',355,'2024-03-04 12:12:23.404399','http://107.108.92.208:4200','Today\'s training was very good, got a better understanding about Hashing, Pattern search.'),(11,'',0,0,0,'','','N',1500,'2024-04-12 04:12:45.954855',1500,'2024-04-12 04:12:45.954855','http://107.108.92.208:4200','there should be option to edit skills if added by mistake.'),(12,'',0,0,0,'','','N',344,'2024-04-16 09:05:14.650892',344,'2024-04-16 09:05:14.650892','http://107.108.92.208:4200','- Required confirmation popup for click \"\"Initiate Skill-UP BTN\"\"\n- I did not find to edit or delete for Add Skill'),(13,'',0,0,0,'','','N',356,'2024-05-13 05:04:33.415546',356,'2024-05-13 05:04:33.415546','http://107.108.92.208:4200','Course Completion from learner->beginner completed but it is still showing learner and no initiate skill up icon visible'),(14,'',0,0,0,'','','N',1854,'2024-05-13 08:56:39.535715',1854,'2024-05-13 08:56:39.535715','http://107.108.92.208:4200','Platform can be further be improved by adding more features : \nA separate page containing roadmaps of different technologies and those roadmaps can be added by experts and can be rated by other members to make it more relevant, \n\nWe can use genAI to generate different personalised learning paths based on audio, video , article preference , We can form a small community based Learning platform where experts can be rewarded for their contribution, And their contributions can be validated by other community members. \nThere are further ideas please let me know if any discussions needed for the development, I would be very happy to contribute.'),(15,'',0,0,0,'','','N',1298,'2024-09-04 10:10:09.509618',1298,'2024-09-04 10:10:09.509618','http://107.108.92.208:4200','My current level for \"\"Large Scale Content Services Architecture (core)\"\" is incorrectly mapped to \"\"Beginner\"\" (Level 1). It should be \"\"Intermediate\"\" (Level 2).\nAlso there is no option shown for initiating Skill Up.'),(16,'',0,0,0,'','','N',61,'2024-10-11 09:29:10.554150',61,'2024-10-11 09:29:10.554150','https://growhive.sec.samsung.net','Hi, test'),(17,'',0,0,0,'','','N',8,'2024-12-04 05:02:06.919417',8,'2024-12-04 05:02:06.919417','https://growhive.sec.samsung.net','There is no way to check the at which level Approval is pending.\nName of the Approver is not visible'),(18,'',0,0,0,'','','N',760,'2025-01-14 06:31:52.191423',760,'2025-01-14 06:31:52.191423','https://growhive.sec.samsung.net','confusing interface');
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:02:35
