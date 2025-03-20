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
-- Table structure for table `member_post_click`
--

DROP TABLE IF EXISTS `member_post_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_post_click` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `pid` int unsigned NOT NULL,
  `post_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `like_yn` varchar(1) NOT NULL,
  `status_cd` varchar(200) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `member_post_click_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `member_post_click_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `member_post_click_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `member_post_click_chk_4` CHECK ((`pid` >= 0)),
  CONSTRAINT `member_post_click_chk_5` CHECK ((`post_id` >= 0)),
  CONSTRAINT `member_post_click_chk_6` CHECK ((`member_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_post_click`
--

LOCK TABLES `member_post_click` WRITE;
/*!40000 ALTER TABLE `member_post_click` DISABLE KEYS */;
INSERT INTO `member_post_click` VALUES (1,0,'N',61,'2025-02-17 12:59:55.004121',61,'2025-02-17 12:59:55.004121',0,5,61,'Y','','member.post.click'),(2,0,'N',61,'2025-02-17 13:02:48.080789',61,'2025-02-17 13:02:48.080789',0,7,61,'N','','member.post.click'),(3,0,'N',61,'2025-02-17 13:03:08.711069',61,'2025-02-17 13:03:08.711069',0,9,61,'Y','','member.post.click'),(4,0,'N',61,'2025-02-17 13:03:37.401396',61,'2025-02-17 13:03:37.401396',0,9,61,'N','','member.post.click'),(5,0,'N',61,'2025-02-25 05:45:37.517767',61,'2025-02-25 05:45:37.517767',0,11,61,'N','','member.post.click'),(6,0,'N',61,'2025-02-25 05:45:41.176904',61,'2025-02-25 05:45:41.176904',0,9,61,'Y','','member.post.click'),(7,0,'N',61,'2025-02-25 10:56:25.368759',61,'2025-02-25 10:56:25.368759',0,14,61,'Y','','member.post.click'),(8,0,'N',61,'2025-02-25 10:56:28.039662',61,'2025-02-25 10:56:28.039662',0,14,61,'N','','member.post.click'),(9,0,'N',61,'2025-02-25 10:56:29.627459',61,'2025-02-25 10:56:29.627459',0,13,61,'Y','','member.post.click'),(10,0,'N',61,'2025-02-25 10:56:30.825848',61,'2025-02-25 10:56:30.825848',0,14,61,'Y','','member.post.click'),(11,0,'N',61,'2025-02-27 10:03:36.600594',61,'2025-02-27 10:03:36.600594',0,13,61,'N','','member.post.click'),(12,0,'N',61,'2025-02-27 10:03:38.349789',61,'2025-02-27 10:03:38.349789',0,11,61,'Y','','member.post.click');
/*!40000 ALTER TABLE `member_post_click` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:02:32
