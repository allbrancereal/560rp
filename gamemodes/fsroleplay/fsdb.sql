
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
  `ammo_pistol` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_rifle` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_shotgun` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `ammo_sniper` int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  `bank_level` TINYINT NOT NULL DEFAULT '0',

  PRIMARY KEY (`uid`,`id`(15),`steamid`(15))
)

CREATE TABLE `fsrptime` (
  `time` REAL DEFAULT 5
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