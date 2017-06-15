-- MySQL dump 10.13  Distrib 5.6.32-78.0, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: maticportal
-- ------------------------------------------------------
-- Server version	5.6.32-78.0-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acl_assets`
--

DROP TABLE IF EXISTS `acl_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_assets` (
  `login` varchar(64) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  PRIMARY KEY (`login`,`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_entities`
--

DROP TABLE IF EXISTS `acl_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entities` (
  `id` binary(16) NOT NULL,
  `server_id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `name` varchar(128) DEFAULT NULL,
  `admin_user` varchar(64) NOT NULL,
  `address` tinytext,
  `timezone` varchar(64) NOT NULL DEFAULT 'GMT',
  `parent_id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `entity_type` enum('logical','context','engine') NOT NULL DEFAULT 'logical',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_entities_assets`
--

DROP TABLE IF EXISTS `acl_entities_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entities_assets` (
  `entity_id` binary(16) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  PRIMARY KEY (`entity_id`,`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_entities_stats`
--

DROP TABLE IF EXISTS `acl_entities_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entities_stats` (
  `entity_id` binary(16) NOT NULL,
  `ts` timestamp NULL DEFAULT NULL,
  `stat` float DEFAULT NULL,
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_entities_users`
--

DROP TABLE IF EXISTS `acl_entities_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_entities_users` (
  `entity_id` binary(16) NOT NULL,
  `login` varchar(64) NOT NULL,
  PRIMARY KEY (`entity_id`,`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_login_sensors`
--

DROP TABLE IF EXISTS `acl_login_sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_login_sensors` (
  `login` varchar(64) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`login`,`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_perm`
--

DROP TABLE IF EXISTS `acl_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_perm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('MENU') DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `description` varchar(128) NOT NULL,
  `granularity_sensor` tinyint(1) NOT NULL,
  `granularity_net` tinyint(1) NOT NULL,
  `enabled` tinyint(4) DEFAULT '1',
  `ord` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_sensors`
--

DROP TABLE IF EXISTS `acl_sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_sensors` (
  `entity_id` binary(16) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`entity_id`,`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_templates`
--

DROP TABLE IF EXISTS `acl_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_templates` (
  `id` binary(16) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acl_templates_perms`
--

DROP TABLE IF EXISTS `acl_templates_perms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acl_templates_perms` (
  `ac_templates_id` binary(16) NOT NULL,
  `ac_perm_id` int(11) NOT NULL,
  PRIMARY KEY (`ac_templates_id`,`ac_perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action`
--

DROP TABLE IF EXISTS `action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(128) NOT NULL,
  `action_type` int(11) NOT NULL,
  `cond` varchar(255) NOT NULL,
  `on_risk` tinyint(1) NOT NULL,
  `descr` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action_email`
--

DROP TABLE IF EXISTS `action_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_email` (
  `action_id` binary(16) NOT NULL,
  `_from` varchar(255) NOT NULL,
  `_to` varchar(255) NOT NULL,
  `subject` text,
  `message` text,
  `message_suffix` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action_exec`
--

DROP TABLE IF EXISTS `action_exec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_exec` (
  `action_id` binary(16) NOT NULL,
  `command` text NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action_risk`
--

DROP TABLE IF EXISTS `action_risk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_risk` (
  `action_id` binary(16) NOT NULL,
  `backlog_id` binary(16) NOT NULL,
  `risk` int(11) NOT NULL,
  PRIMARY KEY (`action_id`,`backlog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `action_type`
--

DROP TABLE IF EXISTS `action_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_type` (
  `type` int(11) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `name` enum('email','exec','ticket') NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm`
--

DROP TABLE IF EXISTS `alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm` (
  `backlog_id` binary(16) NOT NULL,
  `event_id` binary(16) NOT NULL,
  `corr_engine_ctx` binary(16) NOT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `status` enum('open','closed') DEFAULT 'open',
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  `protocol` int(11) DEFAULT NULL,
  `src_ip` varbinary(16) DEFAULT NULL,
  `dst_ip` varbinary(16) DEFAULT NULL,
  `src_port` int(11) DEFAULT NULL,
  `dst_port` int(11) DEFAULT NULL,
  `risk` int(11) DEFAULT NULL,
  `efr` int(11) NOT NULL DEFAULT '0',
  `similar` varchar(40) NOT NULL DEFAULT '0000000000000000000000000000000000000000',
  `stats` mediumtext NOT NULL,
  `removable` tinyint(1) NOT NULL DEFAULT '0',
  `in_file` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`backlog_id`),
  KEY `src_ip` (`src_ip`),
  KEY `dst_ip` (`dst_ip`),
  KEY `status` (`status`,`timestamp`),
  KEY `similar` (`status`,`similar`),
  KEY `risk` (`status`,`risk`),
  KEY `event_id` (`event_id`),
  KEY `plugins` (`plugin_id`,`plugin_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `set_similar_field` BEFORE INSERT ON `alarm` FOR EACH ROW

BEGIN
  IF NEW.similar='0000000000000000000000000000000000000000' THEN
     SET NEW.similar = sha1(NEW.backlog_id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `auto_incidents` AFTER INSERT ON `alarm` FOR EACH ROW

BEGIN

  IF EXISTS

   (SELECT value FROM config where conf = "alarms_generate_incidents" and value = "yes")

  THEN

    IF NOT EXISTS (SELECT id FROM incident_alarm WHERE backlog_id = NEW.backlog_id)

    THEN
        SET @tmp_src_ip = NEW.src_ip;
        SET @tmp_dst_ip = NEW.dst_ip;
        SET @tmp_risk = NEW.risk;
        SET @title = 'Unknown Directive';
        IF EXISTS (SELECT 1 from plugin_sid where plugin_ctx=NEW.corr_engine_ctx AND plugin_id = NEW.plugin_id and sid = NEW.plugin_sid)
        THEN
            SET @title = (SELECT ifnull(TRIM(LEADING "directive_event:" FROM name),'Unknown Directive') as name from plugin_sid where plugin_ctx=NEW.corr_engine_ctx AND plugin_id = NEW.plugin_id and sid = NEW.plugin_sid LIMIT 1);
        END IF;
        
        SET @title = REPLACE(@title,"DST_IP", inet6_ntoa(NEW.dst_ip));
        SET @title = REPLACE(@title,"SRC_IP", inet6_ntoa(NEW.src_ip));
        SET @title = REPLACE(@title,"PROTOCOL", NEW.protocol);
        SET @title = REPLACE(@title,"SRC_PORT", NEW.src_port);
        SET @title = REPLACE(@title,"DST_PORT", NEW.dst_port);
        SET @title = CONCAT(@title, " (", inet6_ntoa(NEW.src_ip), ":", CAST(NEW.src_port AS CHAR), " -> ", inet6_ntoa(NEW.dst_ip), ":", CAST(NEW.dst_port AS CHAR), ")");
        
        SELECT value FROM config WHERE conf = 'incidents_incharge_default' into @incharge;
        IF (@incharge IS NULL OR @incharge = '') THEN
            SET @incharge = 'admin';
        END IF;
        
        INSERT INTO incident(uuid,ctx,title,date,ref,type_id,priority,status,last_update,in_charge,submitter,event_start,event_end) values (UNHEX(REPLACE(UUID(),'-','')), NEW.corr_engine_ctx, @title, NEW.timestamp, "Alarm", "Generic", NEW.risk, "Open", NOW(), @incharge, "admin", NEW.timestamp, NEW.timestamp);

        SET @last_incident_id = (SELECT LAST_INSERT_ID() FROM incident LIMIT 1);
        INSERT INTO incident_alarm(incident_id, src_ips, dst_ips, src_ports, dst_ports, backlog_id, event_id, alarm_group_id) values (@last_incident_id, inet6_ntoa(NEW.src_ip), inet6_ntoa(NEW.dst_ip), NEW.src_port, NEW.dst_port, NEW.backlog_id, NEW.event_id, 0);

        CALL incident_ticket_populate(@last_incident_id, @tmp_src_ip, @tmp_dst_ip, @tmp_risk);
    END IF;
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alarm_categories`
--

DROP TABLE IF EXISTS `alarm_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm_ctxs`
--

DROP TABLE IF EXISTS `alarm_ctxs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_ctxs` (
  `id_alarm` binary(16) NOT NULL,
  `id_ctx` binary(16) NOT NULL,
  PRIMARY KEY (`id_alarm`,`id_ctx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm_groups`
--

DROP TABLE IF EXISTS `alarm_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_groups` (
  `group_id` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('open','closed') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `owner` varchar(64) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm_hosts`
--

DROP TABLE IF EXISTS `alarm_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_hosts` (
  `id_alarm` binary(16) NOT NULL,
  `id_host` binary(16) NOT NULL,
  PRIMARY KEY (`id_alarm`,`id_host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm_kingdoms`
--

DROP TABLE IF EXISTS `alarm_kingdoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_kingdoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm_nets`
--

DROP TABLE IF EXISTS `alarm_nets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_nets` (
  `id_alarm` binary(16) NOT NULL,
  `id_net` binary(16) NOT NULL,
  PRIMARY KEY (`id_alarm`,`id_net`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm_taxonomy`
--

DROP TABLE IF EXISTS `alarm_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm_taxonomy` (
  `sid` int(11) NOT NULL,
  `engine_id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `kingdom` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `subcategory` text NOT NULL,
  PRIMARY KEY (`sid`,`engine_id`),
  KEY `subcategory` (`subcategory`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asset_filter_types`
--

DROP TABLE IF EXISTS `asset_filter_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_filter_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filter` varchar(128) DEFAULT NULL,
  `type` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asset_filters`
--

DROP TABLE IF EXISTS `asset_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_filters` (
  `group_id` binary(16) NOT NULL,
  `filter_id` int(11) NOT NULL,
  `value_from` int(11) NOT NULL DEFAULT '0',
  `value_to` int(11) NOT NULL DEFAULT '0',
  `value` varchar(128) NOT NULL,
  PRIMARY KEY (`group_id`,`filter_id`,`value_from`,`value_to`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backlog`
--

DROP TABLE IF EXISTS `backlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backlog` (
  `id` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `corr_engine_ctx` binary(16) NOT NULL,
  `directive_id` int(11) NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  `last` datetime DEFAULT NULL,
  `matched` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directive_id` (`directive_id`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backlog_event`
--

DROP TABLE IF EXISTS `backlog_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backlog_event` (
  `backlog_id` binary(16) NOT NULL,
  `event_id` binary(16) NOT NULL,
  `time_out` int(11) DEFAULT NULL,
  `occurrence` int(11) DEFAULT NULL,
  `rule_level` int(11) DEFAULT NULL,
  `matched` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`backlog_id`,`event_id`),
  KEY `event_idx` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bp_asset_member`
--

DROP TABLE IF EXISTS `bp_asset_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bp_asset_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member` binary(16) NOT NULL,
  `type` enum('file','host','host_group','net','net_group') NOT NULL DEFAULT 'host',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bp_member_status`
--

DROP TABLE IF EXISTS `bp_member_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bp_member_status` (
  `member_id` binary(16) NOT NULL,
  `status_date` datetime NOT NULL,
  `measure_type` varchar(255) NOT NULL,
  `severity` int(2) NOT NULL,
  PRIMARY KEY (`member_id`,`status_date`,`measure_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_changes`
--

DROP TABLE IF EXISTS `category_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_changes` (
  `id` int(11) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classification` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `component_tags`
--

DROP TABLE IF EXISTS `component_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `component_tags` (
  `id_component` binary(16) NOT NULL,
  `id_tag` binary(16) NOT NULL,
  PRIMARY KEY (`id_component`,`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `conf` varchar(255) NOT NULL,
  `value` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  PRIMARY KEY (`conf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `control_panel`
--

DROP TABLE IF EXISTS `control_panel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `control_panel` (
  `id` varchar(128) NOT NULL,
  `rrd_type` varchar(6) NOT NULL DEFAULT 'host',
  `time_range` varchar(5) NOT NULL DEFAULT 'day',
  `max_c` int(11) NOT NULL,
  `max_a` int(11) NOT NULL,
  `max_c_date` datetime DEFAULT NULL,
  `max_a_date` datetime DEFAULT NULL,
  `c_sec_level` float DEFAULT NULL,
  `a_sec_level` float DEFAULT NULL,
  PRIMARY KEY (`id`,`rrd_type`,`time_range`),
  KEY `type_time` (`rrd_type`,`time_range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corr_engine_contexts`
--

DROP TABLE IF EXISTS `corr_engine_contexts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_engine_contexts` (
  `engine_ctx` binary(16) NOT NULL,
  `event_ctx` binary(16) NOT NULL,
  `descr` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`engine_ctx`,`event_ctx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credential_type`
--

DROP TABLE IF EXISTS `credential_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credential_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `credentials`
--

DROP TABLE IF EXISTS `credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `username` text,
  `password` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `extra` text,
  `sensor_ip` varbinary(16) NOT NULL,
  `host_id` binary(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_report_profiles`
--

DROP TABLE IF EXISTS `custom_report_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_report_profiles` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `creator` varchar(64) NOT NULL,
  `permissions` varchar(64) DEFAULT NULL,
  `header` varchar(64) NOT NULL,
  `lfooter` varchar(64) NOT NULL,
  `rfooter` varchar(64) NOT NULL,
  `color1` varchar(64) NOT NULL,
  `color2` varchar(64) NOT NULL,
  `color3` varchar(64) NOT NULL,
  `color4` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`creator`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_report_scheduler`
--

DROP TABLE IF EXISTS `custom_report_scheduler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_report_scheduler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `schedule_type` varchar(5) NOT NULL,
  `schedule_name` varchar(20) NOT NULL,
  `schedule` text NOT NULL,
  `next_launch` datetime NOT NULL,
  `id_report` varchar(512) NOT NULL,
  `name_report` varchar(512) NOT NULL,
  `user` varchar(64) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `date_range` varchar(30) DEFAULT NULL,
  `assets` tinytext,
  `save_in_repository` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_report_types`
--

DROP TABLE IF EXISTS `custom_report_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_report_types` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL,
  `file` varchar(128) NOT NULL,
  `inputs` text NOT NULL,
  `sql` longtext NOT NULL,
  `dr` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_custom_type`
--

DROP TABLE IF EXISTS `dashboard_custom_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_custom_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL,
  `category` varchar(128) NOT NULL,
  `title_default` varchar(128) NOT NULL,
  `help_default` text NOT NULL,
  `file` varchar(128) NOT NULL,
  `params` text NOT NULL,
  `thumb` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14002 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_tab_config`
--

DROP TABLE IF EXISTS `dashboard_tab_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_tab_config` (
  `id` int(11) NOT NULL,
  `user` varchar(64) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `layout` int(11) DEFAULT '1',
  `icon` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_tab_options`
--

DROP TABLE IF EXISTS `dashboard_tab_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_tab_options` (
  `id` int(11) NOT NULL,
  `user` varchar(64) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `tab_order` int(11) NOT NULL,
  PRIMARY KEY (`id`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard_widget_config`
--

DROP TABLE IF EXISTS `dashboard_widget_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_widget_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `panel_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `user` varchar(64) NOT NULL,
  `col` int(11) NOT NULL,
  `fil` int(11) NOT NULL,
  `height` int(11) NOT NULL DEFAULT '200',
  `title` varchar(128) DEFAULT NULL,
  `help` varchar(128) DEFAULT NULL,
  `refresh` int(11) NOT NULL DEFAULT '0',
  `color` varchar(15) NOT NULL,
  `file` varchar(128) NOT NULL,
  `type` varchar(50) NOT NULL,
  `asset` varchar(128) DEFAULT 'ALL_ASSETS',
  `params` text,
  `media` mediumblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `databases`
--

DROP TABLE IF EXISTS `databases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `databases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `port` int(11) NOT NULL DEFAULT '3306',
  `user` varchar(64) NOT NULL,
  `pass` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `icon` mediumblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_types`
--

DROP TABLE IF EXISTS `device_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_types` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `class` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` binary(16) NOT NULL,
  `agent_ctx` binary(16) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tzone` float NOT NULL DEFAULT '0',
  `sensor_id` binary(16) DEFAULT NULL,
  `interface` varchar(32) NOT NULL,
  `type` int(11) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  `protocol` int(11) DEFAULT NULL,
  `src_ip` varbinary(16) DEFAULT NULL,
  `dst_ip` varbinary(16) DEFAULT NULL,
  `src_port` int(11) DEFAULT NULL,
  `dst_port` int(11) DEFAULT NULL,
  `event_condition` int(11) DEFAULT NULL,
  `value` text,
  `time_interval` int(11) DEFAULT NULL,
  `absolute` tinyint(4) DEFAULT NULL,
  `priority` int(11) DEFAULT '1',
  `reliability` int(11) DEFAULT '1',
  `asset_src` int(11) DEFAULT '1',
  `asset_dst` int(11) DEFAULT '1',
  `risk_a` int(11) DEFAULT '0',
  `risk_c` int(11) DEFAULT '0',
  `alarm` tinyint(4) DEFAULT '0',
  `filename` varchar(256) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `userdata1` varchar(1024) DEFAULT NULL,
  `userdata2` varchar(1024) DEFAULT NULL,
  `userdata3` varchar(1024) DEFAULT NULL,
  `userdata4` varchar(1024) DEFAULT NULL,
  `userdata5` varchar(1024) DEFAULT NULL,
  `userdata6` varchar(1024) DEFAULT NULL,
  `userdata7` varchar(1024) DEFAULT NULL,
  `userdata8` varchar(1024) DEFAULT NULL,
  `userdata9` varchar(1024) DEFAULT NULL,
  `rulename` text,
  `rep_prio_src` int(10) unsigned DEFAULT NULL,
  `rep_prio_dst` int(10) unsigned DEFAULT NULL,
  `rep_rel_src` int(10) unsigned DEFAULT NULL,
  `rep_rel_dst` int(10) unsigned DEFAULT NULL,
  `rep_act_src` varchar(64) DEFAULT NULL,
  `rep_act_dst` varchar(64) DEFAULT NULL,
  `src_hostname` varchar(64) DEFAULT NULL,
  `dst_hostname` varchar(64) DEFAULT NULL,
  `src_mac` binary(6) DEFAULT NULL,
  `dst_mac` binary(6) DEFAULT NULL,
  `src_host` binary(16) DEFAULT NULL,
  `dst_host` binary(16) DEFAULT NULL,
  `src_net` binary(16) DEFAULT NULL,
  `dst_net` binary(16) DEFAULT NULL,
  `refs` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_idx` (`timestamp`),
  KEY `src_ip` (`src_ip`),
  KEY `dst_ip` (`dst_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extra_data`
--

DROP TABLE IF EXISTS `extra_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extra_data` (
  `event_id` binary(16) NOT NULL,
  `data_payload` text,
  `binary_data` blob,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hids_agents`
--

DROP TABLE IF EXISTS `hids_agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hids_agents` (
  `sensor_id` binary(16) NOT NULL,
  `agent_id` varchar(5) NOT NULL,
  `agent_name` varchar(128) DEFAULT NULL,
  `agent_ip` varchar(32) DEFAULT NULL,
  `agent_status` tinyint(1) DEFAULT NULL,
  `host_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`sensor_id`,`agent_id`),
  KEY `status` (`agent_status`),
  KEY `host_id` (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `hostname` varchar(128) NOT NULL,
  `fqdns` varchar(255) NOT NULL,
  `asset` smallint(6) NOT NULL,
  `threshold_c` int(11) NOT NULL,
  `threshold_a` int(11) NOT NULL,
  `alert` int(11) NOT NULL,
  `persistence` int(11) NOT NULL,
  `nat` varchar(15) DEFAULT NULL,
  `rrd_profile` varchar(64) DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `lat` varchar(255) DEFAULT '0',
  `lon` varchar(255) DEFAULT '0',
  `icon` mediumblob,
  `country` varchar(64) DEFAULT NULL,
  `external_host` tinyint(1) NOT NULL DEFAULT '0',
  `permissions` binary(8) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0',
  `av_component` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `search` (`hostname`,`fqdns`),
  KEY `ctx` (`ctx`),
  KEY `created` (`created`),
  KEY `updated` (`updated`),
  KEY `asset` (`asset`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_INSERT` BEFORE INSERT ON `host`
FOR EACH ROW BEGIN
    SET NEW.created = utc_timestamp();
    SET NEW.updated = utc_timestamp();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_UPDATE` BEFORE UPDATE ON `host`
FOR EACH ROW BEGIN
    SET NEW.updated = utc_timestamp();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_agentless`
--

DROP TABLE IF EXISTS `host_agentless`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_agentless` (
  `ip` varchar(15) NOT NULL,
  `sensor_id` varchar(36) NOT NULL,
  `hostname` varchar(128) NOT NULL,
  `user` varchar(128) NOT NULL,
  `pass` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `ppass` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `use_su` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(255) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ip`,`sensor_id`),
  KEY `search` (`hostname`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_agentless_entries`
--

DROP TABLE IF EXISTS `host_agentless_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_agentless_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL,
  `sensor_id` varchar(36) NOT NULL,
  `type` varchar(64) NOT NULL,
  `frequency` int(10) NOT NULL,
  `state` varchar(20) NOT NULL,
  `arguments` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_group`
--

DROP TABLE IF EXISTS `host_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_group` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `same_host` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `threshold_c` int(11) NOT NULL,
  `threshold_a` int(11) NOT NULL,
  `rrd_profile` varchar(64) DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `permissions` binary(8) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0',
  `owner` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_group_history`
--

DROP TABLE IF EXISTS `host_group_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_group_history` (
  `host_group_id` binary(16) NOT NULL,
  `date` datetime NOT NULL,
  `login` varchar(64) NOT NULL,
  `action` varchar(255) NOT NULL,
  PRIMARY KEY (`host_group_id`,`date`,`login`,`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_group_reference`
--

DROP TABLE IF EXISTS `host_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_group_reference` (
  `host_group_id` binary(16) NOT NULL,
  `host_id` binary(16) NOT NULL,
  PRIMARY KEY (`host_group_id`,`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_group_scan`
--

DROP TABLE IF EXISTS `host_group_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_group_scan` (
  `host_group_id` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`host_group_id`,`plugin_id`,`plugin_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_ip`
--

DROP TABLE IF EXISTS `host_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_ip` (
  `host_id` binary(16) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `mac` binary(6) DEFAULT NULL,
  `interface` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`host_id`,`ip`),
  KEY `ip_index` (`ip`) USING BTREE,
  KEY `mac_index` (`mac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_ip_INSERT` AFTER INSERT ON `host_ip` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_ip_UPDATE` AFTER UPDATE ON `host_ip` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_ip_DELETE` AFTER DELETE ON `host_ip` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_mac_vendors`
--

DROP TABLE IF EXISTS `host_mac_vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_mac_vendors` (
  `mac` binary(3) NOT NULL,
  `vendor` varchar(255) NOT NULL,
  PRIMARY KEY (`mac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_net_reference`
--

DROP TABLE IF EXISTS `host_net_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_net_reference` (
  `host_id` binary(16) NOT NULL,
  `net_id` binary(16) NOT NULL,
  PRIMARY KEY (`host_id`,`net_id`),
  KEY `net` (`net_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_plugin_sid`
--

DROP TABLE IF EXISTS `host_plugin_sid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_plugin_sid` (
  `host_ip` varbinary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  PRIMARY KEY (`host_ip`,`ctx`,`plugin_id`,`plugin_sid`),
  KEY `plugin` (`plugin_id`,`plugin_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_properties`
--

DROP TABLE IF EXISTS `host_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_properties` (
  `host_id` binary(16) NOT NULL,
  `property_ref` int(11) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `source_id` int(11) DEFAULT NULL,
  `value` text NOT NULL,
  `extra` text,
  `tzone` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`host_id`,`property_ref`,`value`(255)),
  KEY `date` (`last_modified`),
  KEY `property_ref` (`property_ref`,`value`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_properties_INSERT` AFTER INSERT ON `host_properties` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_properties_UPDATE` AFTER UPDATE ON `host_properties` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_properties_DELETE` AFTER DELETE ON `host_properties` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_property_reference`
--

DROP TABLE IF EXISTS `host_property_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_property_reference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `ord` int(11) NOT NULL DEFAULT '0',
  `description` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_qualification`
--

DROP TABLE IF EXISTS `host_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_qualification` (
  `host_id` binary(16) NOT NULL,
  `compromise` int(11) NOT NULL DEFAULT '1',
  `attack` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_scan`
--

DROP TABLE IF EXISTS `host_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_scan` (
  `host_id` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`host_id`,`plugin_id`,`plugin_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_scan_INSERT` AFTER INSERT ON `host_scan` FOR EACH ROW

BEGIN
    UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_scan_UPDATE` AFTER UPDATE ON `host_scan` FOR EACH ROW

BEGIN
    UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_scan_DELETE` AFTER DELETE ON `host_scan` FOR EACH ROW

BEGIN
    UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_sensor_reference`
--

DROP TABLE IF EXISTS `host_sensor_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_sensor_reference` (
  `host_id` binary(16) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`host_id`,`sensor_id`),
  KEY `sensor` (`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `hsr_INS` AFTER INSERT ON `host_sensor_reference` FOR EACH ROW
BEGIN
    IF @disable_calc_perms IS NULL THEN
        CALL update_users_affected_by_sensors(NEW.sensor_id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `hsr_DEL` AFTER DELETE ON `host_sensor_reference` FOR EACH ROW
BEGIN
    IF @disable_calc_perms IS NULL THEN
        CALL update_users_affected_by_sensors(OLD.sensor_id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_services`
--

DROP TABLE IF EXISTS `host_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_services` (
  `host_id` binary(16) NOT NULL,
  `host_ip` varbinary(16) NOT NULL,
  `port` int(11) NOT NULL,
  `protocol` int(11) NOT NULL,
  `service` varchar(128) DEFAULT 'unknown',
  `version` text,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `source_id` int(11) DEFAULT NULL,
  `nagios` tinyint(1) DEFAULT '0',
  `nagios_status` tinyint(4) NOT NULL DEFAULT '3',
  `tzone` float DEFAULT '0',
  PRIMARY KEY (`host_id`,`host_ip`,`port`,`protocol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_services_RENAME` BEFORE INSERT ON `host_services` FOR EACH ROW
BEGIN
    IF NEW.port=40001 AND NEW.service='unknown' THEN
        SET NEW.service = IF(is_pro(),'usm server','ossim server');
    ELSEIF NEW.port=1241 AND NEW.service='unknown' THEN
        SET NEW.service = 'nessus';
    ELSEIF NEW.port=9390 AND (NEW.service='unknown' OR NEW.service='OpenVAS' OR NEW.service='unknow-ssl') THEN
        SET NEW.service = 'openvasmd';
    ELSEIF NEW.port=9391 AND (NEW.service='unknown' OR NEW.service='OpenVAS' OR NEW.service='openvas-ssl') THEN
        SET NEW.service = 'openvassd';
    END IF;
    
    IF NEW.service='ossim server' THEN
        SET NEW.version = 'Open Source Security Information Management server';
    ELSEIF NEW.service='usm server' THEN
        SET NEW.version = 'Unified Security Management server';
    ELSEIF NEW.service='openvasmd' THEN
        SET NEW.version = 'OpenVAS manager';
    ELSEIF NEW.service='openvassd' THEN
        SET NEW.version = 'OpenVAS server';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_services_INSERT` AFTER INSERT ON `host_services` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_services_UPDATE` AFTER UPDATE ON `host_services` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_services_DELETE` AFTER DELETE ON `host_services` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_software`
--

DROP TABLE IF EXISTS `host_software`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_software` (
  `host_id` binary(16) NOT NULL,
  `cpe` varchar(255) NOT NULL,
  `banner` text,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `source_id` int(11) DEFAULT NULL,
  `extra` text,
  PRIMARY KEY (`host_id`,`cpe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_software_INSERT` AFTER INSERT ON `host_software` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_software_UPDATE` AFTER UPDATE ON `host_software` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_software_DELETE` AFTER DELETE ON `host_software` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_source_reference`
--

DROP TABLE IF EXISTS `host_source_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_source_reference` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `relevance` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host_types`
--

DROP TABLE IF EXISTS `host_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_types` (
  `host_id` binary(16) NOT NULL,
  `type` int(11) NOT NULL,
  `subtype` int(11) NOT NULL,
  PRIMARY KEY (`host_id`,`type`,`subtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_types_INSERT` AFTER INSERT ON `host_types` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_types_UPDATE` AFTER UPDATE ON `host_types` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_types_DELETE` AFTER DELETE ON `host_types` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `host_vulnerability`
--

DROP TABLE IF EXISTS `host_vulnerability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_vulnerability` (
  `host_id` binary(16) NOT NULL,
  `scan_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vulnerability` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`host_id`,`scan_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_vulnerability_INSERT` AFTER INSERT ON `host_vulnerability` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_vulnerability_UPDATE` AFTER UPDATE ON `host_vulnerability` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=NEW.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `host_vulnerability_DELETE` AFTER DELETE ON `host_vulnerability` FOR EACH ROW

BEGIN
    IF @disable_host_update IS NULL THEN
        UPDATE host SET updated=utc_timestamp() WHERE id=OLD.host_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `idm_data`
--

DROP TABLE IF EXISTS `idm_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idm_data` (
  `event_id` binary(16) NOT NULL,
  `username` varchar(64) DEFAULT NULL,
  `domain` varchar(64) DEFAULT NULL,
  `from_src` tinyint(1) DEFAULT NULL,
  KEY `event_id` (`event_id`),
  KEY `usrdmn` (`username`,`domain`),
  KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `title` varchar(512) NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ref` enum('Alarm','Alert','Event','Metric','Anomaly','Vulnerability','Custom') NOT NULL DEFAULT 'Alarm',
  `type_id` varchar(64) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL,
  `status` enum('Open','Assigned','Studying','Waiting','Testing','Closed') NOT NULL DEFAULT 'Open',
  `last_update` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `in_charge` varchar(64) NOT NULL,
  `submitter` varchar(64) NOT NULL,
  `event_start` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `event_end` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `in_charge` (`in_charge`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_alarm`
--

DROP TABLE IF EXISTS `incident_alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `src_ips` varchar(255) NOT NULL,
  `src_ports` varchar(255) NOT NULL,
  `dst_ips` varchar(255) NOT NULL,
  `dst_ports` varchar(255) NOT NULL,
  `backlog_id` binary(16) NOT NULL,
  `event_id` binary(16) NOT NULL,
  `alarm_group_id` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_anomaly`
--

DROP TABLE IF EXISTS `incident_anomaly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_anomaly` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `anom_type` enum('mac','service','os') NOT NULL DEFAULT 'mac',
  `ip` varchar(255) NOT NULL,
  `data_orig` varchar(255) NOT NULL,
  `data_new` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_custom`
--

DROP TABLE IF EXISTS `incident_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_custom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `incident_custom_type_id` varchar(64) NOT NULL,
  `content` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_custom_types`
--

DROP TABLE IF EXISTS `incident_custom_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_custom_types` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `options` text NOT NULL,
  `required` int(1) NOT NULL,
  `ord` int(11) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_event`
--

DROP TABLE IF EXISTS `incident_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `src_ips` varchar(255) NOT NULL,
  `src_ports` varchar(255) NOT NULL,
  `dst_ips` varchar(255) NOT NULL,
  `dst_ports` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_file`
--

DROP TABLE IF EXISTS `incident_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `incident_ticket` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `content` mediumblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_metric`
--

DROP TABLE IF EXISTS `incident_metric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_metric` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `target` varchar(255) NOT NULL,
  `metric_type` enum('Compromise','Attack','Level') NOT NULL DEFAULT 'Compromise',
  `metric_value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_subscrip`
--

DROP TABLE IF EXISTS `incident_subscrip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_subscrip` (
  `login` varchar(64) NOT NULL,
  `incident_id` int(11) NOT NULL,
  PRIMARY KEY (`login`,`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_tag`
--

DROP TABLE IF EXISTS `incident_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_tag` (
  `tag_id` int(11) NOT NULL,
  `incident_id` int(11) NOT NULL,
  PRIMARY KEY (`tag_id`,`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_tag_descr`
--

DROP TABLE IF EXISTS `incident_tag_descr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_tag_descr` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `descr` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_tag_descr_seq`
--

DROP TABLE IF EXISTS `incident_tag_descr_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_tag_descr_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_ticket`
--

DROP TABLE IF EXISTS `incident_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_ticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` enum('Open','Assigned','Studying','Waiting','Testing','Closed') NOT NULL DEFAULT 'Open',
  `priority` int(11) NOT NULL,
  `users` varchar(64) NOT NULL,
  `description` text,
  `action` text,
  `in_charge` varchar(64) DEFAULT NULL,
  `transferred` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users` (`incident_id`,`users`,`in_charge`,`transferred`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_ticket_seq`
--

DROP TABLE IF EXISTS `incident_ticket_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_ticket_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_tmp_email`
--

DROP TABLE IF EXISTS `incident_tmp_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_tmp_email` (
  `incident_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  PRIMARY KEY (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_type`
--

DROP TABLE IF EXISTS `incident_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_type` (
  `id` varchar(64) NOT NULL,
  `descr` varchar(255) NOT NULL DEFAULT '',
  `keywords` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_vulns`
--

DROP TABLE IF EXISTS `incident_vulns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_vulns` (
  `id` int(11) NOT NULL,
  `incident_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `port` varchar(255) NOT NULL,
  `nessus_id` varchar(255) NOT NULL,
  `risk` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`,`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incident_vulns_seq`
--

DROP TABLE IF EXISTS `incident_vulns_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incident_vulns_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_sensor_reference`
--

DROP TABLE IF EXISTS `location_sensor_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_sensor_reference` (
  `location_id` binary(16) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`location_id`,`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `lat` float NOT NULL,
  `lon` float NOT NULL,
  `country` varchar(2) NOT NULL,
  `checks` binary(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_action`
--

DROP TABLE IF EXISTS `log_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_action` (
  `ctx` binary(16) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `code` int(10) unsigned NOT NULL,
  `info` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `ipfrom` varbinary(16) NOT NULL,
  PRIMARY KEY (`ctx`,`date`,`code`,`info`),
  KEY `info` (`info`,`date`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_config`
--

DROP TABLE IF EXISTS `log_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_config` (
  `ctx` binary(16) NOT NULL,
  `code` int(10) unsigned NOT NULL,
  `log` tinyint(1) DEFAULT '0',
  `descr` varchar(255) NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ctx`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map`
--

DROP TABLE IF EXISTS `map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `engine` enum('openlayers_op','openlayers_ve','openlayers_yahoo','openlayers_image') DEFAULT NULL,
  `engine_data1` mediumtext,
  `engine_data2` text,
  `engine_data3` text,
  `engine_data4` text,
  `center_x` varchar(255) DEFAULT NULL,
  `center_y` varchar(255) DEFAULT NULL,
  `zoom` int(11) DEFAULT NULL,
  `show_controls` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_element`
--

DROP TABLE IF EXISTS `map_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_element` (
  `id` binary(16) NOT NULL,
  `type` enum('host','sensor','network','server') DEFAULT NULL,
  `ossim_element_key` varchar(255) DEFAULT NULL,
  `map_id` binary(16) NOT NULL,
  `x` varchar(255) DEFAULT NULL,
  `y` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_element_seq`
--

DROP TABLE IF EXISTS `map_element_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_element_seq` (
  `id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_seq`
--

DROP TABLE IF EXISTS `map_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `map_seq` (
  `id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net`
--

DROP TABLE IF EXISTS `net`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(128) NOT NULL,
  `ips` text NOT NULL,
  `asset` int(11) NOT NULL,
  `threshold_c` int(11) NOT NULL,
  `threshold_a` int(11) NOT NULL,
  `alert` int(11) NOT NULL,
  `persistence` int(11) NOT NULL,
  `rrd_profile` varchar(64) DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `icon` mediumblob,
  `external_net` tinyint(1) NOT NULL DEFAULT '0',
  `permissions` binary(8) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0',
  `owner` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `ctx` (`ctx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `net_DEL` AFTER DELETE ON `net` FOR EACH ROW
BEGIN
    IF @disable_calc_perms IS NULL THEN
        CALL update_users_affected_by_networks();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `net_cidrs`
--

DROP TABLE IF EXISTS `net_cidrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_cidrs` (
  `net_id` binary(16) NOT NULL,
  `cidr` varchar(20) NOT NULL,
  `begin` varbinary(16) NOT NULL,
  `end` varbinary(16) NOT NULL,
  PRIMARY KEY (`net_id`,`cidr`,`begin`,`end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `ncidrs_INS` AFTER INSERT ON `net_cidrs` FOR EACH ROW
BEGIN
    IF @disable_calc_perms IS NULL THEN
        CALL update_users_affected_by_networks();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `net_group`
--

DROP TABLE IF EXISTS `net_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_group` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(128) NOT NULL,
  `threshold_c` int(11) NOT NULL,
  `threshold_a` int(11) NOT NULL,
  `rrd_profile` varchar(64) DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `permissions` binary(8) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net_group_reference`
--

DROP TABLE IF EXISTS `net_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_group_reference` (
  `net_group_id` binary(16) NOT NULL,
  `net_id` binary(16) NOT NULL,
  PRIMARY KEY (`net_group_id`,`net_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net_group_scan`
--

DROP TABLE IF EXISTS `net_group_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_group_scan` (
  `net_group_id` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  PRIMARY KEY (`net_group_id`,`plugin_id`,`plugin_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net_qualification`
--

DROP TABLE IF EXISTS `net_qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_qualification` (
  `net_id` binary(16) NOT NULL,
  `compromise` int(11) NOT NULL DEFAULT '1',
  `attack` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`net_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net_scan`
--

DROP TABLE IF EXISTS `net_scan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_scan` (
  `net_id` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  PRIMARY KEY (`net_id`,`plugin_id`,`plugin_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `net_sensor_reference`
--

DROP TABLE IF EXISTS `net_sensor_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_sensor_reference` (
  `net_id` binary(16) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`net_id`,`sensor_id`),
  KEY `sensor` (`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `nsr_INS` AFTER INSERT ON `net_sensor_reference` FOR EACH ROW
BEGIN
    IF @disable_calc_perms IS NULL THEN
        CALL update_users_affected_by_sensors(NEW.sensor_id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 TRIGGER `nsr_DEL` AFTER DELETE ON `net_sensor_reference` FOR EACH ROW
BEGIN
    IF @disable_calc_perms IS NULL THEN
        CALL update_users_affected_by_sensors(OLD.sensor_id);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `net_vulnerability`
--

DROP TABLE IF EXISTS `net_vulnerability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_vulnerability` (
  `net_id` binary(16) NOT NULL,
  `scan_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vulnerability` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`net_id`,`scan_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('host','net','host_group','net_group') NOT NULL,
  `date` datetime NOT NULL,
  `user` varchar(64) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`asset_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otx_data`
--

DROP TABLE IF EXISTS `otx_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otx_data` (
  `event_id` binary(16) NOT NULL,
  `pulse_id` varbinary(16) NOT NULL,
  `ioc_hash` varchar(32) NOT NULL,
  `ioc_value` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`event_id`,`pulse_id`,`ioc_hash`),
  KEY `ioc` (`ioc_value`(255)),
  KEY `pulse` (`pulse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pass_history`
--

DROP TABLE IF EXISTS `pass_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pass_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `user` varchar(64) NOT NULL,
  `hist_number` int(11) DEFAULT NULL,
  `pass` varchar(64) NOT NULL,
  `salt` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `ctx` binary(16) NOT NULL,
  `id` int(11) NOT NULL,
  `type` smallint(6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `product_type` int(11) NOT NULL DEFAULT '0',
  `vendor` text,
  PRIMARY KEY (`id`,`ctx`),
  KEY `product_type` (`product_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_data`
--

DROP TABLE IF EXISTS `plugin_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_data` (
  `ctx` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_name` varchar(128) DEFAULT NULL,
  `vendor` varchar(128) DEFAULT NULL,
  `model` varchar(128) DEFAULT NULL,
  `version` varchar(128) DEFAULT NULL,
  `nsids` int(11) DEFAULT '0',
  `nassets` int(11) DEFAULT '0',
  `plugin_type` tinyint(1) DEFAULT '0',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ctx`,`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_group`
--

DROP TABLE IF EXISTS `plugin_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_group` (
  `group_id` binary(16) NOT NULL,
  `group_ctx` binary(16) NOT NULL,
  `name` varchar(125) NOT NULL,
  `descr` varchar(255) NOT NULL,
  PRIMARY KEY (`group_id`,`group_ctx`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_group_descr`
--

DROP TABLE IF EXISTS `plugin_group_descr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_group_descr` (
  `group_id` binary(16) NOT NULL,
  `group_ctx` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `plugin_ctx` binary(16) NOT NULL,
  `plugin_sid` text NOT NULL,
  PRIMARY KEY (`group_id`,`group_ctx`,`plugin_id`,`plugin_ctx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_reference`
--

DROP TABLE IF EXISTS `plugin_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_reference` (
  `plugin_id` int(11) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `reference_sid` int(11) NOT NULL,
  `ctx` binary(16) NOT NULL,
  PRIMARY KEY (`plugin_id`,`plugin_sid`,`reference_id`,`reference_sid`,`ctx`),
  KEY `reference` (`reference_id`,`reference_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler`
--

DROP TABLE IF EXISTS `plugin_scheduler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `plugin` varchar(255) NOT NULL,
  `plugin_minute` varchar(255) NOT NULL,
  `plugin_hour` varchar(255) NOT NULL,
  `plugin_day_month` varchar(255) NOT NULL,
  `plugin_month` varchar(255) NOT NULL,
  `plugin_day_week` varchar(255) NOT NULL,
  `type_scan` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler_host_reference`
--

DROP TABLE IF EXISTS `plugin_scheduler_host_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler_host_reference` (
  `plugin_scheduler_id` binary(16) NOT NULL,
  `host_id` binary(16) NOT NULL,
  PRIMARY KEY (`plugin_scheduler_id`,`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler_hostgroup_reference`
--

DROP TABLE IF EXISTS `plugin_scheduler_hostgroup_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler_hostgroup_reference` (
  `plugin_scheduler_id` binary(16) NOT NULL,
  `hostgroup_id` binary(16) NOT NULL,
  PRIMARY KEY (`plugin_scheduler_id`,`hostgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler_net_reference`
--

DROP TABLE IF EXISTS `plugin_scheduler_net_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler_net_reference` (
  `plugin_scheduler_id` binary(16) NOT NULL,
  `net_id` binary(16) NOT NULL,
  PRIMARY KEY (`plugin_scheduler_id`,`net_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler_netgroup_reference`
--

DROP TABLE IF EXISTS `plugin_scheduler_netgroup_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler_netgroup_reference` (
  `plugin_scheduler_id` binary(16) NOT NULL,
  `netgroup_id` binary(16) NOT NULL,
  PRIMARY KEY (`plugin_scheduler_id`,`netgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler_sensor_reference`
--

DROP TABLE IF EXISTS `plugin_scheduler_sensor_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler_sensor_reference` (
  `plugin_scheduler_id` binary(16) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`plugin_scheduler_id`,`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_scheduler_seq`
--

DROP TABLE IF EXISTS `plugin_scheduler_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_scheduler_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_sid`
--

DROP TABLE IF EXISTS `plugin_sid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_sid` (
  `plugin_ctx` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `reliability` int(11) DEFAULT '1',
  `priority` int(11) DEFAULT '1',
  `name` varchar(512) NOT NULL,
  `aro` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `subcategory_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`plugin_id`,`sid`,`plugin_ctx`),
  KEY `search` (`plugin_id`,`name`(255)),
  KEY `category_id` (`category_id`,`subcategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_sid_changes`
--

DROP TABLE IF EXISTS `plugin_sid_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_sid_changes` (
  `plugin_ctx` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `reliability` int(11) DEFAULT '1',
  `priority` int(11) DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `aro` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `subcategory_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`plugin_ctx`,`plugin_id`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_sid_orig`
--

DROP TABLE IF EXISTS `plugin_sid_orig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_sid_orig` (
  `plugin_ctx` binary(16) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `reliability` int(11) DEFAULT '1',
  `priority` int(11) DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `aro` decimal(11,4) NOT NULL DEFAULT '0.0000',
  `subcategory_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`plugin_ctx`,`plugin_id`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `priority` smallint(6) NOT NULL,
  `active` int(11) NOT NULL,
  `group` binary(16) NOT NULL,
  `order` int(11) NOT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `permissions` binary(8) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`),
  KEY `group` (`group`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_actions`
--

DROP TABLE IF EXISTS `policy_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_actions` (
  `policy_id` binary(16) NOT NULL,
  `action_id` binary(16) NOT NULL,
  PRIMARY KEY (`policy_id`,`action_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_extra_data_reference`
--

DROP TABLE IF EXISTS `policy_extra_data_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_extra_data_reference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` binary(16) NOT NULL,
  `filename` varchar(128) DEFAULT NULL,
  `username` varchar(128) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `userdata1` varchar(128) DEFAULT NULL,
  `userdata2` varchar(128) DEFAULT NULL,
  `userdata3` varchar(128) DEFAULT NULL,
  `userdata4` varchar(128) DEFAULT NULL,
  `userdata5` varchar(128) DEFAULT NULL,
  `userdata6` varchar(128) DEFAULT NULL,
  `userdata7` varchar(128) DEFAULT NULL,
  `userdata8` varchar(128) DEFAULT NULL,
  `userdata9` varchar(128) DEFAULT NULL,
  `data_payload` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_forward_reference`
--

DROP TABLE IF EXISTS `policy_forward_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_forward_reference` (
  `policy_id` binary(16) NOT NULL,
  `child_id` binary(16) NOT NULL,
  `parent_id` binary(16) NOT NULL,
  `priority` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`policy_id`,`child_id`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_group`
--

DROP TABLE IF EXISTS `policy_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_group` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `order` int(11) NOT NULL,
  `permissions` binary(8) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0',
  PRIMARY KEY (`id`,`ctx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_host_group_reference`
--

DROP TABLE IF EXISTS `policy_host_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_host_group_reference` (
  `policy_id` binary(16) NOT NULL,
  `host_group_id` binary(16) NOT NULL,
  `direction` enum('source','dest') NOT NULL,
  PRIMARY KEY (`policy_id`,`host_group_id`,`direction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_host_reference`
--

DROP TABLE IF EXISTS `policy_host_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_host_reference` (
  `policy_id` binary(16) NOT NULL,
  `host_id` binary(16) NOT NULL,
  `direction` enum('source','dest') NOT NULL,
  PRIMARY KEY (`policy_id`,`host_id`,`direction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_idm_reference`
--

DROP TABLE IF EXISTS `policy_idm_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_idm_reference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` binary(16) NOT NULL,
  `from_src` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(64) DEFAULT NULL,
  `domain` varchar(64) DEFAULT NULL,
  `hostname` varchar(64) DEFAULT NULL,
  `mac` binary(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_net_group_reference`
--

DROP TABLE IF EXISTS `policy_net_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_net_group_reference` (
  `policy_id` binary(16) NOT NULL,
  `net_group_id` binary(16) NOT NULL,
  `direction` enum('source','dest') NOT NULL,
  PRIMARY KEY (`policy_id`,`net_group_id`,`direction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_net_reference`
--

DROP TABLE IF EXISTS `policy_net_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_net_reference` (
  `policy_id` binary(16) NOT NULL,
  `net_id` binary(16) NOT NULL,
  `direction` enum('source','dest') NOT NULL,
  PRIMARY KEY (`policy_id`,`net_id`,`direction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_plugin_group_reference`
--

DROP TABLE IF EXISTS `policy_plugin_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_plugin_group_reference` (
  `policy_id` binary(16) NOT NULL,
  `plugin_group_id` binary(16) NOT NULL,
  PRIMARY KEY (`policy_id`,`plugin_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_port_reference`
--

DROP TABLE IF EXISTS `policy_port_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_port_reference` (
  `policy_id` binary(16) NOT NULL,
  `port_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `direction` enum('source','dest') NOT NULL,
  PRIMARY KEY (`policy_id`,`port_group_id`,`direction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_reputation_reference`
--

DROP TABLE IF EXISTS `policy_reputation_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_reputation_reference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` binary(16) NOT NULL,
  `from_src` tinyint(1) NOT NULL DEFAULT '0',
  `rep_prio` tinyint(4) NOT NULL DEFAULT '-1',
  `rep_rel` tinyint(4) NOT NULL DEFAULT '-1',
  `rep_act` smallint(6) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_risk_reference`
--

DROP TABLE IF EXISTS `policy_risk_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_risk_reference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` binary(16) NOT NULL,
  `priority` smallint(5) unsigned DEFAULT NULL,
  `reliability` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_role_reference`
--

DROP TABLE IF EXISTS `policy_role_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_role_reference` (
  `policy_id` binary(16) NOT NULL,
  `correlate` tinyint(1) NOT NULL DEFAULT '1',
  `cross_correlate` tinyint(1) NOT NULL DEFAULT '1',
  `store` tinyint(1) NOT NULL DEFAULT '1',
  `qualify` tinyint(1) NOT NULL DEFAULT '1',
  `resend_alarm` tinyint(1) NOT NULL DEFAULT '1',
  `resend_event` tinyint(1) NOT NULL DEFAULT '1',
  `sign` int(10) unsigned NOT NULL DEFAULT '0',
  `sem` tinyint(1) NOT NULL DEFAULT '1',
  `sim` tinyint(1) NOT NULL DEFAULT '1',
  `reputation` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_sensor_reference`
--

DROP TABLE IF EXISTS `policy_sensor_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_sensor_reference` (
  `policy_id` binary(16) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`policy_id`,`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_target_reference`
--

DROP TABLE IF EXISTS `policy_target_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_target_reference` (
  `policy_id` binary(16) NOT NULL,
  `target_id` binary(16) NOT NULL,
  PRIMARY KEY (`policy_id`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_taxonomy_reference`
--

DROP TABLE IF EXISTS `policy_taxonomy_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_taxonomy_reference` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` binary(16) NOT NULL,
  `product_type_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `subcategory_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_time_reference`
--

DROP TABLE IF EXISTS `policy_time_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_time_reference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `policy_id` binary(16) NOT NULL,
  `minute_start` int(11) NOT NULL DEFAULT '0',
  `minute_end` int(11) NOT NULL DEFAULT '0',
  `hour_start` int(11) NOT NULL DEFAULT '0',
  `hour_end` int(11) NOT NULL DEFAULT '0',
  `week_day_start` int(11) NOT NULL DEFAULT '0',
  `week_day_end` int(11) NOT NULL DEFAULT '0',
  `month_day_start` int(11) NOT NULL DEFAULT '0',
  `month_day_end` int(11) NOT NULL DEFAULT '0',
  `month_start` int(11) NOT NULL DEFAULT '0',
  `month_end` int(11) NOT NULL DEFAULT '0',
  `timezone` varchar(64) NOT NULL DEFAULT 'UTC',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `port`
--

DROP TABLE IF EXISTS `port`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `port` (
  `ctx` binary(16) NOT NULL,
  `port_number` int(11) NOT NULL,
  `protocol_name` varchar(12) NOT NULL,
  `service` varchar(64) DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ctx`,`port_number`,`protocol_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `port_group`
--

DROP TABLE IF EXISTS `port_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `port_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `descr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `port_group_reference`
--

DROP TABLE IF EXISTS `port_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `port_group_reference` (
  `port_group_id` int(10) unsigned NOT NULL,
  `port_ctx` binary(16) NOT NULL,
  `port_number` int(11) NOT NULL,
  `protocol_name` varchar(12) NOT NULL,
  PRIMARY KEY (`port_group_id`,`port_ctx`,`port_number`,`protocol_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repository`
--

DROP TABLE IF EXISTS `repository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `creator` varchar(64) NOT NULL DEFAULT '0',
  `title` varchar(256) NOT NULL,
  `text` text NOT NULL,
  `date` date NOT NULL,
  `in_charge` varchar(64) NOT NULL,
  `keywords` varchar(256) NOT NULL COMMENT 'Comma separated',
  PRIMARY KEY (`id`),
  KEY `title` (`title`(200)),
  KEY `keywords` (`keywords`(200))
) ENGINE=InnoDB AUTO_INCREMENT=50119 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repository_attachments`
--

DROP TABLE IF EXISTS `repository_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository_attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_document` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `type` varchar(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repository_relationships`
--

DROP TABLE IF EXISTS `repository_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repository_relationships` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_document` int(11) NOT NULL,
  `type` varchar(16) NOT NULL,
  `keyname` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `keyname` (`keyname`)
) ENGINE=InnoDB AUTO_INCREMENT=2088 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reputation_activities`
--

DROP TABLE IF EXISTS `reputation_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reputation_activities` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `descr` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restoredb_log`
--

DROP TABLE IF EXISTS `restoredb_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restoredb_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pid` int(11) DEFAULT NULL,
  `users` varchar(64) DEFAULT NULL,
  `data` text,
  `status` smallint(6) DEFAULT NULL,
  `percent` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_indicators`
--

DROP TABLE IF EXISTS `risk_indicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risk_indicators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `map` binary(16) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `w` int(11) NOT NULL DEFAULT '0',
  `h` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `risk_maps`
--

DROP TABLE IF EXISTS `risk_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risk_maps` (
  `map` binary(16) NOT NULL,
  `perm` varchar(64) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rrd_anomalies`
--

DROP TABLE IF EXISTS `rrd_anomalies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rrd_anomalies` (
  `ip` varbinary(16) DEFAULT NULL,
  `what` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `anomaly_time` varchar(40) NOT NULL,
  `anomaly_range` varchar(30) NOT NULL,
  `over` int(11) NOT NULL,
  `acked` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rrd_anomalies_global`
--

DROP TABLE IF EXISTS `rrd_anomalies_global`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rrd_anomalies_global` (
  `what` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `anomaly_time` varchar(40) NOT NULL,
  `anomaly_range` varchar(30) NOT NULL,
  `over` int(11) NOT NULL,
  `acked` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rrd_config`
--

DROP TABLE IF EXISTS `rrd_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rrd_config` (
  `ctx` binary(16) NOT NULL,
  `profile` varchar(64) NOT NULL,
  `rrd_attrib` varchar(60) NOT NULL,
  `threshold` int(10) unsigned NOT NULL,
  `priority` int(10) unsigned NOT NULL,
  `alpha` float unsigned NOT NULL,
  `beta` float unsigned NOT NULL,
  `persistence` int(10) unsigned NOT NULL,
  `enable` tinyint(4) DEFAULT '1',
  `description` text,
  PRIMARY KEY (`ctx`,`profile`,`rrd_attrib`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sem_stats_events`
--

DROP TABLE IF EXISTS `sem_stats_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sem_stats_events` (
  `day` int(11) NOT NULL,
  `sensor` varchar(15) NOT NULL,
  `counter` int(11) NOT NULL,
  PRIMARY KEY (`day`,`sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor` (
  `id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `ip` varbinary(16) DEFAULT NULL,
  `priority` smallint(6) NOT NULL,
  `port` int(11) NOT NULL,
  `connect` smallint(6) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `tzone` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor_interfaces`
--

DROP TABLE IF EXISTS `sensor_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_interfaces` (
  `sensor_id` binary(16) NOT NULL,
  `interface` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `main` int(11) NOT NULL,
  PRIMARY KEY (`sensor_id`,`interface`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor_properties`
--

DROP TABLE IF EXISTS `sensor_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_properties` (
  `sensor_id` binary(16) NOT NULL,
  `version` varchar(64) NOT NULL,
  `has_nagios` tinyint(1) NOT NULL DEFAULT '1',
  `has_ntop` tinyint(1) NOT NULL DEFAULT '1',
  `has_vuln_scanner` tinyint(1) NOT NULL DEFAULT '1',
  `has_kismet` tinyint(1) NOT NULL DEFAULT '0',
  `ids` tinyint(1) NOT NULL DEFAULT '0',
  `passive_inventory` tinyint(1) NOT NULL DEFAULT '0',
  `netflows` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sensor_stats`
--

DROP TABLE IF EXISTS `sensor_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_stats` (
  `sensor_id` binary(16) NOT NULL,
  `events` int(11) NOT NULL DEFAULT '0',
  `os_events` int(11) NOT NULL DEFAULT '0',
  `mac_events` int(11) NOT NULL DEFAULT '0',
  `service_events` int(11) NOT NULL DEFAULT '0',
  `ids_events` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server` (
  `id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `ip` varbinary(16) DEFAULT NULL,
  `port` int(11) NOT NULL,
  `descr` varchar(255) NOT NULL,
  `remoteadmin` varchar(64) NOT NULL,
  `remotepass` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `remoteurl` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_forward_role`
--

DROP TABLE IF EXISTS `server_forward_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_forward_role` (
  `server_src_id` binary(16) NOT NULL,
  `server_dst_id` binary(16) NOT NULL,
  `priority` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`server_src_id`,`server_dst_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_hierarchy`
--

DROP TABLE IF EXISTS `server_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_hierarchy` (
  `child_id` binary(16) NOT NULL,
  `parent_id` binary(16) NOT NULL,
  PRIMARY KEY (`child_id`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_role`
--

DROP TABLE IF EXISTS `server_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_role` (
  `server_id` binary(16) NOT NULL,
  `correlate` tinyint(1) NOT NULL DEFAULT '1',
  `cross_correlate` tinyint(1) NOT NULL DEFAULT '1',
  `store` tinyint(1) NOT NULL DEFAULT '1',
  `qualify` tinyint(1) NOT NULL DEFAULT '1',
  `resend_alarm` tinyint(1) NOT NULL DEFAULT '1',
  `resend_event` tinyint(1) NOT NULL DEFAULT '1',
  `sign` int(10) unsigned NOT NULL DEFAULT '0',
  `sim` tinyint(1) NOT NULL DEFAULT '1',
  `sem` tinyint(1) NOT NULL DEFAULT '1',
  `alarms_to_syslog` tinyint(1) NOT NULL DEFAULT '0',
  `reputation` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(64) NOT NULL,
  `login` varchar(64) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `agent` varchar(255) NOT NULL,
  `logon_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`,`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signature`
--

DROP TABLE IF EXISTS `signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signature` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signature_group`
--

DROP TABLE IF EXISTS `signature_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signature_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `descr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signature_group_reference`
--

DROP TABLE IF EXISTS `signature_group_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signature_group_reference` (
  `signature_group_id` int(10) unsigned NOT NULL,
  `signature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`signature_group_id`,`signature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `software_cpe`
--

DROP TABLE IF EXISTS `software_cpe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_cpe` (
  `cpe` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `line` varchar(255) NOT NULL,
  `vendor` varchar(255) NOT NULL,
  `plugin` varchar(255) NOT NULL,
  PRIMARY KEY (`cpe`),
  KEY `line` (`line`),
  KEY `search` (`vendor`,`name`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `software_cpe_links`
--

DROP TABLE IF EXISTS `software_cpe_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_cpe_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `link` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vendor` (`vendor`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcategory_changes`
--

DROP TABLE IF EXISTS `subcategory_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategory_changes` (
  `id` int(11) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `admin_ip` varbinary(16) NOT NULL,
  `vpn_ip` varbinary(16) DEFAULT NULL,
  `profile` varchar(255) NOT NULL,
  `sensor_id` binary(16) DEFAULT NULL,
  `server_id` binary(16) DEFAULT NULL,
  `database_id` binary(16) DEFAULT NULL,
  `host_id` binary(16) DEFAULT NULL,
  `ha_ip` varbinary(16) DEFAULT NULL,
  `ha_name` varchar(64) DEFAULT '',
  `ha_role` varchar(32) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(128) NOT NULL,
  `type` varchar(32) NOT NULL,
  `class` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_inventory`
--

DROP TABLE IF EXISTS `task_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_inventory` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_type` int(11) DEFAULT NULL,
  `task_period` int(11) DEFAULT NULL,
  `task_enable` tinyint(1) DEFAULT NULL,
  `task_params` varchar(255) DEFAULT NULL,
  `task_sensor` binary(16) DEFAULT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  `task_targets` varchar(255) DEFAULT '',
  `task_last_run` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_component_filter`
--

DROP TABLE IF EXISTS `user_component_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_component_filter` (
  `session_id` varchar(64) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  `asset_type` varchar(32) NOT NULL,
  PRIMARY KEY (`session_id`,`asset_id`,`asset_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_config`
--

DROP TABLE IF EXISTS `user_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_config` (
  `login` varchar(64) NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT 'main',
  `name` varchar(255) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`login`,`category`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ctx_perm`
--

DROP TABLE IF EXISTS `user_ctx_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ctx_perm` (
  `login` varchar(64) NOT NULL,
  `ctx` binary(16) NOT NULL,
  PRIMARY KEY (`login`,`ctx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_host_filter`
--

DROP TABLE IF EXISTS `user_host_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_host_filter` (
  `session_id` varchar(64) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  PRIMARY KEY (`session_id`,`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_host_perm`
--

DROP TABLE IF EXISTS `user_host_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_host_perm` (
  `login` varchar(64) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  PRIMARY KEY (`login`,`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_net_perm`
--

DROP TABLE IF EXISTS `user_net_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_net_perm` (
  `login` varchar(64) NOT NULL,
  `asset_id` binary(16) NOT NULL,
  PRIMARY KEY (`login`,`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sensor_perm`
--

DROP TABLE IF EXISTS `user_sensor_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sensor_perm` (
  `login` varchar(64) NOT NULL,
  `sensor_id` binary(16) NOT NULL,
  PRIMARY KEY (`login`,`sensor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `login` varchar(64) NOT NULL,
  `ctx` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `name` varchar(128) NOT NULL,
  `pass` varchar(128) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `company` varchar(128) DEFAULT NULL,
  `department` varchar(128) DEFAULT NULL,
  `language` varchar(12) NOT NULL DEFAULT 'en_GB',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `first_login` tinyint(1) NOT NULL DEFAULT '1',
  `timezone` varchar(64) NOT NULL DEFAULT 'GMT',
  `last_pass_change` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_logon_try` datetime NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `template_id` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `uuid` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `expires` datetime NOT NULL DEFAULT '2200-01-01 00:00:00',
  `login_method` varchar(4) NOT NULL,
  `salt` text NOT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_hosts`
--

DROP TABLE IF EXISTS `vuln_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_hosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostip` varchar(40) DEFAULT NULL,
  `hostname` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(200) NOT NULL DEFAULT '',
  `status` varchar(45) NOT NULL DEFAULT '',
  `workgroup` varchar(25) DEFAULT NULL,
  `os` varchar(100) NOT NULL DEFAULT '',
  `site_code` varchar(25) NOT NULL,
  `ORG` varchar(25) DEFAULT NULL,
  `contact` varchar(45) NOT NULL DEFAULT '',
  `scanstate` varchar(25) DEFAULT NULL,
  `report_id` int(11) NOT NULL DEFAULT '0',
  `creport_id` int(11) NOT NULL DEFAULT '0',
  `lastscandate` datetime DEFAULT NULL,
  `createdate` datetime DEFAULT NULL,
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `hostip` (`hostip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_job_assets`
--

DROP TABLE IF EXISTS `vuln_job_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_job_assets` (
  `job_id` int(11) NOT NULL,
  `job_type` int(11) NOT NULL DEFAULT '0',
  `asset_id` binary(16) NOT NULL,
  PRIMARY KEY (`job_id`,`job_type`,`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_job_schedule`
--

DROP TABLE IF EXISTS `vuln_job_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_job_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fk_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `job_TYPE` enum('C','M','R','S') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'M' COMMENT 'CRON, MANUAL, REQ, SYSTEM',
  `schedule_type` enum('O','D','W','M','NW') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'M',
  `time_interval` smallint(5) unsigned NOT NULL DEFAULT '1',
  `day_of_week` enum('Su','Mo','Tu','We','Th','Fr','Sa') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Mo',
  `day_of_month` int(2) unsigned NOT NULL DEFAULT '1',
  `time` time NOT NULL DEFAULT '00:00:00',
  `email` text NOT NULL,
  `meth_TARGET` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meth_CRED` int(11) DEFAULT NULL,
  `meth_VSET` int(11) NOT NULL DEFAULT '1',
  `meth_CUSTOM` enum('N','A','R') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `meth_CPLUGINS` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meth_Wcheck` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meth_Wfile` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meth_Ucheck` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meth_TIMEOUT` int(11) DEFAULT '172800',
  `scan_ASSIGNED` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `next_CHECK` varchar(14) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `createdate` datetime DEFAULT NULL,
  `enabled` enum('0','1') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '1',
  `resolve_names` tinyint(1) NOT NULL DEFAULT '1',
  `IP_ctx` text,
  `credentials` varchar(128) NOT NULL,
  `begin` varchar(8) DEFAULT '',
  `exclude_ports` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_jobs`
--

DROP TABLE IF EXISTS `vuln_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `fk_name` varchar(50) DEFAULT NULL,
  `job_TYPE` char(1) NOT NULL DEFAULT 'M',
  `meth_SCHED` char(1) NOT NULL DEFAULT 'N',
  `meth_TARGET` text,
  `meth_CRED` int(11) DEFAULT NULL,
  `meth_VSET` int(11) NOT NULL DEFAULT '1',
  `meth_CUSTOM` enum('N','A','R') NOT NULL DEFAULT 'N',
  `meth_CPLUGINS` text,
  `meth_Wcheck` text,
  `meth_Wfile` text,
  `meth_Ucheck` text,
  `meth_TIMEOUT` int(6) NOT NULL DEFAULT '172800',
  `scan_ASSIGNED` varchar(64) DEFAULT NULL,
  `scan_SERVER` int(11) NOT NULL DEFAULT '0',
  `scan_START` datetime DEFAULT NULL,
  `scan_END` datetime DEFAULT NULL,
  `scan_SUBMIT` datetime DEFAULT NULL,
  `scan_NEXT` varchar(14) DEFAULT NULL,
  `scan_PID` int(11) NOT NULL DEFAULT '0',
  `scan_PRIORITY` tinyint(1) NOT NULL DEFAULT '3',
  `status` char(1) NOT NULL DEFAULT 'S',
  `notify` text NOT NULL,
  `report_id` int(11) NOT NULL DEFAULT '0',
  `tracker_id` int(11) DEFAULT NULL,
  `failed_attempts` tinyint(1) NOT NULL DEFAULT '0',
  `authorized` tinyint(1) NOT NULL DEFAULT '0',
  `author_uname` text,
  `resolve_names` tinyint(1) NOT NULL DEFAULT '1',
  `credentials` varchar(128) NOT NULL,
  `exclude_ports` text NOT NULL,
  PRIMARY KEY (`id`,`name`),
  KEY `name` (`name`),
  KEY `scan_END` (`scan_END`),
  KEY `report_id` (`report_id`),
  KEY `subnet` (`fk_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_category`
--

DROP TABLE IF EXISTS `vuln_nessus_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_category_feed`
--

DROP TABLE IF EXISTS `vuln_nessus_category_feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_category_feed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_family`
--

DROP TABLE IF EXISTS `vuln_nessus_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_family` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_family_feed`
--

DROP TABLE IF EXISTS `vuln_nessus_family_feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_family_feed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nname` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_latest_reports`
--

DROP TABLE IF EXISTS `vuln_nessus_latest_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_latest_reports` (
  `hostIP` varchar(40) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `sid` int(11) NOT NULL DEFAULT '0',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `fk_name` varchar(50) DEFAULT NULL,
  `scantime` varchar(14) NOT NULL DEFAULT '',
  `report_type` char(1) NOT NULL DEFAULT 'N',
  `scantype` char(1) NOT NULL DEFAULT 'M',
  `server_ip` varbinary(16) NOT NULL,
  `server_nversion` varchar(100) NOT NULL DEFAULT '',
  `server_feedtype` varchar(32) NOT NULL DEFAULT '',
  `server_feedversion` varchar(12) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `report_key` varchar(16) NOT NULL DEFAULT '',
  `report_path` varchar(255) DEFAULT NULL,
  `cred_used` varchar(25) DEFAULT NULL,
  `note` text,
  `failed` tinyint(1) NOT NULL DEFAULT '0',
  `results_sent` int(11) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hostIP`,`sid`,`username`,`ctx`),
  KEY `deleted` (`deleted`,`results_sent`),
  KEY `subnet` (`fk_name`),
  KEY `scantime` (`scantime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_latest_results`
--

DROP TABLE IF EXISTS `vuln_nessus_latest_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_latest_results` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `sid` int(11) NOT NULL DEFAULT '0',
  `scantime` varchar(14) NOT NULL DEFAULT '',
  `record_type` char(1) NOT NULL DEFAULT 'N',
  `hostIP` varchar(40) NOT NULL DEFAULT '',
  `ctx` binary(16) NOT NULL,
  `hostname` varchar(100) DEFAULT NULL,
  `service` varchar(40) NOT NULL DEFAULT '',
  `port` int(11) DEFAULT NULL,
  `protocol` varchar(5) DEFAULT NULL,
  `app` varchar(20) DEFAULT NULL,
  `scriptid` varchar(40) NOT NULL DEFAULT '',
  `risk` smallint(5) unsigned NOT NULL DEFAULT '1',
  `msg` text,
  `falsepositive` char(1) DEFAULT 'N',
  PRIMARY KEY (`result_id`),
  KEY `scantime` (`scantime`),
  KEY `scriptid` (`scriptid`),
  KEY `hostIP` (`hostIP`,`ctx`,`risk`),
  KEY `risk` (`risk`),
  KEY `falsepositive` (`falsepositive`,`risk`,`hostIP`,`ctx`),
  KEY `report_id` (`username`,`sid`),
  KEY `port` (`falsepositive`,`port`,`protocol`,`app`),
  KEY `hosts` (`falsepositive`,`hostIP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_plugins`
--

DROP TABLE IF EXISTS `vuln_nessus_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_plugins` (
  `id` int(11) NOT NULL DEFAULT '0',
  `oid` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  `copyright` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `description` blob,
  `cve_id` varchar(255) DEFAULT NULL,
  `bugtraq_id` varchar(255) DEFAULT NULL,
  `xref` blob,
  `enabled` char(1) NOT NULL DEFAULT '',
  `version` varchar(255) DEFAULT NULL,
  `created` varchar(14) DEFAULT NULL,
  `modified` varchar(14) DEFAULT NULL,
  `deleted` varchar(14) DEFAULT NULL,
  `category` int(11) NOT NULL DEFAULT '0',
  `family` int(11) NOT NULL DEFAULT '0',
  `risk` int(11) NOT NULL DEFAULT '0',
  `custom_risk` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_plugins_feed`
--

DROP TABLE IF EXISTS `vuln_nessus_plugins_feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_plugins_feed` (
  `id` int(11) NOT NULL DEFAULT '0',
  `oid` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  `copyright` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `description` blob,
  `cve_id` varchar(255) DEFAULT NULL,
  `bugtraq_id` varchar(255) DEFAULT NULL,
  `xref` blob,
  `enabled` char(1) NOT NULL DEFAULT '',
  `version` varchar(255) DEFAULT NULL,
  `created` varchar(14) DEFAULT NULL,
  `modified` varchar(14) DEFAULT NULL,
  `deleted` varchar(14) DEFAULT NULL,
  `category` int(11) NOT NULL DEFAULT '0',
  `family` int(11) NOT NULL DEFAULT '0',
  `risk` int(11) NOT NULL DEFAULT '0',
  `custom_risk` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_preferences`
--

DROP TABLE IF EXISTS `vuln_nessus_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_preferences` (
  `id` varchar(255) DEFAULT NULL,
  `nessus_id` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `type` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`nessus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_preferences_defaults`
--

DROP TABLE IF EXISTS `vuln_nessus_preferences_defaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_preferences_defaults` (
  `nessus_id` varchar(255) NOT NULL DEFAULT '',
  `nessusgroup` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `flag` char(1) DEFAULT NULL,
  PRIMARY KEY (`nessus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_report_stats`
--

DROP TABLE IF EXISTS `vuln_nessus_report_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_report_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `iHostCnt` int(4) NOT NULL DEFAULT '0',
  `dtLastScanned` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `iScantime` decimal(4,0) NOT NULL DEFAULT '0',
  `vExceptions` int(6) NOT NULL DEFAULT '0',
  `vSerious` int(6) NOT NULL DEFAULT '0',
  `vHigh` int(6) NOT NULL DEFAULT '0',
  `vMed` int(6) NOT NULL DEFAULT '0',
  `vMedLow` int(6) NOT NULL DEFAULT '0',
  `vLowMed` int(6) NOT NULL DEFAULT '0',
  `vLow` int(6) NOT NULL DEFAULT '0',
  `vInfo` int(6) NOT NULL DEFAULT '0',
  `trend` int(4) NOT NULL DEFAULT '0',
  `dtLastUpdated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  KEY `subnet` (`name`),
  KEY `dtLastScanned` (`dtLastScanned`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_reports`
--

DROP TABLE IF EXISTS `vuln_nessus_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `fk_name` varchar(50) DEFAULT NULL,
  `scantime` varchar(14) NOT NULL DEFAULT '',
  `report_type` char(1) NOT NULL DEFAULT 'N',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `scantype` char(1) NOT NULL DEFAULT 'M',
  `server_ip` varbinary(16) NOT NULL,
  `server_nversion` varchar(100) NOT NULL DEFAULT '',
  `server_feedtype` varchar(32) NOT NULL DEFAULT '',
  `server_feedversion` varchar(12) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `report_key` varchar(16) NOT NULL DEFAULT '',
  `report_path` varchar(255) DEFAULT NULL,
  `cred_used` varchar(25) DEFAULT NULL,
  `note` text,
  `failed` tinyint(1) NOT NULL DEFAULT '0',
  `results_sent` tinyint(2) NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`report_id`),
  KEY `subnet` (`fk_name`),
  KEY `scantime` (`scantime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_results`
--

DROP TABLE IF EXISTS `vuln_nessus_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_results` (
  `result_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL DEFAULT '0',
  `scantime` varchar(14) NOT NULL DEFAULT '',
  `record_type` char(1) NOT NULL DEFAULT 'N',
  `hostIP` varchar(40) NOT NULL DEFAULT '',
  `ctx` binary(16) NOT NULL,
  `hostname` varchar(100) DEFAULT NULL,
  `service` varchar(40) NOT NULL DEFAULT '',
  `port` int(11) DEFAULT NULL,
  `protocol` varchar(5) DEFAULT NULL,
  `app` varchar(20) DEFAULT NULL,
  `scriptid` varchar(40) NOT NULL DEFAULT '',
  `risk` enum('1','2','3','4','5','6','7') NOT NULL DEFAULT '1',
  `msg` text,
  `falsepositive` char(1) DEFAULT 'N',
  PRIMARY KEY (`result_id`),
  KEY `report_id` (`report_id`),
  KEY `scantime` (`scantime`),
  KEY `scriptid` (`scriptid`,`falsepositive`),
  KEY `hostIP` (`hostIP`),
  KEY `risk` (`risk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_servers`
--

DROP TABLE IF EXISTS `vuln_nessus_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '1241',
  `user` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `PASSWORD` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `server_nversion` varchar(100) NOT NULL DEFAULT '',
  `server_feedtype` varchar(32) NOT NULL DEFAULT '',
  `server_feedversion` varchar(12) NOT NULL DEFAULT '',
  `max_scans` int(11) NOT NULL DEFAULT '10',
  `current_scans` int(11) NOT NULL DEFAULT '0',
  `TYPE` char(1) NOT NULL DEFAULT '',
  `site_code` varchar(25) NOT NULL DEFAULT '',
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `checkin_time` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_settings`
--

DROP TABLE IF EXISTS `vuln_nessus_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `autoenable` char(1) NOT NULL DEFAULT 'N',
  `type` char(1) NOT NULL DEFAULT 'G',
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `auto_cat_status` int(10) NOT NULL DEFAULT '4',
  `auto_fam_status` int(10) NOT NULL DEFAULT '4',
  `update_host_tracker` tinyint(1) NOT NULL DEFAULT '0',
  `deleted` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_settings_category`
--

DROP TABLE IF EXISTS `vuln_nessus_settings_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_settings_category` (
  `sid` int(11) NOT NULL DEFAULT '0',
  `cid` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sid`,`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_settings_family`
--

DROP TABLE IF EXISTS `vuln_nessus_settings_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_settings_family` (
  `sid` int(11) NOT NULL DEFAULT '0',
  `fid` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sid`,`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_settings_plugins`
--

DROP TABLE IF EXISTS `vuln_nessus_settings_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_settings_plugins` (
  `id` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `enabled` char(1) NOT NULL DEFAULT 'Y',
  `category` int(11) NOT NULL DEFAULT '0',
  `family` int(11) NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_nessus_settings_preferences`
--

DROP TABLE IF EXISTS `vuln_nessus_settings_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_nessus_settings_preferences` (
  `sid` int(11) NOT NULL DEFAULT '0',
  `id` varchar(255) DEFAULT NULL,
  `nessus_id` varchar(255) NOT NULL DEFAULT '',
  `value` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `category` varchar(255) DEFAULT NULL,
  `type` char(1) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vuln_settings`
--

DROP TABLE IF EXISTS `vuln_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vuln_settings` (
  `settingID` int(11) NOT NULL AUTO_INCREMENT,
  `settingName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `settingValue` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `settingDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `settingSection` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `developerNotes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`settingID`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_interfaces`
--

DROP TABLE IF EXISTS `web_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_interfaces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctx` binary(16) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webservice`
--

DROP TABLE IF EXISTS `webservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webservice` (
  `id` binary(16) NOT NULL,
  `ctx` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `descr` varchar(256) NOT NULL,
  `type` varchar(32) NOT NULL,
  `source` enum('ticket') NOT NULL,
  `url` varchar(256) NOT NULL,
  `namespace` varchar(64) NOT NULL,
  `user` varchar(64) NOT NULL,
  `pass` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webservice_default`
--

DROP TABLE IF EXISTS `webservice_default`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webservice_default` (
  `ws_id` binary(16) NOT NULL,
  `field` varchar(64) NOT NULL,
  `value` varchar(512) NOT NULL,
  PRIMARY KEY (`ws_id`,`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webservice_operation`
--

DROP TABLE IF EXISTS `webservice_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webservice_operation` (
  `ws_id` binary(16) NOT NULL,
  `op` varchar(64) NOT NULL,
  `attrs` varchar(512) NOT NULL,
  `type` enum('insert','query','update','delete','auth') NOT NULL,
  PRIMARY KEY (`ws_id`,`op`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wireless_aps`
--

DROP TABLE IF EXISTS `wireless_aps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wireless_aps` (
  `mac` varchar(18) NOT NULL,
  `ssid` varchar(255) NOT NULL,
  `sensor` varbinary(16) NOT NULL,
  `nettype` varchar(32) NOT NULL,
  `info` varchar(255) NOT NULL,
  `channel` int(11) NOT NULL,
  `cloaked` enum('Yes','No') NOT NULL,
  `encryption` varchar(64) NOT NULL,
  `decrypted` enum('Yes','No') NOT NULL,
  `maxrate` float NOT NULL,
  `maxseenrate` int(11) NOT NULL,
  `beacon` int(11) NOT NULL,
  `llc` int(11) NOT NULL,
  `data` int(11) NOT NULL,
  `crypt` int(11) NOT NULL,
  `weak` int(11) NOT NULL,
  `dupeiv` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `carrier` varchar(32) NOT NULL,
  `encoding` varchar(32) NOT NULL,
  `firsttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lasttime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `bestquality` int(11) NOT NULL,
  `bestsignal` int(11) NOT NULL,
  `bestnoise` int(11) NOT NULL,
  `gpsminlat` float NOT NULL,
  `gpsminlon` float NOT NULL,
  `gpsminalt` float NOT NULL,
  `gpsminspd` float NOT NULL,
  `gpsmaxlat` float NOT NULL,
  `gpsmaxlon` float NOT NULL,
  `gpsmaxalt` float NOT NULL,
  `gpsmaxspd` float NOT NULL,
  `gpsbestlat` float NOT NULL,
  `gpsbestlon` float NOT NULL,
  `gpsbestalt` float NOT NULL,
  `datasize` int(11) NOT NULL,
  `iptype` varchar(32) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `notes` tinytext NOT NULL,
  PRIMARY KEY (`mac`,`ssid`,`sensor`),
  KEY `aps_mac_full` (`mac`),
  KEY `aps_sensor_full` (`sensor`),
  KEY `aps_ssid` (`ssid`),
  KEY `encryption` (`encryption`),
  KEY `cloaked` (`cloaked`),
  KEY `mac_sensor` (`mac`,`sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wireless_clients`
--

DROP TABLE IF EXISTS `wireless_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wireless_clients` (
  `client_mac` varchar(18) NOT NULL,
  `mac` varchar(18) NOT NULL,
  `ssid` varchar(255) NOT NULL,
  `sensor` varbinary(16) NOT NULL,
  `plugin_sid` int(11) NOT NULL,
  `channel` int(11) NOT NULL,
  `encryption` varchar(64) NOT NULL,
  `maxrate` float NOT NULL,
  `maxseenrate` int(11) NOT NULL,
  `llc` int(11) NOT NULL,
  `data` int(11) NOT NULL,
  `crypt` int(11) NOT NULL,
  `weak` int(11) NOT NULL,
  `dupeiv` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `type` varchar(32) NOT NULL,
  `encoding` varchar(32) NOT NULL,
  `firsttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lasttime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `gpsminlat` float NOT NULL,
  `gpsminlon` float NOT NULL,
  `gpsminalt` float NOT NULL,
  `gpsminspd` float NOT NULL,
  `gpsmaxlat` float NOT NULL,
  `gpsmaxlon` float NOT NULL,
  `gpsmaxalt` float NOT NULL,
  `gpsmaxspd` float NOT NULL,
  `datasize` int(11) NOT NULL,
  `iptype` varchar(32) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `notes` tinytext NOT NULL,
  PRIMARY KEY (`client_mac`,`mac`,`ssid`,`sensor`),
  KEY `clients_mac_full` (`mac`),
  KEY `clients_sensor_full` (`sensor`),
  KEY `clients_ssid` (`ssid`),
  KEY `client_mac_sensor_ssid` (`client_mac`,`sensor`,`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wireless_locations`
--

DROP TABLE IF EXISTS `wireless_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wireless_locations` (
  `location` varchar(100) NOT NULL,
  `user` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wireless_networks`
--

DROP TABLE IF EXISTS `wireless_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wireless_networks` (
  `ssid` varchar(255) NOT NULL,
  `sensor` varbinary(16) NOT NULL,
  `aps` int(11) NOT NULL,
  `clients` int(11) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `cloaked` varchar(15) NOT NULL,
  `firsttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lasttime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` varchar(255) NOT NULL,
  `type` enum('Un-Trusted','Trusted') NOT NULL,
  `notes` tinytext NOT NULL,
  `macs` tinytext NOT NULL,
  PRIMARY KEY (`ssid`,`sensor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wireless_sensors`
--

DROP TABLE IF EXISTS `wireless_sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wireless_sensors` (
  `sensor` varchar(64) NOT NULL,
  `location` varchar(100) NOT NULL,
  `model` varchar(150) NOT NULL,
  `serial` varchar(150) NOT NULL,
  `mounting_location` varchar(255) NOT NULL,
  `last_scraped` timestamp NULL DEFAULT NULL,
  `free_space` varchar(45) NOT NULL,
  `version` varchar(45) NOT NULL,
  `avg_signal` int(10) NOT NULL,
  PRIMARY KEY (`sensor`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-07 23:03:56
