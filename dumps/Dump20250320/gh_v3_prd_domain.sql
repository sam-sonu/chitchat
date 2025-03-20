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
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domain` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `status_cd` varchar(200) NOT NULL DEFAULT 'new',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'domain',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain`
--

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` VALUES (1,'Ad Operations','ad.operations',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(2,'AI/ML','ai.ml',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(3,'Cloud','cloud',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(4,'Coding','coding',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(5,'Connectivity','connectivity',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(6,'Content Engineering','content.engineering',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(7,'Database','database',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(8,'Debugging','debugging',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(9,'DevOps (CI/CD)','devops.ci.cd.',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(10,'DSP','dsp',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(11,'Framework/Library','framework.library',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(12,'Innovation','innovation',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(13,'Management','management',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(14,'Mobile Application','mobile.application',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(15,'Multimedia','multimedia',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(16,'Networking & Connectivity','networking.connectivity',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(17,'Platform Security','platform.security',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(18,'Product Knowledge','product.knowledge',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(19,'Product Management','product.management',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(20,'QA','qa',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(21,'SDK','sdk',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(22,'SE','se',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(23,'SoC / RTL','soc.rtl',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(24,'Software Architecture','software.architecture',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(25,'Tizen Application','tizen.application',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(26,'Tizen Middleware','tizen.middleware',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(27,'Tizen Platform','tizen.platform',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(28,'TizenRT','tizenrt',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(29,'Tools','tools',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(30,'TV Standardization','tv.standardization',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(31,'UX Design','ux.design',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(32,'Web','web',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(64,'Talent Management ','talent.management',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(65,'Workplace solutions','workplace.solutions',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(66,'Operations','operations',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(67,'DTV Standardization','dtv.standardization',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(68,'Pay TV','pay.tv',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain'),(69,'Patents / IP','patents.ip',0,0,0,'new','N',0,'2023-11-08 09:51:20',0,'2023-11-08 09:51:20','domain');
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:02:17
