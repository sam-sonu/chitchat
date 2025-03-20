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
-- Table structure for table `sys_upload`
--

DROP TABLE IF EXISTS `sys_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_upload` (
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
  `filename` varchar(200) DEFAULT NULL,
  `cloud_yn` varchar(1) DEFAULT NULL,
  `basepath` varchar(300) DEFAULT NULL,
  `filesize` int unsigned NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `file_ext` varchar(20) NOT NULL,
  `filepath` varchar(300) NOT NULL,
  `mime_type` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_upload`
--

LOCK TABLES `sys_upload` WRITE;
/*!40000 ALTER TABLE `sys_upload` DISABLE KEYS */;
INSERT INTO `sys_upload` VALUES (1,'myfile.txt','',1,1,0,'','N',0,'2023-11-02 08:48:30.781302',0,'2023-11-02 08:48:30.781302','myfile.txt','N','D:GrowHiveV2growhivemediaupload20231102',30601,'sysupload','.txt','D:GrowHiveV2growhivemediaupload20231102myfile.txt','text/plain'),(2,'myfile.xls','',2,2,0,'','N',0,'2023-11-02 08:52:04.674546',0,'2023-11-02 08:52:04.674546','myfile.xls','N','D:GrowHiveV2growhivemediaupload20231102',30601,'sysupload','.xls','D:GrowHiveV2growhivemediaupload20231102myfile.xls','application/vnd.ms-excel'),(3,'myfile.xlsx','',3,3,0,'','N',0,'2023-11-02 08:55:16.599563',0,'2023-11-02 08:55:16.599563','myfile.xlsx','N','D:GrowHiveV2growhivemediaupload20231102',30601,'sysupload','.xlsx','D:GrowHiveV2growhivemediaupload20231102myfile.xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),(4,'myfile.xlsx','',4,4,0,'','N',0,'2023-11-02 08:55:46.263761',0,'2023-11-02 08:55:46.263761','myfile.xlsx','N','D:GrowHiveV2growhivemediaupload20231102',30602,'sysupload','.xlsx','D:GrowHiveV2growhivemediaupload20231102myfile.xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),(5,'myfile.xlsx','',5,5,0,'','N',0,'2023-11-02 08:55:51.955330',0,'2023-11-02 08:55:51.956329','myfile.xlsx','N','D:GrowHiveV2growhivemediaupload20231102',30602,'sysupload','.xlsx','D:GrowHiveV2growhivemediaupload20231102myfile.xlsx','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
/*!40000 ALTER TABLE `sys_upload` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:30
