-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Sep 18, 2019 at 01:05 PM
-- Server version: 10.4.7-MariaDB-1:10.4.7+maria~bionic
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `EyesProject`
--
CREATE DATABASE IF NOT EXISTS `EyesProject` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `EyesProject`;

-- --------------------------------------------------------

--
-- Table structure for table `Image`
--
-- Creation: Sep 18, 2019 at 01:01 PM
--

DROP TABLE IF EXISTS `Image`;
CREATE TABLE `Image` (
  `idImage` int(11) NOT NULL,
  `pathImage` varchar(32) NOT NULL DEFAULT 'placeholder' COMMENT 'nom de l''image sur le disque',
  `widthImage` int(10) UNSIGNED NOT NULL COMMENT 'largeur de l''image en pixel',
  `heightImage` int(10) UNSIGNED NOT NULL COMMENT 'hauteur de l''image en pixel',
  `consigneImage` varchar(255) NOT NULL COMMENT 'Consigne que la personne doit suivre pour l''image'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Les informations des images';

-- --------------------------------------------------------

--
-- Table structure for table `ImageReconstruite`
--
-- Creation: Sep 18, 2019 at 12:56 PM
--

DROP TABLE IF EXISTS `ImageReconstruite`;
CREATE TABLE `ImageReconstruite` (
  `idImageReconstruite` int(11) NOT NULL,
  `pathImageReconstruite` varchar(32) NOT NULL DEFAULT 'placeholder' COMMENT 'nom de l''image sur le disque',
  `widthImageReconstruite` int(10) UNSIGNED NOT NULL COMMENT 'largeur de l''image en pixel',
  `heightImageReconstruite` int(10) UNSIGNED NOT NULL COMMENT 'hauteur de l''image en pixel',
  `idVisionnage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Les informations des images reconstruites';

-- --------------------------------------------------------

--
-- Table structure for table `Personne`
--
-- Creation: Sep 18, 2019 at 12:56 PM
--

DROP TABLE IF EXISTS `Personne`;
CREATE TABLE `Personne` (
  `idPersonne` int(11) NOT NULL,
  `emailPersonne` varchar(32) NOT NULL,
  `nomPersonne` varchar(32) NOT NULL,
  `prenomPersonne` varchar(32) NOT NULL,
  `sexePersonne` tinyint(1) NOT NULL COMMENT '0: masculin, 1: feminin',
  `age` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Point`
--
-- Creation: Sep 18, 2019 at 12:56 PM
--

DROP TABLE IF EXISTS `Point`;
CREATE TABLE `Point` (
  `idPoint` int(11) NOT NULL,
  `xPoint` int(10) UNSIGNED NOT NULL COMMENT 'coordonnee x sur l''image',
  `yPoint` int(10) UNSIGNED NOT NULL COMMENT 'coordonnee y sur l''image',
  `timestampPoint` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'moment d''apparition du point',
  `idSession` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Repertorie les points d''un visionnage - 0;0 en haut a gauche';

-- --------------------------------------------------------

--
-- Table structure for table `Session`
--
-- Creation: Sep 18, 2019 at 12:56 PM
--

DROP TABLE IF EXISTS `Session`;
CREATE TABLE `Session` (
  `idSession` int(11) NOT NULL,
  `dateSession` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'la date de la session',
  `dureeSession` int(10) UNSIGNED NOT NULL COMMENT 'duree de la session en secondes',
  `idPersonne` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informations sur une session';

-- --------------------------------------------------------

--
-- Table structure for table `Visionnage`
--
-- Creation: Sep 18, 2019 at 12:56 PM
--

DROP TABLE IF EXISTS `Visionnage`;
CREATE TABLE `Visionnage` (
  `idVisionnage` int(11) NOT NULL,
  `dureeVisionnage` tinyint(3) UNSIGNED NOT NULL COMMENT 'la duree du visionnage en secondes',
  `ordreVisionnage` tinyint(4) UNSIGNED NOT NULL COMMENT 'L''ordre du visionnage dans la session',
  `idSession` int(11) NOT NULL,
  `idImage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Image`
--
ALTER TABLE `Image`
  ADD PRIMARY KEY (`idImage`);

--
-- Indexes for table `ImageReconstruite`
--
ALTER TABLE `ImageReconstruite`
  ADD PRIMARY KEY (`idImageReconstruite`),
  ADD KEY `FK_IMAGERECONSTRUITE_VISIONNAGE` (`idVisionnage`);

--
-- Indexes for table `Personne`
--
ALTER TABLE `Personne`
  ADD PRIMARY KEY (`idPersonne`);

--
-- Indexes for table `Point`
--
ALTER TABLE `Point`
  ADD PRIMARY KEY (`idPoint`),
  ADD KEY `FK_POINT_VISIONNAGE` (`idSession`);

--
-- Indexes for table `Session`
--
ALTER TABLE `Session`
  ADD PRIMARY KEY (`idSession`),
  ADD KEY `FK_SESSION_PERSONNE` (`idPersonne`);

--
-- Indexes for table `Visionnage`
--
ALTER TABLE `Visionnage`
  ADD PRIMARY KEY (`idVisionnage`),
  ADD UNIQUE KEY `UQ_ordreVisionnage` (`idSession`,`ordreVisionnage`),
  ADD KEY `FK_VISIONNAGE_IMAGE` (`idImage`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Image`
--
ALTER TABLE `Image`
  MODIFY `idImage` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ImageReconstruite`
--
ALTER TABLE `ImageReconstruite`
  MODIFY `idImageReconstruite` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Personne`
--
ALTER TABLE `Personne`
  MODIFY `idPersonne` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Point`
--
ALTER TABLE `Point`
  MODIFY `idPoint` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Session`
--
ALTER TABLE `Session`
  MODIFY `idSession` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Visionnage`
--
ALTER TABLE `Visionnage`
  MODIFY `idVisionnage` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ImageReconstruite`
--
ALTER TABLE `ImageReconstruite`
  ADD CONSTRAINT `FK_IMAGERECONSTRUITE_VISIONNAGE` FOREIGN KEY (`idVisionnage`) REFERENCES `Visionnage` (`idVisionnage`);

--
-- Constraints for table `Point`
--
ALTER TABLE `Point`
  ADD CONSTRAINT `FK_POINT_VISIONNAGE` FOREIGN KEY (`idSession`) REFERENCES `Visionnage` (`idVisionnage`);

--
-- Constraints for table `Session`
--
ALTER TABLE `Session`
  ADD CONSTRAINT `FK_SESSION_PERSONNE` FOREIGN KEY (`idPersonne`) REFERENCES `Personne` (`idPersonne`);

--
-- Constraints for table `Visionnage`
--
ALTER TABLE `Visionnage`
  ADD CONSTRAINT `FK_VISIONNAGE_IMAGE` FOREIGN KEY (`idImage`) REFERENCES `Image` (`idImage`),
  ADD CONSTRAINT `FK_VISIONNAGE_SESSION` FOREIGN KEY (`idSession`) REFERENCES `Session` (`idSession`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
