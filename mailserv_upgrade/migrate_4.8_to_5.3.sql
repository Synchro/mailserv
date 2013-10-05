/* SQL script to update mailserv databases from version 4.8 to version 5.3 */
USE mail;
alter database mail CHARACTER SET utf8 COLLATE utf8_unicode_ci;

alter table administrators COLLATE=utf8_unicode_ci;

alter table admins COLLATE utf8_unicode_ci,
CHANGE `username` `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `password` `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `email` `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL;

alter table backups COLLATE utf8_unicode_ci,
CHANGE `encryption_key` `encryption_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
Change `location` `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL;

alter table domains COLLATE utf8_unicode_ci,
CHANGE `name` `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL;

alter table forwardings COLLATE utf8_unicode_ci,
CHANGE `source` `source` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `destination` `destination` text COLLATE utf8_unicode_ci NOT NULL;

alter table greylists COLLATE utf8_unicode_ci,
CHANGE `action`   `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `clause` `clause` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `value` `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `rcpt` `rcpt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `description` `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL;

CREATE TABLE `hostconfigs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interfaces` text COLLATE utf8_unicode_ci,
  `routes` text COLLATE utf8_unicode_ci,
  `nameservers` text COLLATE utf8_unicode_ci,
  `ntpservers` text COLLATE utf8_unicode_ci,
  `certificate` text COLLATE utf8_unicode_ci,
  `certificate_key` text COLLATE utf8_unicode_ci,
  `certificate_ca` text COLLATE utf8_unicode_ci,
  `hostname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

alter table licenses COLLATE utf8_unicode_ci,
CHANGE `hostname`  `hostname` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `code` `code` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL;

ALTER TABLE routings COLLATE utf8_unicode_ci,
CHANGE `destination`  `destination` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `transport` `transport` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL;

ALTER TABLE schema_migrations COLLATE utf8_unicode_ci,
CHANGE `version` `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL;

ALTER TABLE sessions COLLATE utf8_unicode_ci,
CHANGE `session_id` `session_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
CHANGE `data` `data` text COLLATE utf8_unicode_ci;

ALTER TABLE system_migrations COLLATE utf8_unicode_ci,
CHANGE `version` `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL;

ALTER TABLE userpref COLLATE utf8_unicode_ci,
CHANGE `username` `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `preference` `preference` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `value` `value` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `prefid` `prefid` int(11) NOT NULL AUTO_INCREMENT FIRST;

ALTER TABLE users COLLATE utf8_unicode_ci,
CHANGE `email` `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `name` `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `fullname` `fullname` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `password` `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `home` `home` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
CHANGE `policy_id` `policy_id` int(11) NOT NULL DEFAULT '1';

DROP TABLE IF EXISTS `vacations`;

ALTER TABLE whitelists COLLATE utf8_unicode_ci,
CHANGE `value` `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
CHANGE `description` `description` text COLLATE utf8_unicode_ci;

USE spamcontrol;

ALTER TABLE bayes_token ENGINE InnoDB;

USE webmail;

ALTER TABLE cache
DROP FOREIGN KEY `user_id_fk_cache`,
DROP `cache_id`,
CHANGE `user_id` `user_id` int(10) unsigned NOT NULL FIRST,
CHANGE `created` `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00';

ALTER TABLE cache
ADD CONSTRAINT `user_id_fk_cache` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

DROP TABLE IF EXISTS `cache_index`;

CREATE TABLE `cache_index` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `changed_index` (`changed`),
  CONSTRAINT `user_id_fk_cache_index` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `cache_messages`;

CREATE TABLE `cache_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  KEY `changed_index` (`changed`),
  CONSTRAINT `user_id_fk_cache_messages` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `cache_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_thread` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `changed_index` (`changed`),
  CONSTRAINT `user_id_fk_cache_thread` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `contactgroupmembers`
CHARSET utf8,
CHANGE `contact_id` `contact_id` int(10) unsigned NOT NULL,
DROP FOREIGN KEY contactgroup_id_fk_contactgroups,
DROP FOREIGN KEY contact_id_fk_contacts,
DROP KEY contact_id_fk_contacts,
ADD KEY `contactgroupmembers_contact_index` (`contact_id`);

ALTER TABLE `contactgroupmembers`
ADD CONSTRAINT `contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `contactgroups`
CHANGE `user_id` `user_id` int(10) unsigned NOT NULL;

ALTER TABLE `contacts`
CHANGE `changed` `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
CHANGE `email` `email` text NOT NULL,
CHANGE `vcard` `vcard` longtext,
CHANGE `user_id` `user_id` int(10) unsigned NOT NULL,
ADD `words` text AFTER `vcard`,
DROP FOREIGN KEY `user_id_fk_contacts`,
DROP KEY user_id_fk_contacts,
ADD KEY `user_contacts_index` (`user_id`,`del`);

ALTER TABLE `contacts`
ADD CONSTRAINT `user_id_fk_contacts` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `events_cache`;
DROP TABLE IF EXISTS `events_caldav`;

CREATE TABLE `dictionary` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `language` varchar(5) NOT NULL,
  `data` longtext NOT NULL,
  UNIQUE KEY `uniqueness` (`user_id`,`language`),
  CONSTRAINT `user_id_fk_dictionary` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `identities`
CHANGE `user_id` `user_id` int(10) unsigned NOT NULL AFTER `identity_id`,
CHANGE `changed` `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' AFTER `user_id`,
DROP FOREIGN KEY `user_id_fk_identities`,
ADD KEY `email_identities_index` (`email`,`del`);

ALTER TABLE `identities`
ADD CONSTRAINT `user_id_fk_identities` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

DROP TABLE IF EXISTS `notes`;
DROP TABLE IF EXISTS `reminders`;
DROP TABLE IF EXISTS `messages`;

CREATE TABLE `searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` int(3) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `data` text,
  PRIMARY KEY (`search_id`),
  UNIQUE KEY `uniqueness` (`user_id`,`type`,`name`),
  CONSTRAINT `user_id_fk_searches` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `session`
CHANGE `sess_id` `sess_id` varchar(128) NOT NULL,
CHANGE `created` `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
CHANGE `changed` `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
ADD KEY `changed_index` (`changed`);

CREATE TABLE `system` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `users`
DROP KEY `alias_index`,
DROP KEY `username_index`,
DROP `alias`,
CHANGE `username` `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
CHANGE `created` `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
CHANGE `last_login` `last_login` datetime DEFAULT NULL,
CHANGE `language` `language` varchar(5) DEFAULT NULL,
ADD UNIQUE KEY `username` (`username`,`mail_host`);
