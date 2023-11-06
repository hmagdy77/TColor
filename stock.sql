-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2023 at 10:00 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stock`
--

-- --------------------------------------------------------

--
-- Table structure for table `billinitems`
--

CREATE TABLE `billinitems` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billinitems`
--

INSERT INTO `billinitems` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', 'itemPriceOut', '1.0', '2', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(2, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', 'itemPriceOut', '1.0', '3', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(3, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', 'itemPriceOut', '1.0', '4', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 3, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(4, 'مذيب 14', '1', 'بدون مورد , بدون مورد', '100', 'itemPriceOut', '1000.0', '5', '1', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `billoutitems`
--

CREATE TABLE `billoutitems` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billoutitems`
--

INSERT INTO `billoutitems` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'test', '200', 'mine', '0.00', '1400.0', '96.1', '1', '13', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(2, 'test', '200', 'mine', '0.00', '1400.0', '12.0', '2', '13', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(3, 'test', '200', 'mine', '0.00', '1400.0', '13.0', '3', '13', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '', 4, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(4, 'test', '200', 'mine', '0.00', '1400.0', '11.0', '4', '13', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(5, 'test', '200', 'mine', '0.00', '1400.0', '12.0', '5', '13', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '', 4, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(6, 'ابيض جنرال', '9901', 'mine', '82770.000', '900000', '1000.0', '6', '11', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `billsfactory`
--

CREATE TABLE `billsfactory` (
  `bill_id` int(11) NOT NULL,
  `plan_id` varchar(50) NOT NULL DEFAULT 'work_num',
  `work_name` varchar(50) NOT NULL DEFAULT 'work_name',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `bill_sup` varchar(50) NOT NULL DEFAULT 'bill_sup',
  `bill_items` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_total` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_payment` double NOT NULL DEFAULT 0.1,
  `agent_name` varchar(100) NOT NULL DEFAULT 'agent_name',
  `agent_phone` varchar(20) NOT NULL DEFAULT 'agent_phone',
  `bill_notes` varchar(255) NOT NULL DEFAULT 'bill_notes',
  `bill_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billsfactory`
--

INSERT INTO `billsfactory` (`bill_id`, `plan_id`, `work_name`, `kind`, `bill_sup`, `bill_items`, `bill_total`, `bill_payment`, `agent_name`, `agent_phone`, `bill_notes`, `bill_timestamp`) VALUES
(1, 'work_num', 'work_name', 0, 'bill_sup', '0.0', '0.0', 0.1, 'agent_name', 'agent_phone', 'bill_notes', '2023-10-10 11:21:27'),
(2, '2', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(4, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(5, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(6, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(7, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(8, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(9, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(11, '3', '', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(12, '3', 'magdy', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(14, '4', 'magdy', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(15, '4', 'simsim', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-16 21:00:00'),
(16, '5', 'simsim', 1, 'sup', '1', '0.0', 0, 'agent_name', 'agent_phone', '', '2023-10-16 21:00:00'),
(18, 'work_num', 'work_name', 0, '', '0.0', '0.0', 0.1, 'agent_name', 'agent_phone', 'bill_notes', '2023-10-25 19:26:57'),
(19, '5', 'simsim', 1, 'sup', '4', '13.0', 0, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(20, '6', 'simsim', 1, 'sup', '2', '2.0', 0, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(21, 'work_num', 'work_name', 0, '', '0.0', '0.0', 0.1, 'agent_name', 'agent_phone', 'bill_notes', '2023-10-25 21:06:42');

-- --------------------------------------------------------

--
-- Table structure for table `billsfactoryitems`
--

CREATE TABLE `billsfactoryitems` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billsfactoryitems`
--

INSERT INTO `billsfactoryitems` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '9', 'stock_id', '0.0', '20.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(2, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '9', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(3, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '9', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(4, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '9', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(5, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.3', '2', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(6, 'test', '200', 'mine', '0.00', '1400.0', '1.300', '2', 'stock_id', '0.0', '25.500', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(7, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.3', '2', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(8, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.3', '2', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(13, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '4', 'stock_id', '0.0', '100.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(14, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '4', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(15, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '4', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(16, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '4', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(17, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '5', 'stock_id', '0.0', '100.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(18, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '5', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(19, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '5', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(20, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '5', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(21, 'test', '200', 'mine', '0.00', '1400.0', '1', '6', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(22, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '6', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(23, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '6', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(24, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '6', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(25, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '7', 'stock_id', '0.0', '1.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(26, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '7', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(27, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '7', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(28, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '7', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(29, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '8', 'stock_id', '0.0', '20.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(30, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '8', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(31, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '8', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(32, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '8', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(33, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '9', 'stock_id', '0.0', '1.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(34, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '9', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(35, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '9', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(36, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '9', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(41, 'test', '200', 'mine', '0.00', '1400.0', '1', '11', 'stock_id', '0.0', '10.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(42, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '11', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(43, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '11', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(44, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '11', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(45, 'test', '200', 'mine', '0.00', '1400.0', '1', '12', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(46, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '12', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(47, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '12', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(48, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '12', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(53, 'test', '200', 'mine', '0.00', '1400.0', '1.000', '14', 'stock_id', '0.0', '15.500', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(54, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', '14', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(55, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', '14', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(56, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', '14', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-09 21:00:00'),
(57, '1', '21', 'mine', '0.00', '12.0', '1', '15', 'stock_id', '0.0', '1000.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(58, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '1.0', '15', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(59, 'ابيض جنرال', '9901', 'mine', '82770.000', '900000', '1.500', '16', 'stock_id', '0.0', '1000.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(60, 'ايثانول', '3', 'مورد , بدون مورد', '100', '120', '96.0', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(61, 'مذيب 14', '1', 'بدون مورد , بدون مورد', '100', '120', '366.0', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(62, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '136.05', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(63, 'نيترو 3/4', '4', 'مورد , بدون مورد', '100', '120', '39.0', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(64, 'نينرو 120', '5', 'مورد , بدون مورد', '100', '120', '13.5', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(65, 'اسيتات', '2', 'مورد , بدون مورد', '100', '120', '96.0', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(66, 'فيو ماريك', '7', 'مورد , بدون مورد', '100', '120', '37.5', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(67, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '21.0', '16', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-16 21:00:00'),
(86, '22', '32', 'mine', '0.00', '23.0', '1.000', '19', 'stock_id', '0.0', '1000.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(87, '1', '21', 'mine', '0.00', '12.0', '10.000', '19', 'stock_id', '0.0', '1000.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(88, 'test', '200', 'mine', '0.00', '1400.0', '1', '19', 'stock_id', '0.0', '1000.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(89, 'ابيض جنرال', '9901', 'mine', '82770.000', '900000', '1.000', '19', 'stock_id', '0.0', '1000.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(90, 'test', '5654', 'frist ,  , ', '100', '1002', '1.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(91, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '100', '120', '20.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(92, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '10.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(93, 'ايثانول', '3', 'مورد , بدون مورد', '100', '120', '64.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(94, 'فيو ماريك', '7', 'مورد , بدون مورد', '100', '120', '25.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(95, 'نيترو 3/4', '4', 'مورد , بدون مورد', '100', '120', '26.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(96, 'مذيب 14', '1', 'بدون مورد , بدون مورد', '100', '120', '244.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(97, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '90.7', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(98, 'نينرو 120', '5', 'مورد , بدون مورد', '100', '120', '9.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(99, 'اسيتات', '2', 'مورد , بدون مورد', '100', '120', '64.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(100, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '14.0', '19', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(101, '1', '21', 'mine', '0.00', '12.0', '1', '20', 'stock_id', '0.0', '10.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(102, '22', '32', 'mine', '0.00', '23.0', '1', '20', 'stock_id', '0.0', '10.000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 2, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(103, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '1.0', '20', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(104, 'test', '5654', 'frist ,  , ', '100', '1002', '1.0', '20', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(105, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '100', '120', '20.0', '20', 'stock_id', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `billshortage`
--

CREATE TABLE `billshortage` (
  `bill_id` int(11) NOT NULL,
  `plan_id` varchar(50) NOT NULL DEFAULT 'work_num',
  `work_name` varchar(50) NOT NULL DEFAULT 'work_name',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `bill_sup` varchar(50) NOT NULL DEFAULT 'bill_sup',
  `bill_items` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_total` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_payment` double NOT NULL DEFAULT 0.1,
  `agent_name` varchar(100) NOT NULL DEFAULT 'agent_name',
  `agent_phone` varchar(20) NOT NULL DEFAULT 'agent_phone',
  `bill_notes` varchar(255) NOT NULL DEFAULT 'bill_notes',
  `bill_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billshortage`
--

INSERT INTO `billshortage` (`bill_id`, `plan_id`, `work_name`, `kind`, `bill_sup`, `bill_items`, `bill_total`, `bill_payment`, `agent_name`, `agent_phone`, `bill_notes`, `bill_timestamp`) VALUES
(1, '0', 'simsim', 1, '', '6', '600.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(2, 'work_num', 'work_name', 0, 'bill_sup', '0.0', '0.0', 0.1, 'agent_name', 'agent_phone', 'bill_notes', '2023-10-25 19:40:52');

-- --------------------------------------------------------

--
-- Table structure for table `billshortageitems`
--

CREATE TABLE `billshortageitems` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billshortageitems`
--

INSERT INTO `billshortageitems` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'test', '5654', 'frist ,  , ', '100', '1002', '100.0', '1', '16', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(2, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '100.0', '1', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(3, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '100', '120', '100.0', '1', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(4, 'بولي جلوس', '10', 'بدون مورد , مورد', '100.0', '120.0', '100.0', '1', '10', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(5, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '100.0', '1', '9', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(6, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '100.0', '1', '8', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `billsin`
--

CREATE TABLE `billsin` (
  `bill_id` int(11) NOT NULL,
  `plan_id` varchar(50) NOT NULL DEFAULT 'work_num',
  `work_name` varchar(50) NOT NULL DEFAULT 'work_name',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `bill_sup` varchar(50) NOT NULL DEFAULT 'bill_sup',
  `bill_items` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_total` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_payment` double NOT NULL DEFAULT 0.1,
  `agent_name` varchar(100) NOT NULL DEFAULT 'agent_name',
  `agent_phone` varchar(20) NOT NULL DEFAULT 'agent_phone',
  `bill_notes` varchar(255) NOT NULL DEFAULT 'bill_notes',
  `bill_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billsin`
--

INSERT INTO `billsin` (`bill_id`, `plan_id`, `work_name`, `kind`, `bill_sup`, `bill_items`, `bill_total`, `bill_payment`, `agent_name`, `agent_phone`, `bill_notes`, `bill_timestamp`) VALUES
(1, '0', '', 1, 'بدون مورد', '10', '1000000.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-08 21:00:00'),
(2, '0', '', 1, 'بدون مورد', '1', '100.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(3, '0', 'magdy', 1, 'بدون مورد', '1', '100.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(4, '0', 'magdy', 2, 'بدون مورد', '1', '100.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-09 21:00:00'),
(5, '0', 'simsim', 1, 'مورد', '1', '100000.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-16 21:00:00'),
(6, 'work_num', 'work_name', 0, 'bill_sup', '0.0', '0.0', 0.1, 'agent_name', 'agent_phone', 'bill_notes', '2023-10-17 12:46:18');

-- --------------------------------------------------------

--
-- Table structure for table `billsout`
--

CREATE TABLE `billsout` (
  `bill_id` int(11) NOT NULL,
  `plan_id` varchar(50) NOT NULL DEFAULT 'work_num',
  `work_name` varchar(50) NOT NULL DEFAULT 'work_name',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `bill_sup` varchar(50) NOT NULL DEFAULT 'bill_sup',
  `bill_items` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_total` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_payment` double NOT NULL DEFAULT 0.1,
  `agent_name` varchar(100) NOT NULL DEFAULT 'agent_name',
  `agent_phone` varchar(20) NOT NULL DEFAULT 'agent_phone',
  `bill_notes` varchar(255) NOT NULL DEFAULT 'bill_notes',
  `bill_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billsout`
--

INSERT INTO `billsout` (`bill_id`, `plan_id`, `work_name`, `kind`, `bill_sup`, `bill_items`, `bill_total`, `bill_payment`, `agent_name`, `agent_phone`, `bill_notes`, `bill_timestamp`) VALUES
(1, '0', 'work_name', 1, '', '1', '134540.0', 0.1, '', '', '', '2023-10-09 21:00:00'),
(2, '0', 'work_name', 1, '', '1', '16800.0', 0.1, '', '', '', '2023-10-09 21:00:00'),
(3, '0', 'work_name', 2, '', '1', '18200.0', 0.1, '', '', '', '2023-10-09 21:00:00'),
(4, '0', 'magdy', 1, '', '1', '15400.0', 0.1, '', '', '', '2023-10-09 21:00:00'),
(5, '0', 'magdy', 2, '', '1', '16800.0', 0.1, '', '', '', '2023-10-09 21:00:00'),
(6, '0', 'simsim', 1, '', '1', '900000000.0', 0.1, '', '', '', '2023-10-16 21:00:00'),
(7, 'work_num', 'work_name', 0, 'bill_sup', '0.0', '0.0', 0.1, '', '', 'bill_notes', '2023-10-17 13:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `billsstock`
--

CREATE TABLE `billsstock` (
  `bill_id` int(11) NOT NULL,
  `plan_id` varchar(50) NOT NULL DEFAULT 'work_num',
  `work_name` varchar(50) NOT NULL DEFAULT 'work_name',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `bill_sup` varchar(50) NOT NULL DEFAULT 'bill_sup',
  `bill_items` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_total` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_payment` double NOT NULL DEFAULT 0.1,
  `agent_name` varchar(100) NOT NULL DEFAULT 'agent_name',
  `agent_phone` varchar(20) NOT NULL DEFAULT 'agent_phone',
  `bill_notes` varchar(255) NOT NULL DEFAULT 'bill_notes',
  `bill_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billsstock`
--

INSERT INTO `billsstock` (`bill_id`, `plan_id`, `work_name`, `kind`, `bill_sup`, `bill_items`, `bill_total`, `bill_payment`, `agent_name`, `agent_phone`, `bill_notes`, `bill_timestamp`) VALUES
(1, '5', 'simsim', 1, 'مورد', '7', '7.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(2, 'plan', 'simsim', 2, 'forth', '1', '998.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(3, 'plan', 'simsim', 2, '', '1', '991.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(4, 'plan', 'simsim', 2, '', '1', '980.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(5, '5', 'simsim', 1, '', '1', '100.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(6, '5', 'simsim', 1, '', '1', '10.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(7, '6', 'simsim', 1, 'مورد', '2', '20.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-24 21:00:00'),
(8, '6', 'simsim', 1, 'مورد', '2', '4.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(9, '6', 'simsim', 1, 'مورد', '2', '20.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(10, '6', 'simsim', 1, 'مورد', '2', '50.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(11, '6', 'simsim', 1, 'مورد', '2', '11.5', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(12, '6', 'simsim', 1, 'مورد', '2', '2.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(13, '6', 'simsim', 1, 'مورد', '2', '2.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(14, '6', 'simsim', 1, 'مورد', '3', '35.0', 0.1, 'agent_name', 'agent_phone', '', '2023-10-25 21:00:00'),
(15, 'work_num', 'work_name', 0, 'bill_sup', '0.0', '0.0', 0.1, 'agent_name', 'agent_phone', 'bill_notes', '2023-10-25 21:25:57');

-- --------------------------------------------------------

--
-- Table structure for table `billstockitems`
--

CREATE TABLE `billstockitems` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `billstockitems`
--

INSERT INTO `billstockitems` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '1.0', '1', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(2, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '1.0', '1', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(3, 'بولي جلوس', '10', 'بدون مورد , مورد', '', 'itemPriceOut', '1.0', '1', '10', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(4, 'تيتانيوم', '9', 'مورد , بدون مورد', '', 'itemPriceOut', '1.0', '1', '9', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(5, 'كيتونك', '8', 'مورد , بدون مورد', '', 'itemPriceOut', '1.0', '1', '8', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(6, 'فيو ماريك', '7', 'مورد , بدون مورد', '', 'itemPriceOut', '1.0', '1', '7', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(7, 'عسل', '6', 'مورد , بدون مورد', '', 'itemPriceOut', '1.0', '1', '6', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(8, 'test', '5654', 'frist ,  , ', '', 'itemPriceOut', '998.0', '2', '16', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 3, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(9, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '991.0', '3', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 3, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(10, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '980.0', '4', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 3, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(11, 'اسيتات', '2', 'مورد , بدون مورد', '', 'itemPriceOut', '100.0', '5', '2', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(12, 'ايثانول', '3', 'مورد , بدون مورد', '', 'itemPriceOut', '10.0', '6', '3', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(13, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '1.0', '7', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(14, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '19.0', '7', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-24 21:00:00'),
(15, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '2.0', '8', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(16, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '2.0', '8', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(17, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '10.0', '9', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(18, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '10.0', '9', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(19, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '25.0', '10', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(20, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '25.0', '10', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(21, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '10.2', '11', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(22, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '1.3', '11', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(23, 'بولي جلوس', '10', 'بدون مورد , مورد', '', 'itemPriceOut', '1.0', '12', '10', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(24, 'تيتانيوم', '9', 'مورد , بدون مورد', '', 'itemPriceOut', '1.0', '12', '9', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(25, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '1.0', '13', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(26, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '1.0', '13', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(27, 'sub', '56', 'frist , second , third , بدون مورد', '', 'itemPriceOut', '12.0', '14', '15', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(28, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '', 'itemPriceOut', '13.0', '14', '14', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00'),
(29, 'بولي جلوس', '10', 'بدون مورد , مورد', '', 'itemPriceOut', '10.0', '14', '10', '0.0', '0.0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', 'plan_id', 1, '0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(2, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '14.0', 'bill_id', '8', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(3, 'اسيتات', '2', 'مورد , بدون مورد', '100', '120', '64.0', 'bill_id', '2', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(4, 'نينرو 120', '5', 'مورد , بدون مورد', '100', '120', '9.0', 'bill_id', '5', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(5, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '90.7', 'bill_id', '10', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(6, 'مذيب 14', '1', 'بدون مورد , بدون مورد', '100', '120', '244.0', 'bill_id', '1', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(8, 'نيترو 3/4', '4', 'مورد , بدون مورد', '100', '120', '26.0', 'bill_id', '4', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(9, 'فيو ماريك', '7', 'مورد , بدون مورد', '100', '120', '25.0', 'bill_id', '7', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(10, 'ايثانول', '3', 'مورد , بدون مورد', '100', '120', '64.0', 'bill_id', '3', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '9901', '0.0', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(77, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '1.0', 'bill_id', '15', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '21', '0.0', '0.0', '0.0', '0.0', '2023-10-11 02:41:14'),
(84, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '100', '120', '20.0', 'bill_id', '82', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '32', '0.0', '0.0', '0.0', '0.0', '2023-10-11 02:42:46'),
(85, 'test', '5654', 'frist ,  , ', '100', '1002', '1.0', 'bill_id', '81', '0', '0.0', '0.0', '0.0', '0.0', 'كجم', '1', 'plan_id', 1, '32', '0.0', '0.0', '0.0', '0.0', '2023-10-11 02:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'مذيب 14', '1', 'بدون مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '880', '0.0', '756', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:35:26'),
(2, 'اسيتات', '2', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '604', '0.0', '1036', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:35:46'),
(3, 'ايثانول', '3', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '697', '0.0', '946', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:36:09'),
(4, 'نيترو 3/4', '4', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '881', '0.0', '974', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:36:58'),
(5, 'نينرو 120', '5', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '958', '0.0', '991', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:37:14'),
(6, 'عسل', '6', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '875', '0.0', '1001', '3', '9', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:37:35'),
(7, 'فيو ماريك', '7', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '886', '0.0', '976', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:38:12'),
(8, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '1015', '0.0', '987', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:38:41'),
(9, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1', '1', 'stock_id', '327', '0.0', '1002', '3', '12', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:39:04'),
(10, 'بولي جلوس', '10', 'بدون مورد , مورد', '100.0', '120.0', '1', '1', 'stock_id', '657.899', '0.0', '921.3', '3.0', '12.0', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-09 11:39:27'),
(11, 'ابيض جنرال', '9901', 'mine', '82770.000', '900000', '1', '1', 'stock_id', '1002', '0', '1001', '3', '12', 'كجم', '1', 'plan_id', 2, '9901', '827.7', '0.0', '0.0', '0.0', '2023-10-09 11:45:13'),
(13, 'test', '200', 'mine', '0.00', '1400.0', '1', '1', 'stock_id', '1199.9', '100', '1010', '3.0', '12.0', 'كجم', '1', 'plan_id', 2, '200', '3.0', '0.0', '0.0', '0.0', '2023-10-09 17:39:17'),
(14, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '100', '120', '1', '1', 'stock_id', '1007.7', '0.0', '52.3', '3', '9', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-10 12:03:59'),
(15, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '1', '1', 'stock_id', '1028.8', '0.0', '60.2', '3.0', '12.0', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-10 12:06:42'),
(16, 'test', '5654', 'frist ,  , ', '100', '1002', '1', '1', 'stock_id', '1098', '0.0', '0', '3', '4', 'كجم', '1', 'plan_id', 1, 'number', '0', '0.0', '0.0', '0.0', '2023-10-10 15:44:23'),
(17, '1', '21', 'mine', '0.00', '12.0', '1', '1', 'stock_id', '2010', '0', '1010', '12.0', '33.0', 'كجم', '1', 'plan_id', 2, '21', '6.0', '0.0', '0.0', '0.0', '2023-10-11 02:25:00'),
(18, '22', '32', 'mine', '0.00', '23.0', '1', '1', 'stock_id', '1010', '0', '1006', '32.0', '23.0', 'كجم', '1', 'plan_id', 2, '32', '3.0', '0.0', '0.0', '0.0', '2023-10-11 02:41:41');

-- --------------------------------------------------------

--
-- Table structure for table `planitems`
--

CREATE TABLE `planitems` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL DEFAULT 'item_name',
  `item_num` varchar(100) NOT NULL DEFAULT 'item_num',
  `item_sup` varchar(100) NOT NULL DEFAULT 'item_suplr',
  `item_price_in` varchar(50) NOT NULL DEFAULT '0.0',
  `item_price_out` varchar(50) NOT NULL DEFAULT '0.0',
  `item_count` varchar(50) NOT NULL DEFAULT '0.0',
  `bill_id` varchar(50) NOT NULL DEFAULT 'bill_id',
  `stock_id` varchar(20) NOT NULL DEFAULT 'stock_id',
  `item_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_quant_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_sub_quant` varchar(50) NOT NULL DEFAULT '0.0',
  `item_min` varchar(50) DEFAULT '0.0',
  `item_max` varchar(50) NOT NULL DEFAULT '0.0',
  `item_pakage` varchar(15) NOT NULL DEFAULT 'item_pakage',
  `item_piec` varchar(10) NOT NULL DEFAULT 'item_piec',
  `plan_id` varchar(20) NOT NULL DEFAULT 'plan_id',
  `kind` tinyint(4) NOT NULL DEFAULT 0,
  `ingredients_number` varchar(50) NOT NULL DEFAULT '0',
  `item_wight` varchar(50) NOT NULL DEFAULT '0.0',
  `item_exchange` varchar(50) NOT NULL DEFAULT '0.0',
  `item_used` varchar(50) NOT NULL DEFAULT '0.0',
  `item_done` varchar(50) NOT NULL DEFAULT '0.0',
  `item_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `planitems`
--

INSERT INTO `planitems` (`item_id`, `item_name`, `item_num`, `item_sup`, `item_price_in`, `item_price_out`, `item_count`, `bill_id`, `stock_id`, `item_quant`, `item_quant_wight`, `item_sub_quant`, `item_min`, `item_max`, `item_pakage`, `item_piec`, `plan_id`, `kind`, `ingredients_number`, `item_wight`, `item_exchange`, `item_used`, `item_done`, `item_time`) VALUES
(1, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '1.0', 'bill_id', 'stock_id', '937.0', '0', '9.2', '0.0', '0.0', 'item_pakage', 'item_piec', '3', 1, '0', '0.0', '0', '8', '-1', '2023-10-10 12:11:53'),
(2, 'test', '200', 'mine', '0.00', '1400.0', '1.0', 'bill_id', 'stock_id', '-50.599999999999994', '10', '1', '0.0', '0.0', 'item_pakage', 'item_piec', '3', 2, '0', '0.0', '0', '-1', '105', '2023-10-10 12:11:53'),
(3, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '1.0', 'bill_id', 'stock_id', '705.899', '0', '9.200999999999976', '0.0', '0.0', 'item_pakage', 'item_piec', '3', 1, '0', '0.0', '0', '8', '-1', '2023-10-10 12:11:53'),
(4, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '1.0', 'bill_id', 'stock_id', '229.0', '0', '9.2', '0.0', '0.0', 'item_pakage', 'item_piec', '3', 1, '0', '0.0', '0', '8', '-1', '2023-10-10 12:11:53'),
(5, 'test', '200', 'mine', '0.00', '1400.0', '10.0', 'bill_id', 'stock_id', '184.39999999999998', '15.5', '2', '0.0', '0.0', 'item_pakage', 'item_piec', '4', 2, '0', '0.0', '0', '-1', '1', '2023-10-10 12:38:26'),
(6, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '10.0', 'bill_id', 'stock_id', '937.0', '0', '1.1999999999999993', '0.0', '0.0', 'item_pakage', 'item_piec', '4', 1, '0', '0.0', '0', '1', '-1', '2023-10-10 12:38:26'),
(7, 'تيتانيوم', '9', 'مورد , بدون مورد', '100', '120', '10.0', 'bill_id', 'stock_id', '229.0', '0', '1.1999999999999993', '0.0', '0.0', 'item_pakage', 'item_piec', '4', 1, '0', '0.0', '0', '1', '-1', '2023-10-10 12:38:26'),
(8, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '10.0', 'bill_id', 'stock_id', '705.899', '0', '1.2009999999999756', '0.0', '0.0', 'item_pakage', 'item_piec', '4', 1, '0', '0.0', '0', '1', '-1', '2023-10-10 12:38:26'),
(9, 'ايثانول', '3', 'مورد , بدون مورد', '100', '120', '96.0', 'bill_id', 'stock_id', '802.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '105', '160', '-64', '2023-10-17 12:37:26'),
(10, 'مذيب 14', '1', 'بدون مورد , بدون مورد', '100', '120', '366.0', 'bill_id', 'stock_id', '258.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '378', '610', '-244', '2023-10-17 12:37:26'),
(11, 'نينرو 120', '5', 'مورد , بدون مورد', '100', '120', '13.5', 'bill_id', 'stock_id', '972.0', '0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '14', '22.5', '-9', '2023-10-17 12:37:26'),
(12, 'نيترو 3/4', '4', 'مورد , بدون مورد', '100', '120', '39.0', 'bill_id', 'stock_id', '921.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '40', '65', '-26', '2023-10-17 12:37:26'),
(13, 'كيتونك', '8', 'مورد , بدون مورد', '100', '120', '21.0', 'bill_id', 'stock_id', '937.0', '0', '0.1999999999999993', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '22', '35', '-14', '2023-10-17 12:37:26'),
(14, 'اسيتات', '2', 'مورد , بدون مورد', '100', '120', '96.0', 'bill_id', 'stock_id', '799.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '195', '160', '-64', '2023-10-17 12:37:26'),
(15, 'بولي جلوس', '10', 'مورد , بدون مورد', '100', '120', '136.05', 'bill_id', 'stock_id', '705.899', '0', '0.20099999999997564', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '137', '226.75', '-90.7', '2023-10-17 12:37:26'),
(16, 'ابيض جنرال', '9901', 'mine', '82770.000', '900000', '1.5', 'bill_id', 'stock_id', '2', '2000', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 2, '0', '0.0', '0', '-1', '2.5', '2023-10-17 12:37:26'),
(17, 'فيو ماريك', '7', 'مورد , بدون مورد', '100', '120', '37.5', 'bill_id', 'stock_id', '924.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '5', 1, '0', '0.0', '38', '62.5', '-25', '2023-10-17 12:37:26'),
(18, '22', '32', 'mine', '0.00', '23.0', '1.0', 'bill_id', 'stock_id', '1000', '10', '1006', '0.0', '0.0', 'item_pakage', 'item_piec', '6', 2, '0', '0.0', '0', '0', '1', '2023-10-25 21:01:45'),
(19, '1', '21', 'mine', '0.00', '12.0', '1.0', 'bill_id', 'stock_id', '2000', '10', '1010', '0.0', '0.0', 'item_pakage', 'item_piec', '6', 2, '0', '0.0', '0', '0', '1', '2023-10-25 21:01:45'),
(20, 'test', '5654', 'frist ,  , ', '100', '1002', '1.0', 'bill_id', 'stock_id', '1098.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '6', 1, '0', '0.0', '0', '1', '0', '2023-10-25 21:01:45'),
(21, 'مورد', '125', 'مورد , بدون مورد , بدون مورد , مورد', '100', '120', '20.0', 'bill_id', 'stock_id', '1079.0', '0', '1.0', '0.0', '0.0', 'item_pakage', 'item_piec', '6', 1, '0', '0.0', '71.3', '20', '0', '2023-10-25 21:01:45'),
(22, 'sub', '56', 'frist , second , third , بدون مورد', '100.0', '120.0', '1.0', 'bill_id', 'stock_id', '1090.0', '0', '0.0', '0.0', '0.0', 'item_pakage', 'item_piec', '6', 1, '0', '0.0', '61.2', '1', '0', '2023-10-25 21:01:45');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'name',
  `work_name` varchar(255) NOT NULL DEFAULT 'work_name',
  `des` varchar(255) NOT NULL DEFAULT 'desc',
  `done` varchar(20) NOT NULL DEFAULT '0.0',
  `components` varchar(50) NOT NULL DEFAULT '0.0',
  `proudcts` varchar(50) NOT NULL DEFAULT '0.0',
  `exghange` varchar(50) NOT NULL DEFAULT '0.0',
  `components_done` varchar(50) NOT NULL DEFAULT '0.0',
  `proudcts_done` varchar(50) NOT NULL DEFAULT '0.0',
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `work_name`, `des`, `done`, `components`, `proudcts`, `exghange`, `components_done`, `proudcts_done`, `date`) VALUES
(1, '', '', '', '0', '4966.2', '3.0', '0', '2483.1', '1', '2023-10-09 11:54:00'),
(2, '', '', '', '0', '827.7', '1.0', '0', '37.4', '-138.6', '2023-10-09 12:38:00'),
(3, '', '', '', '0', '3.0', '1.0', '0', '23', '-91', '2023-10-10 12:11:00'),
(4, '', 'magdy', '', '0', '30.0', '10.0', '0', '3', '-97', '2023-10-10 12:38:00'),
(5, '', 'simsim', '', '0', '805.05', '1.5', '0', '1997.4499999999998', '-390', '2023-10-17 12:37:00'),
(6, 'testname', 'simsim', 'testndesc', '0', '22.0', '2.0', '135', '22', '2', '2023-10-25 21:01:00'),
(7, '', 'work_name', '', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '2023-10-25 21:01:45');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `sup_id` int(11) NOT NULL,
  `sup_name` varchar(100) NOT NULL DEFAULT 'sup_name',
  `sup_tel` varchar(20) NOT NULL DEFAULT 'sup_tel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`sup_id`, `sup_name`, `sup_tel`) VALUES
(1, 'مورد', '1'),
(2, 'بدون مورد', '2'),
(3, 'frist', '1'),
(4, 'second', '2'),
(5, 'third', '1'),
(6, 'forth', '2');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_name` varchar(100) NOT NULL DEFAULT 'user_name',
  `user_password` varchar(100) NOT NULL DEFAULT 'user_password',
  `user_kind` tinyint(4) NOT NULL DEFAULT 0,
  `user_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `user_name`, `user_password`, `user_kind`, `user_time`) VALUES
(1, 'simsim', 'admin', '123456', 1, '2023-03-24 22:10:55'),
(12, 'billsin', 'billsin', '123456', 2, '2023-10-10 13:07:20'),
(13, 'factory', 'factory', '123456', 3, '2023-10-10 13:23:41'),
(14, 'stock', 'stock', '123456', 4, '2023-10-10 13:35:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billinitems`
--
ALTER TABLE `billinitems`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `billoutitems`
--
ALTER TABLE `billoutitems`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `billsfactory`
--
ALTER TABLE `billsfactory`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `billsfactoryitems`
--
ALTER TABLE `billsfactoryitems`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `billshortage`
--
ALTER TABLE `billshortage`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `billshortageitems`
--
ALTER TABLE `billshortageitems`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `billsin`
--
ALTER TABLE `billsin`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `billsout`
--
ALTER TABLE `billsout`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `billsstock`
--
ALTER TABLE `billsstock`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `billstockitems`
--
ALTER TABLE `billstockitems`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `planitems`
--
ALTER TABLE `planitems`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`sup_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billinitems`
--
ALTER TABLE `billinitems`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `billoutitems`
--
ALTER TABLE `billoutitems`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billsfactory`
--
ALTER TABLE `billsfactory`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `billsfactoryitems`
--
ALTER TABLE `billsfactoryitems`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `billshortage`
--
ALTER TABLE `billshortage`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `billshortageitems`
--
ALTER TABLE `billshortageitems`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billsin`
--
ALTER TABLE `billsin`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billsout`
--
ALTER TABLE `billsout`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `billsstock`
--
ALTER TABLE `billsstock`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `billstockitems`
--
ALTER TABLE `billstockitems`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `planitems`
--
ALTER TABLE `planitems`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `sup_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
