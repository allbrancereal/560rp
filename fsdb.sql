
CREATE TABLE `fsdb_user` (
  `uid` bigint(11) NOT NULL,
  `id` text NOT NULL,
  `steamid` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `time_played` bigint(20) NOT NULL,
  `cash` bigint(20) NOT NULL,
  `bankcash` bigint(20) NOT NULL,
  `model` text NOT NULL,
  `inv` text NOT NULL,
  `ammo_pistol` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_rifle` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_shotgun` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_sniper` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_submachine` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `bank_level` TINYINT NOT NULL DEFAULT '0',
  `adminrank` TINYINT NOT NULL DEFAULT '0',

  PRIMARY KEY (`uid`,`id`(15),`steamid`(15))
)
ALTER TABLE `fsdb_user` ADD `LastPrimary` INT(16) NOT NULL AFTER `adminrank`, ADD `LastSecondary` INT(16) NOT NULL AFTER `LastPrimary`, ADD `LastHat` INT(16) NOT NULL AFTER `LastSecondary`;
CREATE TABLE `fsdb_models` (
  `uid` bigint(11) NOT NULL,
  `id` text NOT NULL,
  `steamid` text NOT NULL,
  `citizen_model` text NOT NULL,
  `citizen_skin` text NOT NULL,
  `citizen_bodygroups` text NOT NULL,
  `police` text NOT NULL,
  `police_skin` text NOT NULL,
  `police_bodygroups` text NOT NULL,
  `paramedic` text NOT NULL,
  `paramedic_skin` text NOT NULL,
  `paramedic_bodygroups` text NOT NULL,
  `mayor` text NOT NULL,
  `mayor_skin` text NOT NULL,
  `mayor_bodygroups` text NOT NULL,

  PRIMARY KEY (`uid`,`id`(15),`steamid`(15))
)
CREATE TABLE `fsdb_jobtime` (
  `steamid` text NOT NULL,
  `policetime` bigint(20) NOT NULL,
  `policerank` int(6) unsigned zerofill NOT NULL DEFAULT '00',
  `paramedictime` bigint(20) NOT NULL,
  `paramedicrank` int(6) unsigned zerofill NOT NULL DEFAULT '00',
  
  PRIMARY KEY (`uid`,`id`(15),`steamid`(15))
)
CREATE TABLE `rotospacest_gamemode`.`fs_bans` ( 
	`steamid` TEXT NOT NULL , 
	`ip` TEXT NOT NULL , 
	`expireddate` INT(64) NOT NULL , 
	`reason` TEXT NOT NULL , 
	`dateof` INT(64) NOT NULL , 
	`restrictip` BOOLEAN NOT NULL , 
	
	PRIMARY KEY (`steamid`(15))
) 

CREATE TABLE `fsdb_cooldowns` (
  `steamid` text NOT NULL,
  `policequiz` int(6) unsigned zerofill NOT NULL DEFAULT 1800,
  `paramedicquiz` int(6) unsigned zerofill NOT NULL DEFAULT 1800,

  
  PRIMARY KEY (`steamid`(15))
)
CREATE TABLE `fsdb_physcol` (
  `id` text NOT NULL,
  `col` text NOT NULL,
  
  PRIMARY KEY (`id`(15))
)
CREATE TABLE `fsdb_characterdata` (
  `id` text NOT NULL,
  `business` text NOT NULL,
  `skills` text NOT NULL,
  `knownrecipes` text NOT NULL,
  `computer` TEXT NOT NULL;
  
  PRIMARY KEY (`id`(15))
)


CREATE TABLE `fsrp_global` (
  `time` REAL DEFAULT 5,
  `businessinfo` text NOT NULL,

)
/*
SET `steamid` ='" .. _p:Nick() .. "' , `first_name` = '" .. _p:fsrp_getFirstName() .. "' , `last_name` = '" .. _p:fsrp_getLastName( ) .. "' ,`time_played`` = '" .. _p:fsrp_getTimePlayed() .. "' ,`cash` = '" .. _p:fsrp_getMoney() .. "' ,`model` = '" .. 1 .. "' ,`ammo_pistol` = '" .. _p:GetAmmoCount("pistol")  .. "' ,`ammo_rifle` = '" ..  _p:GetAmmoCount("smg1") .. "' ,`ammo_shotgun` = '" ..  _p:GetAmmoCount("buckshot")  .. "' ,`ammo_sniper` = '" ..  _p:GetAmmoCount("sniper")  .. "' ,`last_played` = '" .. _p:fsrp_getLastConnected() .. "' ,
 INSERT INTO `fsdb_users` (
	`id`,
    `uid`,
    `steamid`,
    `first_name`,
    `last_name`,
    `time_played`,
    `cash`,
    `model`,
    `ammo_pistol`,
    `ammo_rifle`,
    `ammo_shotgun`,
    `ammo_sniper`,
	`last_played`
)


CREATE TABLE `fsdb_messenger` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `steamid` text NOT NULL,
  `name` text NOT NULL,
  `map` text NOT NULL,
  `pos` text NOT NULL,
  `ang` text NOT NULL,
  `upvotes` bigint(20) NOT NULL,
  `downvotes` bigint(20) NOT NULL,
  `permanent` tinyint(1) NOT NULL,
  `alwaysshow` tinyint(1) NOT NULL,
  `msg` text NOT NULL,

  PRIMARY KEY (`ID`(20))
)
Values (
	``,
	``,
	``,
	``,
	``,
	``,
	``,
	``,
	``,
	``,
	``,
)

UPDATE `fsdb_user`` SET `steamid`='" .. _p:Nick() .. "',  WHERE `id`='" .. _p:SteamID() .. "';
	*/