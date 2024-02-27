-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2023 at 04:39 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `abs`
--

CREATE TABLE `abs` (
  `id_abs` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_mat` int(11) NOT NULL,
  `dept` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `motif` text NOT NULL DEFAULT 'Pas de justif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `abs`
--

INSERT INTO `abs` (`id_abs`, `id_user`, `id_mat`, `dept`, `semester`, `date`, `motif`) VALUES
(1, 26, 1, 0, 4, '2023-12-01 12:00:00', 'Maladie'),
(2, 26, 1, 0, 4, '2023-12-01 12:00:00', 'Malade'),
(3, 19, 1, 0, 2, '2023-12-01 12:00:00', 'Pas de justif'),
(4, 26, 0, 0, 4, '0000-00-00 00:00:00', 'Pas de justif'),
(5, 26, 0, 0, 4, '0000-00-00 00:00:00', 'Pas de justif'),
(6, 26, 0, 0, 4, '0000-00-00 00:00:00', 'Pas de justif'),
(7, 26, 0, 0, 4, '2023-12-01 13:00:00', 'Pas de justif'),
(8, 26, 0, 0, 4, '2023-12-01 14:00:00', 'Pas de justif'),
(9, 26, 0, 0, 4, '2023-12-01 15:00:00', 'Pas de justif'),
(10, 26, 0, 0, 4, '2023-12-01 13:00:00', 'Pas de justif'),
(11, 26, 0, 0, 4, '2023-12-01 14:00:00', 'Pas de justif'),
(12, 26, 0, 0, 4, '2023-12-01 15:00:00', 'Pas de justif');

-- --------------------------------------------------------

--
-- Table structure for table `calendrier`
--

CREATE TABLE `calendrier` (
  `id_seance` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `id_professeur` int(11) NOT NULL,
  `done` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `calendrier`
--

INSERT INTO `calendrier` (`id_seance`, `start`, `id_professeur`, `done`) VALUES
(1, '2023-12-01 12:00:00', 1, 1),
(2, '2023-12-01 13:00:00', 1, 0),
(3, '2023-12-01 14:00:00', 1, 0),
(4, '2023-12-01 15:00:00', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mat_bs`
--

CREATE TABLE `mat_bs` (
  `id_mat` int(11) NOT NULL,
  `nom` text NOT NULL,
  `VH` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `id_prof` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mat_bs`
--

INSERT INTO `mat_bs` (`id_mat`, `nom`, `VH`, `semester`, `id_prof`) VALUES
(1, 'Macro Economie', 36, 2, 8),
(2, 'Techniques Quantitatives 2', 36, 2, 9),
(3, 'Gestion', 36, 2, 10),
(4, 'Compatibilite', 36, 2, 11),
(5, 'francais', 36, 2, 12),
(6, 'anglais', 36, 2, 13),
(7, 'seminaires', 18, 2, 14);

-- --------------------------------------------------------

--
-- Table structure for table `mat_es`
--

CREATE TABLE `mat_es` (
  `id_mat` int(11) NOT NULL,
  `nom` text NOT NULL,
  `VH` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `id_prof` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mat_es`
--

INSERT INTO `mat_es` (`id_mat`, `nom`, `VH`, `semester`, `id_prof`) VALUES
(1, 'francais', 15, 4, 1),
(2, 'anglais', 30, 4, 2),
(3, 'RO', 45, 4, 3),
(4, 'droit', 30, 4, 4),
(5, 'Dev_Web', 30, 4, 5),
(6, 'Oracle', 45, 4, 6),
(7, 'Mobile ', 45, 4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `notes_bs`
--

CREATE TABLE `notes_bs` (
  `id_note_bs` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `note_Macro_Economie` float NOT NULL,
  `note_Techniques_Quantitatives_2` float NOT NULL,
  `note_Gestion` float NOT NULL,
  `note_francais` float NOT NULL,
  `note_anglais` float NOT NULL,
  `note_seminaires` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes_bs`
--

INSERT INTO `notes_bs` (`id_note_bs`, `id_user`, `note_Macro_Economie`, `note_Techniques_Quantitatives_2`, `note_Gestion`, `note_francais`, `note_anglais`, `note_seminaires`) VALUES
(1, 19, 12, 13, 19, 11, 15.5, 17);

-- --------------------------------------------------------

--
-- Table structure for table `notes_es`
--

CREATE TABLE `notes_es` (
  `id_note_es` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `note_francais` float NOT NULL,
  `note_anglais` float NOT NULL,
  `note_RO` float NOT NULL,
  `note_droit` float NOT NULL,
  `note_Dev_Web` float NOT NULL,
  `note_Oracle` float NOT NULL,
  `note_Mobile` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes_es`
--

INSERT INTO `notes_es` (`id_note_es`, `id_user`, `note_francais`, `note_anglais`, `note_RO`, `note_droit`, `note_Dev_Web`, `note_Oracle`, `note_Mobile`) VALUES
(1, 18, 15, 19, 20, 16.5, 17.5, 18.75, 18);

-- --------------------------------------------------------

--
-- Table structure for table `retard`
--

CREATE TABLE `retard` (
  `id_retard` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_mat` int(11) NOT NULL,
  `temps` int(11) NOT NULL DEFAULT 1,
  `dept` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `motif` text NOT NULL DEFAULT 'Pas de justif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `retard`
--

INSERT INTO `retard` (`id_retard`, `id_user`, `id_mat`, `temps`, `dept`, `semester`, `date`, `motif`) VALUES
(1, 27, 0, 1, 0, 4, '2023-12-01 12:00:00', 'Pas de justif'),
(2, 27, 1, 1, 0, 4, '2023-12-01 12:00:00', 'Pas de justif'),
(3, 19, 1, 10, 0, 2, '2023-12-01 12:00:00', 'Pas de justif');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nom` text NOT NULL,
  `prenom` text NOT NULL,
  `class` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `semester` int(11) NOT NULL,
  `etat` int(11) NOT NULL,
  `stage` int(11) NOT NULL,
  `campus` text NOT NULL,
  `dept` text NOT NULL,
  `role` text NOT NULL,
  `rachat` int(11) NOT NULL,
  `redoublant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `nom`, `prenom`, `class`, `email`, `password`, `semester`, `etat`, `stage`, `campus`, `dept`, `role`, `rachat`, `redoublant`) VALUES
(1, 'Sanae', 'Chraibi', '', 'fr', 'fr', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(2, 'anglais', 'anglais', '', 'ang', 'ang', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(3, 'Imad', 'Hafidi', '', 'hafidi', 'hafidi', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(4, 'Leslami', 'Leslami', '', 'Leslami', 'Leslami', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(5, 'Hernafi', 'Yassine', '', 'hernafi', 'hernafi', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(6, 'oracle', 'oracle', '', 'oracle', 'oracle', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(7, 'mobile', 'mobile', '', 'mobile', 'mobile', 4, 0, 0, 'Casa', 'ES', 'prof', 0, 0),
(8, 'macro', 'eco', '', 'macro', 'macro', 2, 0, 0, 'Casa ', 'BS', 'prof', 0, 0),
(9, 'Techniques_Quantitatives_2', 'Techniques_Quantitatives_2', '', 'analyse', 'analyse', 2, 0, 0, 'Casa', 'BS', 'prof', 0, 0),
(10, 'gestion', 'gestion', '', 'gestion', 'gestion', 2, 0, 0, 'Casa', 'BS', 'prof', 0, 0),
(11, 'Comptabilite', 'Comptabilite', '', 'Comptabilite', 'Comptabilite', 2, 0, 0, 'Casa', 'BS', 'prof', 0, 0),
(12, 'chraibi', 'houda', '', 'francais', 'francais', 2, 0, 0, 'Casa', 'BS', 'prof', 0, 0),
(13, 'anglais', 'anglais', '', 'anglais', 'anglais', 2, 0, 0, 'Casa', 'BS', 'prof', 0, 0),
(14, 'seminaire', 'seminaire', '', 'seminaire', 'seminaire', 2, 0, 0, 'Casa', 'BS', 'prof', 0, 0),
(18, 'simo', 'simo', '1', 'simo', 'simo', 4, 0, 0, 'Casa', 'ES', 'student', 0, 0),
(19, 'yahya', 'yahya', '1', 'yahya', 'yahya', 2, 0, 0, 'Casa', 'BS', 'student', 0, 0),
(20, 'jimmy', 'neutron', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'ES', 'student', 0, 0),
(21, 'jimmy1', 'neutron1', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'ES', 'student', 0, 0),
(22, 'jimmy2', 'neutron2', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'ES', 'student', 0, 0),
(23, 'jimmy3', 'neutron3', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'ES', 'student', 0, 0),
(24, 'jimmy3', 'neutron4', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'ES', 'student', 0, 0),
(25, 'tester1', 'neutron1', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'BS', 'student', 0, 0),
(26, 'tester2', 'neutron2', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'BS', 'student', 0, 0),
(27, 'tester3', 'neutron3', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'BS', 'student', 0, 0),
(28, 'tester4', 'neutron4', '1', 'secondrift2420@gmail.com', 'jimmy123', 4, 0, 0, 'Casa', 'BS', 'student', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `abs`
--
ALTER TABLE `abs`
  ADD PRIMARY KEY (`id_abs`),
  ADD KEY `fk_user_abs` (`id_user`);

--
-- Indexes for table `calendrier`
--
ALTER TABLE `calendrier`
  ADD PRIMARY KEY (`id_seance`),
  ADD KEY `id_professeur` (`id_professeur`);

--
-- Indexes for table `mat_bs`
--
ALTER TABLE `mat_bs`
  ADD PRIMARY KEY (`id_mat`),
  ADD KEY `fk_id_prof` (`id_prof`);

--
-- Indexes for table `mat_es`
--
ALTER TABLE `mat_es`
  ADD PRIMARY KEY (`id_mat`),
  ADD KEY `fk_id_prof_es` (`id_prof`);

--
-- Indexes for table `notes_bs`
--
ALTER TABLE `notes_bs`
  ADD PRIMARY KEY (`id_note_bs`),
  ADD KEY `fk_note_bs` (`id_user`);

--
-- Indexes for table `notes_es`
--
ALTER TABLE `notes_es`
  ADD PRIMARY KEY (`id_note_es`),
  ADD KEY `fk_note_es` (`id_user`);

--
-- Indexes for table `retard`
--
ALTER TABLE `retard`
  ADD PRIMARY KEY (`id_retard`),
  ADD KEY `fk_user_retard` (`id_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `abs`
--
ALTER TABLE `abs`
  MODIFY `id_abs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `calendrier`
--
ALTER TABLE `calendrier`
  MODIFY `id_seance` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mat_bs`
--
ALTER TABLE `mat_bs`
  MODIFY `id_mat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mat_es`
--
ALTER TABLE `mat_es`
  MODIFY `id_mat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `notes_bs`
--
ALTER TABLE `notes_bs`
  MODIFY `id_note_bs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notes_es`
--
ALTER TABLE `notes_es`
  MODIFY `id_note_es` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `retard`
--
ALTER TABLE `retard`
  MODIFY `id_retard` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `abs`
--
ALTER TABLE `abs`
  ADD CONSTRAINT `fk_user_abs` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `calendrier`
--
ALTER TABLE `calendrier`
  ADD CONSTRAINT `calendrier_ibfk_1` FOREIGN KEY (`id_professeur`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `mat_bs`
--
ALTER TABLE `mat_bs`
  ADD CONSTRAINT `fk_id_prof` FOREIGN KEY (`id_prof`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `mat_es`
--
ALTER TABLE `mat_es`
  ADD CONSTRAINT `fk_id_prof_es` FOREIGN KEY (`id_prof`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `notes_bs`
--
ALTER TABLE `notes_bs`
  ADD CONSTRAINT `fk_note_bs` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `notes_es`
--
ALTER TABLE `notes_es`
  ADD CONSTRAINT `fk_note_es` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Constraints for table `retard`
--
ALTER TABLE `retard`
  ADD CONSTRAINT `fk_user_retard` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
