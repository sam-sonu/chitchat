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
-- Table structure for table `member_growthplan_task`
--

DROP TABLE IF EXISTS `member_growthplan_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_growthplan_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `version` varchar(10) DEFAULT '0',
  `progress_step` int unsigned NOT NULL DEFAULT '0',
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.todo',
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.growthplan.task',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_growthplan_task`
--

LOCK TABLES `member_growthplan_task` WRITE;
/*!40000 ALTER TABLE `member_growthplan_task` DISABLE KEYS */;
INSERT INTO `member_growthplan_task` VALUES (1,'Comfortable with Advanced Python Syntax (List - Dictionary Comprehensions with Conditions)','comfortable.with.advanced.python.syntax.list.dictionary.comprehensions.with.conditions.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(2,'Comfortable with Advanced Python Syntax (List - Dictionary Comprehensions with Conditions)','comfortable.with.advanced.python.syntax.list.dictionary.comprehensions.with.conditions.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(3,'Comfortable with Advanced Python Syntax (List - Dictionary Comprehensions with Conditions)','comfortable.with.advanced.python.syntax.list.dictionary.comprehensions.with.conditions.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(4,'Comfortable with Advanced Python Syntax (List - Dictionary Comprehensions with Conditions)','comfortable.with.advanced.python.syntax.list.dictionary.comprehensions.with.conditions.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(5,'Comfortable with Advanced Python Syntax (List - Dictionary Comprehensions with Conditions)','comfortable.with.advanced.python.syntax.list.dictionary.comprehensions.with.conditions.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(6,'Comfortable with Advanced Python Syntax (List - Dictionary Comprehensions with Conditions)','comfortable.with.advanced.python.syntax.list.dictionary.comprehensions.with.conditions.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(7,'Comfortable Writing Algorithms like BFS, DFS, Backtracking etc.','comfortable.writing.algorithms.like.bfs.dfs.backtracking.etc.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(8,'Knowledge of OOPS and Magic Methods in Python. Ability to create Custom Classes and use Objects.','knowledge.of.oops.and.magic.methods.in.python..ability.to.create.custom.classes.and.use.objects.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(9,'Knowledge of In-built Python libraries and their functions like itertools, Collections, os etc.','knowledge.of.in.built.python.libraries.and.their.functions.like.itertools.collections.os.etc.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(10,'Knowledge of In-built Python libraries and their functions like itertools, Collections, os etc.','knowledge.of.in.built.python.libraries.and.their.functions.like.itertools.collections.os.etc.',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task'),(11,'Reading Materials & Topics','reading.materials.topics',659,0,0,'N',61,'2023-09-30 09:37:47',61,'2023-09-30 09:37:47','growthplan.content.type.reading','','','',0,'status.todo','member.growthplan.task');
/*!40000 ALTER TABLE `member_growthplan_task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 17:01:55
