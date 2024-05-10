-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 30, 2017 at 10:32 AM
-- Server version: 5.6.37
-- PHP Version: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Table structure for table `fs_bans`
--

CREATE TABLE `fs_bans` (
  `steamid` text NOT NULL,
  `ip` text NOT NULL,
  `expireddate` int(64) NOT NULL,
  `reason` text NOT NULL,
  `dateof` int(64) NOT NULL,
  `restrictip` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fs_orgs`
--

CREATE TABLE `fs_orgs` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `motd` text NOT NULL,
  `owner` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fs_vehicles`
--

CREATE TABLE `fs_vehicles` (
  `id` text NOT NULL,
  `entname` text NOT NULL,
  `bodygroups` text NOT NULL,
  `skins` int(11) NOT NULL,
  `color` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_characterdata`
--

CREATE TABLE `fsdb_characterdata` (
  `id` text NOT NULL,
  `business` text NOT NULL,
  `skills` text NOT NULL,
  `knownrecipes` text NOT NULL,
  `computer` text NOT NULL,
  `hatcoords` text NOT NULL,
  `rating` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_cooldowns`
--

CREATE TABLE `fsdb_cooldowns` (
  `steamid` text NOT NULL,
  `policequiz` int(6) UNSIGNED ZEROFILL NOT NULL DEFAULT '001800',
  `paramedicquiz` int(6) UNSIGNED ZEROFILL NOT NULL DEFAULT '001800'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_jobtime`
--

CREATE TABLE `fsdb_jobtime` (
  `steamid` text NOT NULL,
  `policetime` bigint(20) NOT NULL,
  `policerank` int(6) UNSIGNED ZEROFILL NOT NULL DEFAULT '000000',
  `paramedictime` bigint(20) NOT NULL,
  `paramedicrank` int(6) UNSIGNED ZEROFILL NOT NULL DEFAULT '000000'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_models`
--

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
  `mayor_bodygroups` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_physcol`
--

CREATE TABLE `fsdb_physcol` (
  `id` text NOT NULL,
  `col` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Table structure for table `fsdb_user`
--

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
  `ammo_pistol` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT '00000000000',
  `ammo_rifle` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT '00000000000',
  `ammo_shotgun` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT '00000000000',
  `ammo_sniper` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT '00000000000',
  `ammo_submachine` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT '00000000000',
  `bank_level` tinyint(4) NOT NULL DEFAULT '0',
  `adminrank` tinyint(4) NOT NULL DEFAULT '0',
  `LastPrimary` int(16) NOT NULL,
  `LastSecondary` int(16) NOT NULL,
  `LastHat` int(16) NOT NULL,
  `org` int(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fsrp_global`
--

CREATE TABLE `fsrp_global` (
  `time` double DEFAULT '5',
  `businessinfo` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fs_bans`
--
ALTER TABLE `fs_bans`
  ADD PRIMARY KEY (`steamid`(15));

--
-- Indexes for table `fs_orgs`
--
ALTER TABLE `fs_orgs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fsdb_characterdata`
--
ALTER TABLE `fsdb_characterdata`
  ADD PRIMARY KEY (`id`(15));

--
-- Indexes for table `fsdb_cooldowns`
--
ALTER TABLE `fsdb_cooldowns`
  ADD PRIMARY KEY (`steamid`(15));

--
-- Indexes for table `fsdb_jobtime`
--
ALTER TABLE `fsdb_jobtime`
  ADD PRIMARY KEY (`steamid`(15));

--
-- Indexes for table `fsdb_models`
--
ALTER TABLE `fsdb_models`
  ADD PRIMARY KEY (`uid`,`id`(15),`steamid`(15));

--
-- Indexes for table `fsdb_physcol`
--
ALTER TABLE `fsdb_physcol`
  ADD PRIMARY KEY (`id`(15));

--
-- Indexes for table `fsdb_user`
--
ALTER TABLE `fsdb_user`
  ADD PRIMARY KEY (`uid`,`id`(15),`steamid`(15));

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fs_orgs`
--
ALTER TABLE `fs_orgs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;--
-- Database: `rotospacest_messages`
--
CREATE TABLE `playerTags` (
    SteamID TEXT,
    PrvTags TEXT,
    PubTags TEXT
);

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_messenger`
--

CREATE TABLE `fsdb_messenger` (
  `ID` int(11) NOT NULL,
  `steamid` text NOT NULL,
  `name` text NOT NULL,
  `map` text NOT NULL,
  `pos` text NOT NULL,
  `ang` text NOT NULL,
  `upvotes` bigint(20) NOT NULL,
  `downvotes` bigint(20) NOT NULL,
  `permanent` tinyint(1) NOT NULL,
  `alwaysshow` tinyint(1) NOT NULL,
  `msg` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fsdb_messenger`
--
--
-- AUTO_INCREMENT for dumped tables
--
