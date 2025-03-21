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
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(30,'akashtraining','contenttrainingakashmodel'),(48,'articles','articlesmodel'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(42,'badge','sysuserbadgemodel'),(44,'click','memberpostclickmodel'),(5,'contenttypes','contenttype'),(47,'copytraining','contenttrainingcopymodel'),(27,'course','contentcoursemodel'),(12,'domain','domainmodel'),(26,'footprint','userfootprintmodel'),(24,'growthplan','growthplancontentmodel'),(38,'maincontentcourseapprover','contentcourseapprovermodel'),(40,'maincontentprogrammember','contentprogrammembermodel'),(33,'maincontenttrainingfeedback','contenttrainingfeedbackmodel'),(29,'maincontenttrainingmember','contenttrainingmembermodel'),(13,'maindatamgmtdomainskill','domainskillmodel'),(16,'maindatamgmtmemberfavgrowthplan','memberfavgrowthplanmodel'),(15,'maindatamgmtmembergrowthplan','membergrowthplanmodel'),(25,'maindatamgmtmembergrowthplantask','membergrowthplantaskmodel'),(17,'maindatamgmtmembermentor','membermentormodel'),(34,'maindatamgmtmemberprogram','memberprogrammodel'),(35,'maindatamgmtmemberprogramtask','memberprogramtaskmodel'),(14,'maindatamgmtmemberskill','memberskillmodel'),(11,'maindatamgmtprojectjoinrequest','projectjoinrequestmodel'),(10,'maindatamgmtprojectmember','projectmembermodel'),(9,'maindatamgmtprojectskill','projectskillmodel'),(41,'maindatamgmtprojectskillhistory','projectskillhistorymodel'),(37,'maingrowthplancontentmember','growthplancontentmembermodel'),(36,'maingrowthplanmodulecontent','growthplanmodulecontentmodel'),(46,'nominations','nmnsmodel'),(43,'post','datamgmtmemberpostmodel'),(39,'program','contentprogrammodel'),(8,'project','projectmodel'),(32,'qna','datamgmtqnamodel'),(23,'register','userregistrationmodel'),(6,'sessions','session'),(31,'ShivamTraining','contenttrainingshivammodel'),(7,'skill','skillmodel'),(21,'syscode','syscodemodel'),(22,'sysfilter','sysfiltermodel'),(19,'sysupload','sysuplaodmodel'),(20,'sysupload','sysuplaodseqmodel'),(18,'sysuser','sysusermodel'),(45,'tag','memberposttagmodel'),(28,'training','contenttrainingmodel');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:44
