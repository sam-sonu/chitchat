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
-- Table structure for table `content_trainingcopy`
--

DROP TABLE IF EXISTS `content_trainingcopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_trainingcopy` (
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `trainer_id` int unsigned NOT NULL,
  `ref_link` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `project_id` varchar(200) NOT NULL,
  `event_dt` datetime(6) NOT NULL,
  `event_type_cd` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `user_id_arr` varchar(5000) NOT NULL,
  `status_cd` varchar(200) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `start_time` varchar(50) NOT NULL,
  `end_time` varchar(50) NOT NULL,
  `feedback_show_yn` varchar(1) NOT NULL,
  `external_survey_url` varchar(200) NOT NULL,
  `external_survey_yn` varchar(1) NOT NULL,
  `trainer_id_arr` varchar(5000) NOT NULL,
  `show_yn` varchar(1) NOT NULL,
  `program_id` int unsigned NOT NULL,
  `module_id` int unsigned NOT NULL,
  `co_author_id_arr` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `content_trainingcopy_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_6` CHECK ((`trainer_id` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_7` CHECK ((`skill_id` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_8` CHECK ((`program_id` >= 0)),
  CONSTRAINT `content_trainingcopy_chk_9` CHECK ((`module_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_trainingcopy`
--

LOCK TABLES `content_trainingcopy` WRITE;
/*!40000 ALTER TABLE `content_trainingcopy` DISABLE KEYS */;
INSERT INTO `content_trainingcopy` VALUES ('',0,0,0,'N',61,'2023-11-10 03:41:47.852969',61,'2023-11-10 03:41:47.852969',1,'Add new node group and switching existing service to newly created node group in Kubernetes',61,'','<p>Add new node group and switching existing service to newly created node group in Kubernetes</p>',219,'skill.level.intermediate','','58','2023-11-02 00:00:00.000000','training.event.type.online','https://meeting.samsung.net/@/enter/false/6719','','status.complete','content.training','15:11','16:11','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 03:43:37.894112',61,'2023-11-10 03:43:37.894112',2,'Table Clone and Table Snapshot in BigQuery GCP',61,'','<p>Table Clone and Table Snapshot in BigQuery GCP</p>',219,'skill.level.intermediate','','58','2023-10-02 00:00:00.000000','training.event.type.online','https://code.sec.samsung.net/confluence/pages/viewpage.action?pageId=423025279','','status.complete','content.training','15:13','16:13','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 03:46:30.226313',61,'2023-11-10 03:46:30.226313',3,'Gurukul -2: AWS Network Security',61,'','<p>AWS network Security VPC, Subnets, Inbound, Outbound, Security Groups, Route Table, NAT</p><p><br>&nbsp;</p>',1075,'skill.level.intermediate','','8','2023-10-05 00:00:00.000000','training.event.type.online','https://code.sec.samsung.net/confluence/download/attachments/437055689/Network%20Security%20-%20CSP%20.pptx?version=1&modificationDate=1695787828000&api=v2','','status.complete','content.training','15:16','16:16','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 03:49:18.129911',61,'2023-11-10 03:49:18.129911',4,'Gurukul -1: Unlocking Innovation through Patent',61,'','<p>Training to provide details on patent process, ideation and innovation examples</p><p><br>&nbsp;</p>',1067,'skill.level.intermediate','','8','2023-10-10 00:00:00.000000','training.event.type.online','https://code.sec.samsung.net/confluence/pages/viewpage.action?pageId=437055689','','status.complete','content.training','15:18','16:18','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 03:51:20.021286',61,'2023-11-10 03:51:20.021286',5,'Automation - Data Comparison in Big Query',61,'','<p>Automation - Data Comparison in Big Query</p>',219,'skill.level.intermediate','','58','2023-08-10 00:00:00.000000','training.event.type.online','https://code.sec.samsung.net/jira/browse/ABAP-1548','','status.complete','content.training','15:20','16:20','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 03:52:48.568680',61,'2023-11-10 03:52:48.568680',6,'Adding Secrets/Credentials to Kubernetes',61,'','<p>Adding Secrets/Credentials to Kubernetes and Configuring Secrets in container</p><p><br>&nbsp;</p>',75,'skill.level.intermediate','','58','2023-08-02 00:00:00.000000','training.event.type.online','https://code.sec.samsung.net/jira/browse/ABAP-1249','','status.complete','content.training','15:22','16:22','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 03:54:47.257812',61,'2023-11-10 03:54:47.257812',7,'Looker & LookML Training',61,'','<p>Looker &amp; LookML Training</p><ol><li>How to use Looker and Looker Studio to turns your data into fully customizable informative reports and dashboards</li><li>Learn why businesses should use Looker to explore their data</li><li>How to visualize data using popular chart types in Looker and Looker Studio</li><li>Filter and sort data to find the right answer for your business questions</li><li>Sharing and collaborating on Looker studio reports</li><li>Branding a report - Adding Logo and setting theme</li><li>How to share and schedule charts and dashboards with team mates</li></ol>',219,'skill.level.intermediate','','58','2023-11-10 00:00:00.000000','training.event.type.online','http://wiki.vd.sec.samsung.net/download/attachments/167523261/UnderstandingLooker.pptx?version=1&modificationDate=1693301015678&api=v2','','status.complete','content.training','15:24','16:24','N','','N','','Y',0,0,''),('',0,0,0,'N',61,'2023-11-10 04:29:43.720008',61,'2023-11-10 04:29:43.720008',8,'Looker and Looker Studio: Google\'s Data Visualization Tools',741,'','<ol><li>How to use Looker and Looker Studio to turns your data into fully customizable informative reports and dashboards</li><li>Learn why businesses should use Looker to explore their data</li><li>How to visualize data using popular chart types in Looker and Looker Studio</li><li>Filter and sort data to find the right answer for your business questions</li><li>Sharing and collaborating on Looker studio reports</li><li>Branding a report - Adding Logo and setting theme</li><li>How to share and schedule charts and dashboards with team mates</li></ol>',219,'skill.level.beginner','skill.level.intermediate','1','2023-11-10 00:00:00.000000','training.event.type.offline','1B Kaveri','','status.draft','content.training','15:59','16:59','Y','','N','','Y',0,0,''),('',0,0,0,'N',0,'2023-11-10 07:01:17.737825',73,'2023-11-10 07:01:17.738822',9,'Partitioning and Clustering in BiG query',73,'','<p>Explanation of advantages</p>',218,'skill.level.advance','skill.level.expert','276','2023-11-10 00:00:00.000000','training.event.type.online','1A Yamuna','jeetinder.s@samsung.com','status.complete','content.training','13:30','14:30','Y','','N','','Y',0,0,''),('',0,0,0,'N',0,'2023-11-15 06:43:49.871368',124,'2023-11-15 06:43:49.886989',10,'Gurukul Session -3 Basics of Machine Learning',124,'','<p>Basics of Machine Learnings</p><p>&nbsp;</p><p>https://meeting.samsung.net/@/enter/false/6560804&nbsp;</p>',14,'skill.level.beginner','skill.level.intermediate','8','2023-10-10 00:00:00.000000','training.event.type.online','1B Kiosk','','status.complete','content.training','15:00','16:05','Y','','N','','Y',0,0,''),('',0,8,0,'N',61,'2025-01-07 11:08:14.778108',61,'2025-01-07 11:08:14.778108',11,'python',61,'','demo',0,'skill.level.expert','skill.level.master','276','2025-01-07 00:00:00.000000','training.event.type.online','noida','','status.complete','content.training','4:09','5:56','Y','','N','','Y',54,55,''),('',0,11,0,'N',61,'2025-01-10 03:57:16.593629',61,'2025-01-10 03:57:16.593629',12,'Demo Training',61,'mull-link','Demo des',0,'skill.level.expert','skill.level.master','8','2025-01-10 00:00:00.000000','training.event.type.online','noida','sonu.km, demo.km','status.complete','content.training','4:09','5:56','Y','','N','x,y,z','Y',54,55,'Jeet sir'),('',0,11,0,'N',61,'2025-01-10 03:57:25.553764',61,'2025-01-10 03:57:25.553764',13,'Demo Training',61,'mull-link','Demo des',0,'skill.level.expert','skill.level.master','8','2025-01-10 00:00:00.000000','training.event.type.online','noida','sonu.km, demo.km','status.draft','content.training','4:09','5:56','Y','null-link','N','x,y,z','Y',54,55,'Jeet sir');
/*!40000 ALTER TABLE `content_trainingcopy` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:17
