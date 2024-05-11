-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 11, 2024 at 02:54 AM
-- Server version: 5.7.41
-- PHP Version: 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fsrp_core`
--

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
  `rating` text NOT NULL,
  `PermData` text NOT NULL,
  `LoginReward` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fsdb_characterdata`
--
ALTER TABLE `fsdb_characterdata`
  ADD PRIMARY KEY (`id`(15));
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
