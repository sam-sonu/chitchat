CREATE DATABASE  IF NOT EXISTS `gh_v3_prd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gh_v3_prd`;
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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
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
  `obj_title` varchar(50) NOT NULL,
  `obj_content` longtext NOT NULL,
  `articles_spotlight_yn` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `articles_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `articles_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `articles_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `articles_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `articles_chk_5` CHECK ((`creator_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_course`
--

DROP TABLE IF EXISTS `content_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL DEFAULT ' ',
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(300) NOT NULL,
  `skill_id` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) DEFAULT NULL,
  `description` longtext,
  `draft_description` longtext,
  `author_id` int unsigned DEFAULT '0',
  `version` varchar(10) NOT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.draft',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'content.course',
  PRIMARY KEY (`id`),
  CONSTRAINT `content_course_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `content_course_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `content_course_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_course_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_course_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_course_chk_6` CHECK ((`author_id` >= 0)),
  CONSTRAINT `content_course_chk_7` CHECK ((`skill_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `content_course_backup_8thjuly`
--

DROP TABLE IF EXISTS `content_course_backup_8thjuly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_course_backup_8thjuly` (
  `id` bigint NOT NULL DEFAULT '0',
  `code` varchar(100) NOT NULL DEFAULT ' ',
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(300) NOT NULL,
  `skill_id` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) DEFAULT NULL,
  `description` longtext,
  `draft_description` longtext,
  `author_id` int unsigned DEFAULT '0',
  `version` varchar(10) NOT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.draft',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'content.course'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_course_test`
--

DROP TABLE IF EXISTS `content_course_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_course_test` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL DEFAULT ' ',
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(300) NOT NULL,
  `skill_id` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) DEFAULT NULL,
  `description` longtext,
  `draft_description` longtext,
  `author_id` int unsigned DEFAULT '0',
  `version` varchar(10) NOT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.draft',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'content.course',
  PRIMARY KEY (`id`),
  CONSTRAINT `content_course_test_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `content_course_test_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `content_course_test_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_course_test_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_course_test_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_course_test_chk_6` CHECK ((`author_id` >= 0)),
  CONSTRAINT `content_course_test_chk_7` CHECK ((`skill_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_program`
--

DROP TABLE IF EXISTS `content_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_program` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `title` varchar(300) NOT NULL,
  `author_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `draft_description` longtext NOT NULL,
  `project_id_arr` varchar(200) NOT NULL,
  `member_id_arr` varchar(5000) NOT NULL,
  `approver_id_arr` varchar(200) NOT NULL,
  `contributor_id_arr` varchar(200) NOT NULL,
  `version` varchar(10) NOT NULL,
  `show_yn` varchar(1) NOT NULL,
  `status_cd` varchar(200) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `weightage` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `content_program_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `content_program_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `content_program_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_program_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_program_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_program_chk_6` CHECK ((`author_id` >= 0)),
  CONSTRAINT `content_program_chk_7` CHECK ((`skill_id` >= 0)),
  CONSTRAINT `content_program_chk_9` CHECK ((`weightage` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_program_member`
--

DROP TABLE IF EXISTS `content_program_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_program_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `program_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `task_id` int unsigned NOT NULL,
  `role_cd` varchar(50) NOT NULL,
  `member_attended_yn` varchar(1) NOT NULL,
  `jira_link` varchar(300) NOT NULL,
  `rating_cd` varchar(50) NOT NULL,
  `feedback` varchar(1000) NOT NULL,
  `status_cd` varchar(50) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `certification_yn` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `content_program_member_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_program_member_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_program_member_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_program_member_chk_4` CHECK ((`program_id` >= 0)),
  CONSTRAINT `content_program_member_chk_5` CHECK ((`member_id` >= 0)),
  CONSTRAINT `content_program_member_chk_6` CHECK ((`task_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6549 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_program_member_backup_24may`
--

DROP TABLE IF EXISTS `content_program_member_backup_24may`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_program_member_backup_24may` (
  `id` bigint NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `program_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `task_id` int unsigned NOT NULL,
  `role_cd` varchar(50) NOT NULL,
  `member_attended_yn` varchar(1) NOT NULL,
  `jira_link` varchar(300) NOT NULL,
  `rating_cd` varchar(50) NOT NULL,
  `feedback` varchar(1000) NOT NULL,
  `status_cd` varchar(50) NOT NULL,
  `obj_cd` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_training`
--

DROP TABLE IF EXISTS `content_training`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_training` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `title` varchar(300) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `ref_link` varchar(200) NOT NULL,
  `trainer_id` int unsigned NOT NULL DEFAULT '0',
  `project_id` varchar(200) NOT NULL,
  `event_dt` datetime(6) DEFAULT NULL,
  `event_type_cd` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `skill_id` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) DEFAULT NULL,
  `user_id_arr` varchar(5000) DEFAULT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.draft',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime(6) NOT NULL,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'content.training',
  `end_time` varchar(50) NOT NULL DEFAULT '00:00',
  `start_time` varchar(50) NOT NULL DEFAULT '00:00',
  `description` longtext,
  `external_survey_yn` varchar(1) NOT NULL,
  `external_survey_url` varchar(200) NOT NULL,
  `trainer_id_arr` varchar(5000) NOT NULL,
  `show_yn` varchar(1) NOT NULL,
  `module_id` int unsigned NOT NULL,
  `program_id` int unsigned NOT NULL,
  `co_author_id_arr` varchar(1000) DEFAULT '',
  `feedback_show_yn` varchar(1) NOT NULL,
  `nomination_yn` varchar(1) NOT NULL,
  `mandatory_yn` varchar(1) NOT NULL,
  `training_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `content_training_chk_1` CHECK ((`module_id` >= 0)),
  CONSTRAINT `content_training_chk_2` CHECK ((`program_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_training_feedback`
--

DROP TABLE IF EXISTS `content_training_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_training_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `training_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `question_cd` varchar(50) NOT NULL,
  `rating_cd` varchar(50) NOT NULL,
  `feedback` varchar(1000) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `content_training_feedback_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `content_training_feedback_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `content_training_feedback_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `content_training_feedback_chk_4` CHECK ((`training_id` >= 0)),
  CONSTRAINT `content_training_feedback_chk_5` CHECK ((`member_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=33623 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content_training_member`
--

DROP TABLE IF EXISTS `content_training_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_training_member` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `training_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `role_cd` varchar(50) NOT NULL DEFAULT 'training.role.attendee',
  `feedback` varchar(1000) NOT NULL,
  `rating` int NOT NULL DEFAULT '0',
  `user_attended_yn` varchar(1) NOT NULL DEFAULT 'N',
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.approval.request',
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime(6) NOT NULL,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'training.member',
  `rating_cd` varchar(50) NOT NULL,
  `nominated_yn` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30615 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `domain_skill`
--

DROP TABLE IF EXISTS `domain_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `domain_skill` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `skill_id` int unsigned NOT NULL,
  `domain_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'domain.skill',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=635 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `growthplan_content`
--

DROP TABLE IF EXISTS `growthplan_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `growthplan_content` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `author_id` int unsigned NOT NULL DEFAULT '0',
  `skill_id` int unsigned NOT NULL,
  `current_level_cd` varchar(30) NOT NULL,
  `target_level_cd` varchar(30) NOT NULL,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.draft',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'growthplan.content',
  `recommendation_yn` varchar(1) NOT NULL,
  `contributor_id_arr` varchar(100) NOT NULL,
  `owner_id` varchar(500) NOT NULL,
  `draft_description` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `growthplan_content_member`
--

DROP TABLE IF EXISTS `growthplan_content_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `growthplan_content_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `growthplan_content_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `role_cd` varchar(50) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `jira_link` varchar(300) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `growthplan_content_member_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `growthplan_content_member_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `growthplan_content_member_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `growthplan_content_member_chk_4` CHECK ((`growthplan_content_id` >= 0)),
  CONSTRAINT `growthplan_content_member_chk_5` CHECK ((`member_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `growthplan_module_content`
--

DROP TABLE IF EXISTS `growthplan_module_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `growthplan_module_content` (
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
  `growthplan_content_id` int unsigned NOT NULL,
  `module_name` varchar(100) NOT NULL,
  `content` varchar(200) NOT NULL,
  `duration` varchar(30) NOT NULL,
  `weightage` int unsigned NOT NULL,
  `approval_yn` varchar(1) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `training_id` int unsigned NOT NULL,
  `training_yn` varchar(1) NOT NULL,
  `approver_id` int unsigned NOT NULL,
  `module_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `growthplan_module_content_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_6` CHECK ((`growthplan_content_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_7` CHECK ((`weightage` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_8` CHECK ((`training_id` >= 0)),
  CONSTRAINT `growthplan_module_content_chk_9` CHECK ((`approver_id` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_fav_growthplan`
--

DROP TABLE IF EXISTS `member_fav_growthplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_fav_growthplan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `growthplan_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.fav.growthplan',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_growthplan`
--

DROP TABLE IF EXISTS `member_growthplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_growthplan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level_cd` varchar(30) NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `target_level_cd` varchar(30) NOT NULL,
  `target_level` int unsigned NOT NULL DEFAULT '0',
  `taskplan_id` varchar(200) DEFAULT '0',
  `jira_link` varchar(200) DEFAULT NULL,
  `progress_step` int unsigned NOT NULL DEFAULT '0',
  `complete_approver_id` int unsigned DEFAULT '0',
  `request_approver_id` int unsigned DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `status_cd` varchar(200) NOT NULL DEFAULT 'growthplan.start.approval.request',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.growthplan',
  `acheivement_yn` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5689 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `member_mentor`
--

DROP TABLE IF EXISTS `member_mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_mentor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `mentor_id` int unsigned NOT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'status.approval.request',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.mentor',
  `skill_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `member_post_tag`
--

DROP TABLE IF EXISTS `member_post_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_post_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `pid` int unsigned NOT NULL,
  `post_id` int unsigned NOT NULL,
  `tag_cd` varchar(100) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `member_post_tag_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `member_post_tag_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `member_post_tag_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `member_post_tag_chk_4` CHECK ((`pid` >= 0)),
  CONSTRAINT `member_post_tag_chk_5` CHECK ((`post_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `member_program_task`
--

DROP TABLE IF EXISTS `member_program_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_program_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL,
  `parent_id` int unsigned NOT NULL,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `content_type_cd` varchar(200) NOT NULL,
  `ref_link` varchar(200) NOT NULL,
  `description` varchar(500) NOT NULL,
  `version` varchar(10) NOT NULL,
  `progress_step` int unsigned NOT NULL,
  `status_cd` varchar(200) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `member_program_task_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `member_program_task_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `member_program_task_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `member_program_task_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `member_program_task_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `member_program_task_chk_6` CHECK ((`progress_step` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill`
--

DROP TABLE IF EXISTS `member_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12519 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_april_2024`
--

DROP TABLE IF EXISTS `member_skill_april_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_april_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_august_2024`
--

DROP TABLE IF EXISTS `member_skill_august_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_august_2024` (
  `id` bigint NOT NULL DEFAULT '0',
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_backup_24may`
--

DROP TABLE IF EXISTS `member_skill_backup_24may`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_backup_24may` (
  `id` bigint NOT NULL DEFAULT '0',
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_july_2024`
--

DROP TABLE IF EXISTS `member_skill_july_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_july_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11739 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_june_2024`
--

DROP TABLE IF EXISTS `member_skill_june_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_june_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11589 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_march_2024`
--

DROP TABLE IF EXISTS `member_skill_march_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_march_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_may_2024`
--

DROP TABLE IF EXISTS `member_skill_may_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_may_2024` (
  `id` bigint NOT NULL DEFAULT '0',
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_november_2024`
--

DROP TABLE IF EXISTS `member_skill_november_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_november_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12399 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_october_2024`
--

DROP TABLE IF EXISTS `member_skill_october_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_october_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12317 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_september_2024`
--

DROP TABLE IF EXISTS `member_skill_september_2024`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_september_2024` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_skill_temp_backup`
--

DROP TABLE IF EXISTS `member_skill_temp_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_skill_temp_backup` (
  `id` bigint NOT NULL DEFAULT '0',
  `member_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level` int unsigned NOT NULL DEFAULT '0',
  `current_level_cd` varchar(30) NOT NULL DEFAULT 'skill.level.beginner',
  `growthplan_id` int DEFAULT '0',
  `addskill_request_id` int DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'member.skill',
  `status_cd` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nominations`
--

DROP TABLE IF EXISTS `nominations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nominations` (
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
  `obj_cd` varchar(50) NOT NULL,
  `core_skill_yn` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `nominations_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `nominations_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `nominations_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `nominations_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `nominations_chk_5` CHECK ((`creator_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `project_level` varchar(50) DEFAULT 'project',
  `plm_cd` varchar(100) DEFAULT NULL,
  `adp` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `status_cd` varchar(200) NOT NULL DEFAULT 'new',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'project',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=394 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_join_request`
--

DROP TABLE IF EXISTS `project_join_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_join_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `requester_id` int unsigned NOT NULL,
  `role_cd` varchar(50) DEFAULT 'project.role.engg',
  `status_cd` varchar(200) NOT NULL DEFAULT 'project.join.approval.request',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'project.joinrequest',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_member`
--

DROP TABLE IF EXISTS `project_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` int unsigned NOT NULL,
  `member_id` int unsigned NOT NULL,
  `role_cd` varchar(50) DEFAULT 'project.role.engg',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'project.member',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2718 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_skill`
--

DROP TABLE IF EXISTS `project_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_skill` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` int unsigned NOT NULL DEFAULT '0',
  `skill_id` int unsigned NOT NULL,
  `critical_skill_yn` varchar(1) NOT NULL DEFAULT 'N',
  `member_required_count` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `obj_cd` varchar(50) NOT NULL DEFAULT 'project.skill',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `core_skill_yn` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7061 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_skill_history`
--

DROP TABLE IF EXISTS `project_skill_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_skill_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sno` int unsigned NOT NULL,
  `obj_cd` varchar(200) NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  `project_id` int unsigned NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `learner_count` int unsigned NOT NULL,
  `beginner_count` int unsigned NOT NULL,
  `intermediate_count` int unsigned NOT NULL,
  `advance_count` int unsigned NOT NULL,
  `expert_count` int unsigned NOT NULL,
  `master_count` int unsigned NOT NULL,
  `yyyy_mm` varchar(7) NOT NULL,
  `project_member_count` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `project_skill_history_chk_1` CHECK ((`sno` >= 0)),
  CONSTRAINT `project_skill_history_chk_10` CHECK ((`expert_count` >= 0)),
  CONSTRAINT `project_skill_history_chk_11` CHECK ((`master_count` >= 0)),
  CONSTRAINT `project_skill_history_chk_12` CHECK ((`project_member_count` >= 0)),
  CONSTRAINT `project_skill_history_chk_2` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `project_skill_history_chk_3` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `project_skill_history_chk_4` CHECK ((`project_id` >= 0)),
  CONSTRAINT `project_skill_history_chk_5` CHECK ((`skill_id` >= 0)),
  CONSTRAINT `project_skill_history_chk_6` CHECK ((`learner_count` >= 0)),
  CONSTRAINT `project_skill_history_chk_7` CHECK ((`beginner_count` >= 0)),
  CONSTRAINT `project_skill_history_chk_8` CHECK ((`intermediate_count` >= 0)),
  CONSTRAINT `project_skill_history_chk_9` CHECK ((`advance_count` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `quiz_metadata`
--

DROP TABLE IF EXISTS `quiz_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_metadata` (
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
  `title` longtext NOT NULL,
  `skill_id` int unsigned NOT NULL,
  `current_level_cd` varchar(30) NOT NULL,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'quiz.question',
  `option_a` varchar(1000) NOT NULL,
  `option_b` varchar(1000) NOT NULL,
  `option_c` varchar(1000) NOT NULL,
  `option_d` varchar(1000) NOT NULL,
  `answer` varchar(1) NOT NULL,
  `ans_description` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `quiz_metadata_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `quiz_metadata_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `quiz_metadata_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `quiz_metadata_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `quiz_metadata_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `quiz_metadata_chk_6` CHECK ((`skill_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=22082 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill` (
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
  `obj_cd` varchar(50) NOT NULL DEFAULT 'skill',
  `core_skill_yn` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_code`
--

DROP TABLE IF EXISTS `sys_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_code` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `code_val` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `status_cd` varchar(200) DEFAULT 'new',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `obj_cd` varchar(50) NOT NULL DEFAULT 'syscode',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_filter`
--

DROP TABLE IF EXISTS `sys_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_filter` (
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
  `gcp_cd` varchar(50) DEFAULT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `sys_upload_seq`
--

DROP TABLE IF EXISTS `sys_upload_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_upload_seq` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `pid` int unsigned DEFAULT '0',
  `parent_id` int unsigned DEFAULT '0',
  `admin_yn` varchar(1) DEFAULT 'N',
  `emp_no` varchar(15) NOT NULL,
  `knox_id` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `sno` int unsigned DEFAULT '0',
  `status_cd` varchar(200) DEFAULT 'sysuser.new',
  `obj_cd` varchar(50) NOT NULL DEFAULT 'sysuser',
  `del_yn` varchar(1) DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gender` varchar(1) DEFAULT NULL,
  `role_cd` varchar(50) DEFAULT NULL,
  `download_permission_yn` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sys_user_badge`
--

DROP TABLE IF EXISTS `sys_user_badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_badge` (
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
  `user_id` int unsigned NOT NULL,
  `badge_id` int unsigned NOT NULL,
  `badge_cd` varchar(100) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `sys_user_badge_chk_1` CHECK ((`pid` >= 0)),
  CONSTRAINT `sys_user_badge_chk_2` CHECK ((`parent_id` >= 0)),
  CONSTRAINT `sys_user_badge_chk_3` CHECK ((`sno` >= 0)),
  CONSTRAINT `sys_user_badge_chk_4` CHECK ((`modifier_id` >= 0)),
  CONSTRAINT `sys_user_badge_chk_5` CHECK ((`creator_id` >= 0)),
  CONSTRAINT `sys_user_badge_chk_6` CHECK ((`user_id` >= 0)),
  CONSTRAINT `sys_user_badge_chk_7` CHECK ((`badge_id` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_footprint`
--

DROP TABLE IF EXISTS `user_footprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_footprint` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `page_cd` varchar(50) NOT NULL,
  `event_cd` varchar(50) NOT NULL,
  `obj_cd` varchar(50) NOT NULL,
  `sno` int unsigned NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `modifier_id` int unsigned NOT NULL,
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL,
  `create_dt` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15773 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_registration`
--

DROP TABLE IF EXISTS `user_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_registration` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `pid` int unsigned NOT NULL DEFAULT '0',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `sno` int unsigned NOT NULL DEFAULT '0',
  `del_yn` varchar(1) NOT NULL DEFAULT 'N',
  `modifier_id` int unsigned NOT NULL DEFAULT '0',
  `modify_dt` datetime(6) NOT NULL,
  `creator_id` int unsigned NOT NULL DEFAULT '0',
  `create_dt` datetime(6) NOT NULL,
  `knox_id` varchar(100) NOT NULL,
  `emp_no` varchar(15) NOT NULL,
  `password` varchar(50) NOT NULL,
  `status_cd` varchar(200) NOT NULL DEFAULT 'user.register.request',
  `role_cd` varchar(50) NOT NULL DEFAULT 'role.member',
  `obj_cd` varchar(50) NOT NULL DEFAULT 'sysuser',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'gh_v3_prd'
--
/*!50003 DROP FUNCTION IF EXISTS `decryptPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`appuser`@`%` FUNCTION `decryptPassword`(input_password VARCHAR(255)) RETURNS varbinary(255)
    DETERMINISTIC
BEGIN
    DECLARE decrypted_password VARBINARY(255);
	DECLARE secret_key VARBINARY(255);
    SET secret_key = generateSecretKey();
    SET decrypted_password = AES_DECRYPT(FROM_BASE64(input_password), secret_key);
    RETURN decrypted_password;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `encryptPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`appuser`@`%` FUNCTION `encryptPassword`(input_password VARCHAR(255), secret_key VARCHAR(255)) RETURNS varbinary(255)
BEGIN
    DECLARE encrypted_password VARBINARY(255);
    SET encrypted_password = to_base64(AES_ENCRYPT(input_password, secret_key));
    RETURN encrypted_password;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `generateSecretKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`appuser`@`%` FUNCTION `generateSecretKey`() RETURNS varchar(255) CHARSET utf8mb4
BEGIN
    RETURN 'abcdefghijklmnop';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getHashPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`appuser`@`%` FUNCTION `getHashPassword`(input_password VARCHAR(255)) RETURNS varbinary(255)
BEGIN
  RETURN encryptPassword(input_password,generateSecretKey());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 16:58:27
