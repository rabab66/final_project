-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2024 at 12:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rabab12`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `bookID` int(11) NOT NULL,
  `bookName` varchar(500) NOT NULL,
  `author` varchar(500) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`bookID`, `bookName`, `author`, `price`) VALUES
(1, 'morning in jenin book', 'susan abulhawa', 35),
(2, 'wonder', 'R.J Palacio', 30),
(3, 'Land Of Zicola', 'Amr Abdel Hamid', 40);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `caregoryID` int(11) NOT NULL,
  `cateroryName` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`caregoryID`, `cateroryName`) VALUES
(1, 'fiction'),
(2, 'scientific');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(500) NOT NULL,
  `email` varchar(255) NOT NULL,
  `createDataTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `password`, `name`, `email`, `createDataTime`) VALUES
(1, '1234567', 'rabab66 ', 'rababomar12@gamil.com ', '0000-00-00 00:00:00'),
(2, '234156789', 'jana', 'janan12@gmail.com', '2024-11-12 09:48:45'),
(3, 'Bob', '123', 'momo', '2024-11-12 09:58:19'),
(4, 'Bob', '123', 'momo', '2024-11-12 10:00:27'),
(5, 'Bob', '123', 'momo', '2024-11-12 10:01:49'),
(6, 'Bob', '123', 'momo', '2024-11-12 10:02:50'),
(7, 'Bob', '123', 'momo', '2024-11-12 10:03:39'),
(8, 'Bob', '123', 'momo', '2024-11-16 07:09:09'),
(9, 'Bob', '123', 'momo', '2024-11-16 07:10:32'),
(10, 'Bob', '123', 'momo', '2024-11-26 11:38:58'),
(11, 'rabab', '123456', 'rabab666666@rfghhhtj.com', '2024-11-26 11:40:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`bookID`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`caregoryID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `bookID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `caregoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
