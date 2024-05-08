-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 27, 2017 at 02:58 PM
-- Server version: 5.6.34
-- PHP Version: 5.6.26-pl0-gentoo

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `master_fsroleplay`
--

-- --------------------------------------------------------

--
-- Table structure for table `fsdb_user`
--

CREATE TABLE IF NOT EXISTS `fsdb_user` (
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
  `bank_level` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fsdb_user`
--

INSERT INTO `fsdb_user` (`uid`, `id`, `steamid`, `first_name`, `last_name`, `time_played`, `cash`, `bankcash`, `model`, `ammo_pistol`, `ammo_rifle`, `ammo_shotgun`, `ammo_sniper`, `bank_level`) VALUES
(1512008279, 'STEAM_0:1:24177118', '[560RP] fried rice', 'Jen', 'Bowman', 0, 70, 2316557, '1_1', 00000000000, 00000000000, 00000000000, 00000000000, 3);

-- --------------------------------------------------------

--
-- Table structure for table `fsrptime`
--

CREATE TABLE IF NOT EXISTS `fsrptime` (
  `time` double DEFAULT '5'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `fsrptime`
--

INSERT INTO `fsrptime` (`time`) VALUES
(1.99);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fsdb_user`
--
ALTER TABLE `fsdb_user`
  ADD PRIMARY KEY (`uid`,`id`(15),`steamid`(15));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
