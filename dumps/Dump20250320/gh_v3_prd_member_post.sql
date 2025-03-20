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
-- Table structure for table `member_post`
--

DROP TABLE IF EXISTS `member_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
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
  `title` varchar(500) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `obj_cd` varchar(200) NOT NULL,
  `post_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `member_post_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `member_post_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `member_post_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `member_post_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `member_post_chk_5` CHECK ((`creator_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_post`
--

LOCK TABLES `member_post` WRITE;
/*!40000 ALTER TABLE `member_post` DISABLE KEYS */;
INSERT INTO `member_post` VALUES (1,'',0,0,0,'','N',61,'2025-02-13 05:38:40.249557',61,'2025-02-13 05:38:40.249557','Demo Post1','','member.post',''),(2,'',1,0,0,'','N',61,'2025-02-13 05:41:04.581440',61,'2025-02-13 05:41:04.581440','demo ans','','member.post',''),(3,'',1,0,0,'','N',61,'2025-02-13 05:43:09.861001',61,'2025-02-13 05:43:09.861001','ans2','','member.post',''),(4,'',0,0,0,'','N',61,'2025-02-14 10:52:33.284767',61,'2025-02-14 10:52:33.284767','Strengthening evidence for refugee self-reliance programming (Simar Singh, September 2024)  read more','','member.post',''),(5,'',0,0,0,'','N',61,'2025-02-17 05:35:50.325897',61,'2025-02-17 05:35:50.325897','Demo test','Added Description for Test data','member.post',''),(6,'',4,0,0,'','N',61,'2025-02-17 05:38:59.842204',61,'2025-02-17 05:38:59.842204','test ans','test sns','member.post',''),(7,'',0,0,0,'','N',61,'2025-02-17 11:00:52.440526',61,'2025-02-17 11:00:52.440526','Added post with if check','','member.post',''),(8,'',7,0,0,'','N',61,'2025-02-17 11:02:16.757243',61,'2025-02-17 11:02:16.757243','ans without desc','','member.post',''),(9,'',0,0,0,'','N',61,'2025-02-17 11:19:02.060899',61,'2025-02-17 11:19:02.060899','all set ??','All Ok , Tested!','member.post',''),(10,'',9,0,0,'','N',61,'2025-02-17 11:19:23.924132',61,'2025-02-17 11:19:23.924132','All check all set!','','member.post',''),(11,'',0,0,0,'','N',61,'2025-02-18 09:23:15.379744',61,'2025-02-18 09:23:15.379744','demo','ddd','member.post',''),(12,'',11,0,0,'','N',61,'2025-02-18 09:26:06.656468',61,'2025-02-18 09:26:06.656468','demo ans','','member.post',''),(13,'',0,0,0,'','N',61,'2025-02-25 10:36:50.893875',61,'2025-02-25 10:36:50.893875','Demo5','post type test via manual entry','member.post','Article'),(14,'',0,0,0,'','N',61,'2025-02-25 10:54:27.568850',61,'2025-02-25 10:54:27.568850','Static post','Demo Des','member.post','staticPost'),(15,'',0,0,0,'','N',61,'2025-02-25 10:56:42.687936',61,'2025-02-25 10:56:42.687936','qqq','dd','member.post','staticPost');
/*!40000 ALTER TABLE `member_post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:02:08
