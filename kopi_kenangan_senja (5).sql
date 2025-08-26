-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2025 at 01:23 PM
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
-- Database: `kopi_kenangan_senja`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `shipping_fee` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `va_number` varchar(50) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `fraud_status` enum('accept','challenge','deny') DEFAULT NULL,
  `status` enum('pending','settlement','capture','deny','cancel','expire','refund','processing','completed','cancelled') DEFAULT 'pending',
  `snap_token` varchar(255) DEFAULT NULL,
  `snap_redirect_url` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `transaction_time` datetime DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `voucher_id` int(11) DEFAULT NULL,
  `voucher_code` varchar(50) DEFAULT NULL,
  `voucher_discount` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_number`, `customer_name`, `email`, `phone`, `address`, `subtotal`, `shipping_fee`, `total`, `payment_method`, `va_number`, `bank`, `fraud_status`, `status`, `snap_token`, `snap_redirect_url`, `transaction_id`, `transaction_time`, `order_date`, `voucher_id`, `voucher_code`, `voucher_discount`) VALUES
(1, 2, 'KKS-1-663785', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyy', 33000.00, 15000.00, 48000.00, 'bank', NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, '2025-04-13 10:54:23', NULL, NULL, 0.00),
(2, 2, 'KKS-2-168888', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyyy', 56000.00, 15000.00, 71000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-16 08:29:28', NULL, NULL, 0.00),
(3, 2, 'KKS-3-665680', 'alul', 'alul12@gmail.com', '08124561451', 'abcddjhd', 112000.00, 15000.00, 127000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-16 08:54:25', NULL, NULL, 0.00),
(4, 2, 'KKS-4-147875', 'alul', 'alul12@gmail.com', '08124561451', 'adsas', 44000.00, 15000.00, 59000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-16 09:02:27', NULL, NULL, 0.00),
(5, 2, 'KKS-5-591131', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyyyyyyyyyyyyy', 140000.00, 15000.00, 155000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-18 06:59:51', NULL, NULL, 0.00),
(6, 2, 'KKS-6-296290', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyyy', 30000.00, 15000.00, 45000.00, '', NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, '2025-04-19 09:18:16', NULL, NULL, 0.00),
(7, 2, 'KKS-7-332269', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyyy', 30000.00, 15000.00, 45000.00, '', NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, '2025-04-19 09:18:52', NULL, NULL, 0.00),
(8, 2, 'KKS-8-654968', 'alul', 'alul12@gmail.com', '08124561451', 'anjayy', 56000.00, 15000.00, 71000.00, '', NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, '2025-04-19 09:24:14', NULL, NULL, 0.00),
(9, NULL, 'KKS-9-442376', 'alul', 'alul12@gmail.com', '08124561451', 'anjayy', 56000.00, 15000.00, 71000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 09:54:02', NULL, NULL, 0.00),
(10, 2, 'KKS-10-486338', 'alul', 'alul12@gmail.com', '08124561451', 'anjayy', 50000.00, 15000.00, 65000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 09:54:46', NULL, NULL, 0.00),
(11, 2, 'KKS-11-632770', 'alul', 'alul12@gmail.com', '08124561451', 'anjayy', 56000.00, 15000.00, 71000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 09:57:12', NULL, NULL, 0.00),
(12, 2, 'KKS-12-565941', 'alul', 'alul12@gmail.com', '08124561451', 'kapaoaihhus', 120000.00, 15000.00, 135000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 10:12:45', NULL, NULL, 0.00),
(13, 2, 'KKS-13-652221', 'alul', 'alul12@gmail.com', '08124561451', 'kp kamurang desa puspasari rt 01 07', 235000.00, 15000.00, 250000.00, 'ovo', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 15:47:32', NULL, NULL, 0.00),
(14, 2, 'KKS-14-946061', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyy', 84000.00, 15000.00, 99000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 15:52:26', NULL, NULL, 0.00),
(15, 2, 'KKS-15-787900', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyyy', 40000.00, 15000.00, 55000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-19 16:39:47', NULL, NULL, 0.00),
(16, 3, 'KKS-16-039782', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy testing124', 244000.00, 15000.00, 259000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-20 07:27:19', NULL, NULL, 0.00),
(17, 2, 'KKS-17-356315', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyyyy', 385000.00, 15000.00, 400000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-20 07:49:16', NULL, NULL, 0.00),
(18, 2, 'KKS-18-670803', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyy', 330000.00, 15000.00, 345000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-20 09:34:30', NULL, NULL, 0.00),
(19, 3, 'KKS-19-423388', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjaayy', 74000.00, 15000.00, 89000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-20 09:47:03', NULL, NULL, 0.00),
(20, 3, 'KKS-20-483081', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'jakarta selatan', 93000.00, 15000.00, 108000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-21 07:11:23', NULL, NULL, 0.00),
(21, 3, 'KKS-21-638733', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'jakarta selatan ', 545000.00, 15000.00, 560000.00, 'ovo', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-04-22 10:10:38', NULL, NULL, 0.00),
(22, 3, 'KKS-22-504010', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'desa sukahati citeurep bogor', 105000.00, 15000.00, 120000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-09 07:58:23', NULL, NULL, 0.00),
(23, 3, 'KKS-23-034017', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing 1234', 186000.00, 15000.00, 201000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-09 09:13:53', NULL, NULL, 0.00),
(24, 2, 'KKS-24-731369', 'alul', 'alul12@gmail.com', '08124561451', 'kp kamurang desa puspasari rt01/07 no 57 gangjempol citeureup bogor', 448000.00, 15000.00, 463000.00, 'gopay', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-09 13:52:11', NULL, NULL, 0.00),
(25, 4, 'KKS-25-216891', 'anindya ramadhani', 'anindya127@gmail.com', '0812456721451', 'depok', 173000.00, 15000.00, 188000.00, 'gopay', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-09 14:00:16', NULL, NULL, 0.00),
(26, NULL, 'KKS-26-581829', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy testing', 52000.00, 15000.00, 67000.00, 'gopay', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-11 07:46:21', NULL, NULL, 0.00),
(27, NULL, 'KKS-27-830448', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testinggga123', 78000.00, 15000.00, 93000.00, 'gopay', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-11 08:23:50', NULL, NULL, 0.00),
(28, NULL, 'KKS-28-016236', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingggg123', 56000.00, 15000.00, 71000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-11 08:26:56', NULL, NULL, 0.00),
(29, 3, 'KKS-29-095642', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing123\n', 44000.00, 15000.00, 59000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-11 09:01:35', NULL, NULL, 0.00),
(30, 3, 'KKS-30-713838', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testinggg', 120000.00, 15000.00, 135000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-11 11:41:53', NULL, NULL, 0.00),
(31, 3, 'KKS-31-507117', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy testing', 56000.00, 15000.00, 71000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 10:25:07', NULL, NULL, 0.00),
(32, 3, 'KKS-32-818257', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjay test ke 2', 154000.00, 15000.00, 169000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 10:46:58', NULL, NULL, 0.00),
(33, 3, 'KKS-33-018126', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'tesing ke2', 88000.00, 15000.00, 103000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 11:06:58', NULL, NULL, 0.00),
(34, 3, 'KKS-34-703498', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing page tsx', 84000.00, 15000.00, 99000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 11:18:23', NULL, NULL, 0.00),
(35, 3, 'KKS-35-197667', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingg', 44000.00, 15000.00, 59000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 11:26:37', NULL, NULL, 0.00),
(36, 3, 'KKS-36-559529', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test image', 44000.00, 15000.00, 59000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 11:49:19', NULL, NULL, 0.00),
(37, 3, 'KKS-37-815032', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testimg gk tau yang ke berapa', 120000.00, 15000.00, 135000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 12:26:54', NULL, NULL, 0.00),
(38, 3, 'KKS-38-903165', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing ', 112000.00, 15000.00, 127000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 12:28:23', NULL, NULL, 0.00),
(39, 3, 'KKS-39-562063', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'kp anjayy', 25000.00, 15000.00, 40000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 12:39:22', NULL, NULL, 0.00),
(40, 2, 'KKS-40-251624', 'alul', 'alul12@gmail.com', '08124561451', 'testing 124', 148000.00, 15000.00, 163000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 13:07:31', NULL, NULL, 0.00),
(41, 2, 'KKS-41-469239', 'alul', 'alul12@gmail.com', '08124561451', 'testing chekout 123', 168000.00, 15000.00, 183000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-12 13:11:09', NULL, NULL, 0.00),
(42, 3, 'KKS-42-307688', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'abcdefghijk', 50000.00, 15000.00, 65000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 12:15:07', NULL, NULL, 0.00),
(43, 3, 'KKS-43-818594', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 63000.00, 15000.00, 78000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 12:56:58', NULL, NULL, 0.00),
(44, 3, 'KKS-44-825978', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 45000.00, 15000.00, 60000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 13:13:45', NULL, NULL, 0.00),
(45, 3, 'KKS-45-281833', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 84000.00, 15000.00, 99000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 13:21:21', NULL, NULL, 0.00),
(46, 3, 'KKS-46-890585', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy 123', 44000.00, 15000.00, 59000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 13:31:30', NULL, NULL, 0.00),
(47, 3, 'KKS-47-190284', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy gurinjayy', 56000.00, 15000.00, 71000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 14:09:50', NULL, NULL, 0.00),
(48, 2, 'KKS-48-343622', 'alul', 'alul12@gmail.com', '08124561451', 'anjayy gurinjayy', 45000.00, 15000.00, 60000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 14:29:03', NULL, NULL, 0.00),
(49, 2, 'KKS-49-127377', 'alul', 'alul12@gmail.com', '08124561451', 'kp kamurang desa puspasari rt01/07 no57', 259000.00, 15000.00, 274000.00, 'ovo', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 14:42:07', NULL, NULL, 0.00),
(50, 3, 'KKS-50-746541', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test terakhir', 15000.00, 15000.00, 30000.00, 'cod', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 14:52:26', NULL, NULL, 0.00),
(51, 3, 'KKS-51-455961', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'vjhvuvujvj', 50000.00, 15000.00, 65000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-15 15:37:35', NULL, NULL, 0.00),
(52, 3, 'KKS-52-730590', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test error123', 84000.00, 15000.00, 99000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-16 09:12:10', NULL, NULL, 0.00),
(53, 3, 'KKS-53-864701', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingg123', 20000.00, 15000.00, 35000.00, 'dana', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-17 06:04:24', NULL, NULL, 0.00),
(54, 3, 'KKS-54-860689', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyy', 140000.00, 15000.00, 155000.00, 'bank', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, '2025-05-18 07:04:20', NULL, NULL, 0.00),
(55, 3, 'KKS-55-036921', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', 'f2b02c43-a801-4ec1-94cc-fe735e41039f', 'https://app.sandbox.midtrans.com/snap/v4/redirection/f2b02c43-a801-4ec1-94cc-fe735e41039f', NULL, NULL, '2025-05-18 07:40:36', NULL, NULL, 0.00),
(56, 3, 'KKS-56-103756', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '968c264a-ce37-493e-a8ee-70a3a2bfae49', 'https://app.sandbox.midtrans.com/snap/v4/redirection/968c264a-ce37-493e-a8ee-70a3a2bfae49', NULL, NULL, '2025-05-18 07:41:43', NULL, NULL, 0.00),
(57, 3, 'KKS-57-561152', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '3f978775-5ce5-476b-9722-d21d248f57ca', 'https://app.sandbox.midtrans.com/snap/v4/redirection/3f978775-5ce5-476b-9722-d21d248f57ca', NULL, NULL, '2025-05-18 07:49:21', NULL, NULL, 0.00),
(58, 3, 'KKS-58-684961', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '3cf2334f-518c-4692-89a7-c65d0f558d0d', 'https://app.sandbox.midtrans.com/snap/v4/redirection/3cf2334f-518c-4692-89a7-c65d0f558d0d', NULL, NULL, '2025-05-18 07:51:24', NULL, NULL, 0.00),
(59, 3, 'KKS-59-609092', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testtt', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '62fab1d3-1d9a-4edf-a66a-32bb8c334114', 'https://app.sandbox.midtrans.com/snap/v4/redirection/62fab1d3-1d9a-4edf-a66a-32bb8c334114', NULL, NULL, '2025-05-18 08:06:49', NULL, NULL, 0.00),
(60, 3, 'KKS-60-116931', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingg', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', 'b58703d1-0824-4ecd-9a92-27a6283360ea', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b58703d1-0824-4ecd-9a92-27a6283360ea', NULL, NULL, '2025-05-18 08:15:16', NULL, NULL, 0.00),
(61, 3, 'KKS-61-494579', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy\n', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', 'b4b883c1-cafe-43ee-b86e-d813bfacd98e', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b4b883c1-cafe-43ee-b86e-d813bfacd98e', NULL, NULL, '2025-05-18 08:21:34', NULL, NULL, 0.00),
(62, 3, 'KKS-62-309570', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 44000.00, 15000.00, 59000.00, 'bank', NULL, NULL, NULL, 'pending', 'b2d18265-5226-4bc4-b0c7-41168eb714b6', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b2d18265-5226-4bc4-b0c7-41168eb714b6', NULL, NULL, '2025-05-18 08:35:09', NULL, NULL, 0.00),
(63, 3, 'KKS-63-857812', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjay testing', 56000.00, 15000.00, 71000.00, 'all', NULL, NULL, NULL, 'pending', '310fd77b-353a-439a-959c-a1b4b927e440', 'https://app.sandbox.midtrans.com/snap/v4/redirection/310fd77b-353a-439a-959c-a1b4b927e440', NULL, NULL, '2025-05-18 08:44:17', NULL, NULL, 0.00),
(64, 3, 'KKS-64-093357', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 56000.00, 15000.00, 71000.00, 'all', NULL, NULL, NULL, 'pending', '6c21a5b9-b6b8-49d0-8ca3-8ec240b0e017', 'https://app.sandbox.midtrans.com/snap/v4/redirection/6c21a5b9-b6b8-49d0-8ca3-8ec240b0e017', NULL, NULL, '2025-05-18 08:48:13', NULL, NULL, 0.00),
(65, 3, 'KKS-65-324780', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', '1', 56000.00, 15000.00, 71000.00, 'all', NULL, NULL, NULL, 'pending', 'db49261e-d3de-4449-8f01-dcefd9172062', 'https://app.sandbox.midtrans.com/snap/v4/redirection/db49261e-d3de-4449-8f01-dcefd9172062', NULL, NULL, '2025-05-18 08:52:04', NULL, NULL, 0.00),
(66, 3, 'KKS-66-827037', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing', 22000.00, 15000.00, 37000.00, 'all', NULL, NULL, NULL, 'pending', '83f27975-b8eb-492c-bcb2-15e64a254d7b', 'https://app.sandbox.midtrans.com/snap/v4/redirection/83f27975-b8eb-492c-bcb2-15e64a254d7b', NULL, NULL, '2025-05-18 09:00:27', NULL, NULL, 0.00),
(67, 3, 'KKS-67-293543', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', '123', 22000.00, 15000.00, 37000.00, 'all', NULL, NULL, NULL, 'pending', '0e1328b1-b722-43eb-acc1-6cdf7e5844b7', 'https://app.sandbox.midtrans.com/snap/v4/redirection/0e1328b1-b722-43eb-acc1-6cdf7e5844b7', NULL, NULL, '2025-05-18 09:08:13', NULL, NULL, 0.00),
(68, 3, 'KKS-68-380906', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyy', 54000.00, 15000.00, 69000.00, 'all', NULL, NULL, NULL, 'pending', 'fe1cf6f7-36bf-4213-b0a7-b514e3bbaa67', 'https://app.sandbox.midtrans.com/snap/v4/redirection/fe1cf6f7-36bf-4213-b0a7-b514e3bbaa67', NULL, NULL, '2025-05-18 09:09:40', NULL, NULL, 0.00),
(69, 3, 'KKS-69-724551', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testtt', 54000.00, 15000.00, 69000.00, 'all', NULL, NULL, NULL, 'pending', '24a6d8ce-f1a3-498d-877f-bbd8a0355880', 'https://app.sandbox.midtrans.com/snap/v4/redirection/24a6d8ce-f1a3-498d-877f-bbd8a0355880', NULL, NULL, '2025-05-18 09:15:24', NULL, NULL, 0.00),
(70, 3, 'KKS-70-774581', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'assa', 54000.00, 15000.00, 69000.00, 'all', NULL, NULL, NULL, 'pending', '70ca9d47-505b-4ae5-bbe2-4f7614de2d7d', 'https://app.sandbox.midtrans.com/snap/v4/redirection/70ca9d47-505b-4ae5-bbe2-4f7614de2d7d', NULL, NULL, '2025-05-18 09:16:14', NULL, NULL, 0.00),
(71, 3, 'KKS-71-060396', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 84000.00, 15000.00, 99000.00, 'all', NULL, NULL, NULL, 'pending', '80964060-36fb-40eb-b9d4-9c86633fce32', 'https://app.sandbox.midtrans.com/snap/v4/redirection/80964060-36fb-40eb-b9d4-9c86633fce32', NULL, NULL, '2025-05-18 09:21:00', NULL, NULL, 0.00),
(72, 3, 'KKS-72-099228', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', '12212', 84000.00, 15000.00, 99000.00, 'all', NULL, NULL, NULL, 'pending', '4838c5fe-bb5b-4833-8418-06bcd55c144d', 'https://app.sandbox.midtrans.com/snap/v4/redirection/4838c5fe-bb5b-4833-8418-06bcd55c144d', NULL, NULL, '2025-05-18 09:21:39', NULL, NULL, 0.00),
(73, 3, 'KKS-73-394155', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 84000.00, 15000.00, 99000.00, 'all', NULL, NULL, NULL, 'pending', '37cf76b0-70eb-44a4-bd8e-e3eee7c86aa7', 'https://app.sandbox.midtrans.com/snap/v4/redirection/37cf76b0-70eb-44a4-bd8e-e3eee7c86aa7', NULL, NULL, '2025-05-18 09:26:34', NULL, NULL, 0.00),
(74, 3, 'KKS-74-445988', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', '12', 84000.00, 15000.00, 99000.00, 'all', NULL, NULL, NULL, 'pending', 'd9d3fc5b-2f23-421f-80f1-9d87cdc66a9a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/d9d3fc5b-2f23-421f-80f1-9d87cdc66a9a', NULL, NULL, '2025-05-18 09:27:25', NULL, NULL, 0.00),
(75, 3, 'KKS-75-523716', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'kjbkbkbk', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', 'eec06260-a842-480e-bbac-e223f45d5f44', 'https://app.sandbox.midtrans.com/snap/v4/redirection/eec06260-a842-480e-bbac-e223f45d5f44', NULL, NULL, '2025-05-18 09:28:43', NULL, NULL, 0.00),
(76, 3, 'KKS-76-548940', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'tguyu', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', '71648033-0658-482b-bd47-84ce184b5e2e', 'https://app.sandbox.midtrans.com/snap/v4/redirection/71648033-0658-482b-bd47-84ce184b5e2e', NULL, NULL, '2025-05-18 09:29:08', NULL, NULL, 0.00),
(77, 3, 'KKS-77-819186', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', 'd7c9e0d3-ad64-40b5-a0cd-1cc374df5392', 'https://app.sandbox.midtrans.com/snap/v4/redirection/d7c9e0d3-ad64-40b5-a0cd-1cc374df5392', NULL, NULL, '2025-05-18 09:33:39', NULL, NULL, 0.00),
(78, 3, 'KKS-78-867289', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'a', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', 'c61d14fc-8a4c-46ff-bcc3-b41edb82af0b', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c61d14fc-8a4c-46ff-bcc3-b41edb82af0b', NULL, NULL, '2025-05-18 09:34:27', NULL, NULL, 0.00),
(79, 3, 'KKS-79-959316', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'da', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', '0e35a9da-bead-4a50-b716-56a7ba165308', 'https://app.sandbox.midtrans.com/snap/v4/redirection/0e35a9da-bead-4a50-b716-56a7ba165308', NULL, NULL, '2025-05-18 09:35:59', NULL, NULL, 0.00),
(80, 3, 'KKS-80-015779', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'htd', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', 'c2a347d0-85ff-498d-b1b0-af06e2d7af0a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c2a347d0-85ff-498d-b1b0-af06e2d7af0a', NULL, NULL, '2025-05-18 09:36:55', NULL, NULL, 0.00),
(81, 3, 'KKS-81-629756', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'abcdef', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', 'e900930d-14b5-49a5-97d1-75134441fc7b', 'https://app.sandbox.midtrans.com/snap/v4/redirection/e900930d-14b5-49a5-97d1-75134441fc7b', NULL, NULL, '2025-05-18 11:10:29', NULL, NULL, 0.00),
(82, 3, 'KKS-82-848612', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testting', 90000.00, 15000.00, 105000.00, 'all', NULL, NULL, NULL, 'pending', '8a6719f8-5984-4458-8be1-68d5268feecc', 'https://app.sandbox.midtrans.com/snap/v4/redirection/8a6719f8-5984-4458-8be1-68d5268feecc', NULL, NULL, '2025-05-18 11:14:08', NULL, NULL, 0.00),
(83, 3, 'KKS-83-435040', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 53000.00, 15000.00, 68000.00, 'all', NULL, NULL, NULL, 'pending', '09e54a23-63e8-4c4f-8cd8-a1753468d69b', 'https://app.sandbox.midtrans.com/snap/v4/redirection/09e54a23-63e8-4c4f-8cd8-a1753468d69b', NULL, NULL, '2025-05-18 11:23:54', NULL, NULL, 0.00),
(84, 3, 'KKS-84-587934', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing', 30000.00, 15000.00, 45000.00, 'all', NULL, NULL, NULL, 'pending', 'b5209e4d-458a-49bd-a807-8b7dd977384a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b5209e4d-458a-49bd-a807-8b7dd977384a', NULL, NULL, '2025-05-18 11:26:27', NULL, NULL, 0.00),
(85, 3, 'KKS-85-995976', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testing', 126000.00, 15000.00, 141000.00, 'all', NULL, NULL, NULL, 'pending', 'cec6ff62-03e6-4a3e-9cc3-e1f5d2cf9912', 'https://app.sandbox.midtrans.com/snap/v4/redirection/cec6ff62-03e6-4a3e-9cc3-e1f5d2cf9912', NULL, NULL, '2025-05-18 11:33:15', NULL, NULL, 0.00),
(86, 3, 'KKS-86-876952', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testig', 126000.00, 15000.00, 141000.00, 'all', NULL, NULL, NULL, 'pending', 'c7d80968-9043-4485-8869-3241190f1c19', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c7d80968-9043-4485-8869-3241190f1c19', NULL, NULL, '2025-05-18 11:47:56', NULL, NULL, 0.00),
(87, 3, 'KKS-87-962452', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', '12221211', 126000.00, 15000.00, 141000.00, 'all', NULL, NULL, NULL, 'pending', '43f2d757-b92c-4ca4-974a-d8da8d6fff99', 'https://app.sandbox.midtrans.com/snap/v4/redirection/43f2d757-b92c-4ca4-974a-d8da8d6fff99', NULL, NULL, '2025-05-18 11:49:22', NULL, NULL, 0.00),
(88, 3, 'KKS-88-298545', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingggg', 126000.00, 15000.00, 141000.00, 'all', NULL, NULL, NULL, 'pending', '4c1d2424-81f4-4159-b7ca-1f806c78df99', 'https://app.sandbox.midtrans.com/snap/v4/redirection/4c1d2424-81f4-4159-b7ca-1f806c78df99', NULL, NULL, '2025-05-19 04:01:38', NULL, NULL, 0.00),
(89, 3, 'KKS-89-033202', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '94693c14-71cb-435a-834a-678db1308405', 'https://app.sandbox.midtrans.com/snap/v4/redirection/94693c14-71cb-435a-834a-678db1308405', NULL, NULL, '2025-05-19 04:13:53', NULL, NULL, 0.00),
(90, 3, 'KKS-90-936891', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', '111', 22000.00, 15000.00, 37000.00, 'all', '63891483837743065763419', 'bca', 'accept', 'settlement', '695ed862-e32c-471a-b994-b1649fa89d12', 'https://app.sandbox.midtrans.com/snap/v4/redirection/695ed862-e32c-471a-b994-b1649fa89d12', 'd3da1fbf-9806-4ba1-9b82-e00deb937cd3', '2025-05-19 11:28:58', '2025-05-19 04:28:56', NULL, NULL, 0.00),
(91, 3, 'KKS-91-159192', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testtt', 56000.00, 15000.00, 71000.00, 'all', '63891379747359497004454', 'bca', 'accept', 'settlement', 'a8657950-4c55-411c-b3ce-d7ee548473f2', 'https://app.sandbox.midtrans.com/snap/v4/redirection/a8657950-4c55-411c-b3ce-d7ee548473f2', '77195151-9a7c-484c-9820-25d9f7c6231c', '2025-05-19 11:32:39', '2025-05-19 04:32:39', NULL, NULL, 0.00),
(92, 3, 'KKS-92-475164', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aaa', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, 'accept', 'pending', '5782e197-2c8e-4f1d-9758-2ddd73e9f256', 'https://app.sandbox.midtrans.com/snap/v4/redirection/5782e197-2c8e-4f1d-9758-2ddd73e9f256', '2f184fe4-6f73-45d9-8101-0dc6db68e1b5', '2025-05-19 11:37:59', '2025-05-19 04:37:55', NULL, NULL, 0.00),
(93, 3, 'KKS-93-570530', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aaaaaaaaaaaaaaaaa', 28000.00, 15000.00, 43000.00, 'all', '63891651109045137099502', 'bca', 'accept', 'settlement', '32ca37ca-016c-4771-a68a-f953fbd9d33d', 'https://app.sandbox.midtrans.com/snap/v4/redirection/32ca37ca-016c-4771-a68a-f953fbd9d33d', '5d5db235-1237-4bcf-88b9-e4cc85731736', '2025-05-19 11:39:38', '2025-05-19 04:39:30', NULL, NULL, 0.00),
(94, 3, 'KKS-94-122470', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'Testingg', 50000.00, 15000.00, 65000.00, 'bank', NULL, NULL, NULL, 'pending', '8326ac79-8f8b-4415-94d5-e737084ebe47', 'https://app.sandbox.midtrans.com/snap/v4/redirection/8326ac79-8f8b-4415-94d5-e737084ebe47', NULL, NULL, '2025-05-19 04:48:42', NULL, NULL, 0.00),
(95, 3, 'KKS-95-064508', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test122222222222222222222222222222222222222', 316000.00, 15000.00, 331000.00, 'all', NULL, NULL, 'accept', 'settlement', '6ff15056-e9a7-42d7-9115-fae799a69836', 'https://app.sandbox.midtrans.com/snap/v4/redirection/6ff15056-e9a7-42d7-9115-fae799a69836', '72b4bd8b-925b-4b8a-a3d2-b50042d20f37', '2025-05-19 12:22:24', '2025-05-19 05:21:04', NULL, NULL, 0.00),
(96, 3, 'KKS-96-753620', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'kpkp', 82000.00, 15000.00, 97000.00, 'all', NULL, NULL, NULL, 'pending', '90e251ef-e2cc-4b05-b78c-47477b94e0be', 'https://app.sandbox.midtrans.com/snap/v4/redirection/90e251ef-e2cc-4b05-b78c-47477b94e0be', NULL, NULL, '2025-05-19 05:32:33', NULL, NULL, 0.00),
(97, 3, 'KKS-97-838524', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testt', 82000.00, 15000.00, 97000.00, 'all', NULL, NULL, 'accept', 'settlement', 'e4acf320-2080-4750-9fef-5c28039097cb', 'https://app.sandbox.midtrans.com/snap/v4/redirection/e4acf320-2080-4750-9fef-5c28039097cb', '23de806a-4688-466d-a1d8-78bdc37dd57d', '2025-05-19 12:34:42', '2025-05-19 05:33:58', NULL, NULL, 0.00),
(98, 3, 'KKS-98-423154', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'hhhh', 56000.00, 15000.00, 71000.00, 'all', '63891877556391449277040', 'bca', 'accept', 'settlement', '09d91972-feac-464b-8315-ba32479096e2', 'https://app.sandbox.midtrans.com/snap/v4/redirection/09d91972-feac-464b-8315-ba32479096e2', '8886f74d-7ff6-4a8e-8517-a045031a6c29', '2025-05-19 12:43:54', '2025-05-19 05:43:43', NULL, NULL, 0.00),
(99, 2, 'KKS-99-228146', 'alul', 'alul12@gmail.com', '08124561451', 'test', 22000.00, 15000.00, 37000.00, 'all', '63891243009427232015592', 'bca', 'accept', 'settlement', '5751e5ea-3677-4fa3-8cb9-54a58676a349', 'https://app.sandbox.midtrans.com/snap/v4/redirection/5751e5ea-3677-4fa3-8cb9-54a58676a349', '692a6089-44f1-4e9e-b837-d091c3bb007a', '2025-05-19 12:57:08', '2025-05-19 05:57:08', NULL, NULL, 0.00),
(100, 2, 'KKS-100-318841', 'alul', 'alul12@gmail.com', '08124561451', 'qqq', 28000.00, 15000.00, 43000.00, 'all', '63891664404579449708285', 'bca', 'accept', 'settlement', '4d4ea982-5f05-40a8-a563-909fa9451576', 'https://app.sandbox.midtrans.com/snap/v4/redirection/4d4ea982-5f05-40a8-a563-909fa9451576', '1e708baa-d697-4712-9f6b-98cfc67b12d8', '2025-05-19 12:58:38', '2025-05-19 05:58:38', NULL, NULL, 0.00),
(101, 2, 'KKS-101-447009', 'alul', 'alul12@gmail.com', '08124561451', 'test', 46000.00, 15000.00, 61000.00, 'all', '63891951490950491738046', 'bca', 'accept', 'settlement', '76453052-e133-4403-b9ee-d8793aaea915', 'https://app.sandbox.midtrans.com/snap/v4/redirection/76453052-e133-4403-b9ee-d8793aaea915', 'dec5428e-a2f1-44d4-b037-c8292e7d05fc', '2025-05-19 13:00:46', '2025-05-19 06:00:46', NULL, NULL, 0.00),
(102, 2, 'KKS-102-559178', 'alul', 'alul12@gmail.com', '08124561451', 'aaa', 22000.00, 15000.00, 37000.00, 'all', '63891167381572664800549', 'bca', 'accept', 'settlement', 'a20f9948-2af8-4c63-a871-0ad05f3b0b5c', 'https://app.sandbox.midtrans.com/snap/v4/redirection/a20f9948-2af8-4c63-a871-0ad05f3b0b5c', 'b424a617-8a73-4a14-afd5-3064301c36e4', '2025-05-19 13:02:40', '2025-05-19 06:02:39', NULL, NULL, 0.00),
(103, 2, 'KKS-103-610632', 'alul', 'alul12@gmail.com', '08124561451', 'asss', 18000.00, 15000.00, 33000.00, 'all', '63891780890539004504278', 'bca', 'accept', 'settlement', '9d9ab9b8-fb80-4ab8-9d70-ac861e87a7a0', 'https://app.sandbox.midtrans.com/snap/v4/redirection/9d9ab9b8-fb80-4ab8-9d70-ac861e87a7a0', 'cc956c93-92a9-467b-81eb-1248fa301bc1', '2025-05-19 13:03:32', '2025-05-19 06:03:30', NULL, NULL, 0.00),
(104, 3, 'KKS-104-441621', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 56000.00, 15000.00, 71000.00, 'all', NULL, NULL, NULL, 'pending', 'c08ea603-a575-4197-acf7-1fcde037186d', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c08ea603-a575-4197-acf7-1fcde037186d', NULL, NULL, '2025-05-20 00:37:21', NULL, NULL, 0.00),
(105, 3, 'KKS-105-096405', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'jkhkhk', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, 'accept', 'settlement', '57cc1577-7a9e-4fde-8529-e51944107b30', 'https://app.sandbox.midtrans.com/snap/v4/redirection/57cc1577-7a9e-4fde-8529-e51944107b30', '63b72789-26a6-472e-bc98-97d75ea93cc1', '2025-05-20 07:48:19', '2025-05-20 00:48:16', NULL, NULL, 0.00),
(106, 3, 'KKS-106-199767', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '59aed918-2f7a-4bb0-811b-f18c1ddc4de0', 'https://app.sandbox.midtrans.com/snap/v4/redirection/59aed918-2f7a-4bb0-811b-f18c1ddc4de0', NULL, NULL, '2025-05-20 08:53:19', NULL, NULL, 0.00),
(107, 3, 'KKS-107-232597', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aaaaaaaaaaaaaa', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', '3f7a0747-fca8-4c26-8885-7a8833f87b2b', 'https://app.sandbox.midtrans.com/snap/v4/redirection/3f7a0747-fca8-4c26-8885-7a8833f87b2b', NULL, NULL, '2025-05-20 08:53:52', NULL, NULL, 0.00),
(108, 3, 'KKS-108-706795', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 58000.00, 15000.00, 73000.00, 'all', NULL, NULL, NULL, 'pending', '740bcaee-3004-4abb-aa46-b3639ceb7494', 'https://app.sandbox.midtrans.com/snap/v4/redirection/740bcaee-3004-4abb-aa46-b3639ceb7494', NULL, NULL, '2025-05-20 09:18:26', NULL, NULL, 0.00),
(109, 3, 'KKS-109-838441', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aaaaaaaaaaaaaa', 58000.00, 15000.00, 73000.00, 'all', NULL, NULL, NULL, 'pending', 'fc83c4c6-4261-46c5-a29d-1321fd186f4d', 'https://app.sandbox.midtrans.com/snap/v4/redirection/fc83c4c6-4261-46c5-a29d-1321fd186f4d', NULL, NULL, '2025-05-20 09:20:38', NULL, NULL, 0.00),
(110, NULL, 'KKS-110-179862', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aaaaaaaaaaaa', 60000.00, 15000.00, 75000.00, 'all', NULL, NULL, NULL, 'pending', 'b77d8ace-c87b-40ce-a1bb-1108d0d2447e', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b77d8ace-c87b-40ce-a1bb-1108d0d2447e', NULL, NULL, '2025-05-20 09:26:19', NULL, NULL, 0.00),
(111, 3, 'KKS-111-291044', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'akakjkajkja', 28000.00, 15000.00, 43000.00, 'all', NULL, NULL, NULL, 'pending', 'aaeee350-be8f-487d-97b4-e9c803ab7cc0', 'https://app.sandbox.midtrans.com/snap/v4/redirection/aaeee350-be8f-487d-97b4-e9c803ab7cc0', NULL, NULL, '2025-05-20 09:28:11', NULL, NULL, 0.00),
(112, 3, 'KKS-112-780819', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'asaass', 30000.00, 15000.00, 45000.00, 'all', NULL, NULL, NULL, 'pending', 'b9b4c439-2a80-48c5-971a-c4c7d1212489', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b9b4c439-2a80-48c5-971a-c4c7d1212489', NULL, NULL, '2025-05-20 09:36:20', NULL, NULL, 0.00),
(113, 3, 'KKS-113-800691', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'jkkk', 30000.00, 15000.00, 45000.00, 'all', NULL, NULL, NULL, 'pending', '836d4247-de37-47d6-bd10-5c319d0299e0', 'https://app.sandbox.midtrans.com/snap/v4/redirection/836d4247-de37-47d6-bd10-5c319d0299e0', NULL, NULL, '2025-05-20 09:36:40', NULL, NULL, 0.00),
(114, 3, 'KKS-114-708606', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 22000.00, 15000.00, 37000.00, 'all', NULL, NULL, NULL, 'pending', '20e85546-9608-46a7-a50d-bbb581fe2989', 'https://app.sandbox.midtrans.com/snap/v4/redirection/20e85546-9608-46a7-a50d-bbb581fe2989', NULL, NULL, '2025-05-20 12:21:48', NULL, NULL, 0.00),
(115, 3, 'KKS-115-136607', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testt', 28000.00, 15000.00, 43000.00, 'bank_transfer', '63891915862251442012269', 'bca', 'accept', 'settlement', '233266e4-317b-4d89-b907-87580435a5ea', 'https://app.sandbox.midtrans.com/snap/v4/redirection/233266e4-317b-4d89-b907-87580435a5ea', '4a53570a-88c6-486d-9c3a-bdc6315b2658', '2025-05-20 19:28:55', '2025-05-20 12:28:56', NULL, NULL, 0.00),
(116, 2, 'KKS-116-518783', 'alul', 'alul12@gmail.com', '08124561451', 'testtt', 44000.00, 15000.00, 59000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '264a9a91-f84e-4c88-9036-650839b0e3a9', 'https://app.sandbox.midtrans.com/snap/v4/redirection/264a9a91-f84e-4c88-9036-650839b0e3a9', 'a0599dcb-efa3-4ddd-8480-82feb5c4afc4', '2025-05-20 20:08:53', '2025-05-20 13:08:38', NULL, NULL, 0.00),
(117, 2, 'KKS-117-642130', 'alul', 'alul12@gmail.com', '08124561451', 'test qris\n', 60000.00, 15000.00, 75000.00, 'qris', NULL, NULL, 'accept', 'settlement', '1263dd70-e7f4-47a2-ae8f-e7625e119286', 'https://app.sandbox.midtrans.com/snap/v4/redirection/1263dd70-e7f4-47a2-ae8f-e7625e119286', '706e644f-1735-4886-a617-593a6a71b01e', '2025-05-20 20:10:41', '2025-05-20 13:10:42', NULL, NULL, 0.00),
(118, 3, 'KKS-118-928569', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyy gurinjayy meledakkk', 44000.00, 15000.00, 59000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'f68490bc-5b9f-4150-9f63-00a0089f40d3', 'https://app.sandbox.midtrans.com/snap/v4/redirection/f68490bc-5b9f-4150-9f63-00a0089f40d3', '5406b0c1-ef3f-4515-809c-12eb22e0c164', '2025-05-21 13:12:16', '2025-05-21 06:12:08', NULL, NULL, 0.00),
(119, 3, 'KKS-119-035882', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyy testingg', 135000.00, 15000.00, 150000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '430bd6d6-0c92-47db-90b0-3a7658f67b21', 'https://app.sandbox.midtrans.com/snap/v4/redirection/430bd6d6-0c92-47db-90b0-3a7658f67b21', '111af85d-c544-4791-a40f-3c451baa7423', '2025-05-21 13:13:56', '2025-05-21 06:13:55', NULL, NULL, 0.00),
(120, 3, 'KKS-120-635162', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test anjayy', 104000.00, 15000.00, 119000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '29e526af-02c2-4ce7-8995-61689dd4386e', 'https://app.sandbox.midtrans.com/snap/v4/redirection/29e526af-02c2-4ce7-8995-61689dd4386e', '8bb2b563-ea6e-44ea-b821-3f80a9768427', '2025-05-22 20:47:14', '2025-05-22 13:47:15', NULL, NULL, 0.00),
(121, 3, 'KKS-121-350886', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyyy meledakkk', 117000.00, 15000.00, 132000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'c6faeb66-aee1-4164-bbd8-b3e2acf47b18', 'https://app.sandbox.midtrans.com/snap/v4/redirection/c6faeb66-aee1-4164-bbd8-b3e2acf47b18', '61179d03-0f9d-4b44-992c-bd5a3cd0be18', '2025-05-22 20:59:09', '2025-05-22 13:59:10', NULL, NULL, 0.00),
(122, 2, 'KKS-122-468138', 'alul', 'alul12@gmail.com', '08124561451', 'testingg', 44000.00, 15000.00, 59000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '7cb5a516-d85c-4ad9-98fc-63dee08c05a6', 'https://app.sandbox.midtrans.com/snap/v4/redirection/7cb5a516-d85c-4ad9-98fc-63dee08c05a6', 'd7f40197-491e-4236-ba7a-2ff8203ba466', '2025-05-22 21:01:05', '2025-05-22 14:01:08', NULL, NULL, 0.00),
(123, 2, 'KKS-123-041551', 'alul', 'alul12@gmail.com', '08124561451', 'test voucherr', 124000.00, 15000.00, 119000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'b22d61a3-b24b-4cd6-8bb8-1c62ca48bf33', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b22d61a3-b24b-4cd6-8bb8-1c62ca48bf33', '8e60ca8c-6284-4753-ab40-be615c7818ce', '2025-05-23 11:04:02', '2025-05-23 04:04:01', 8, 'ANGULAR20', 20000.00),
(124, 2, 'KKS-124-367094', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyy', 52000.00, 15000.00, 67000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '697cf94c-6325-4022-a6d4-2175d6dc52fd', 'https://app.sandbox.midtrans.com/snap/v4/redirection/697cf94c-6325-4022-a6d4-2175d6dc52fd', 'fc541a16-b0ea-45f3-9ff8-e47d1468f6fa', '2025-05-23 11:09:33', '2025-05-23 04:09:27', NULL, NULL, 0.00),
(125, 3, 'KKS-125-569901', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testtt', 114000.00, 15000.00, 129000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '0b480ddb-96d6-437a-b191-545d8f8b2f5f', 'https://app.sandbox.midtrans.com/snap/v4/redirection/0b480ddb-96d6-437a-b191-545d8f8b2f5f', '4b71fa5b-9ab5-44d9-945d-6323b1bfebef', '2025-05-23 12:52:47', '2025-05-23 05:52:49', NULL, NULL, 0.00),
(126, 3, 'KKS-126-696532', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aa', 114000.00, 15000.00, 129000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '9efa23e5-fd82-42ea-aa25-9b992c05ec9a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/9efa23e5-fd82-42ea-aa25-9b992c05ec9a', 'c06d13d5-9d41-4ac8-b152-d52812a258d9', '2025-05-23 12:54:53', '2025-05-23 05:54:56', NULL, NULL, 0.00),
(127, 3, 'KKS-127-754376', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testt', 25000.00, 15000.00, 40000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '66829194-4eb1-488f-b6d4-f337c15fb5db', 'https://app.sandbox.midtrans.com/snap/v4/redirection/66829194-4eb1-488f-b6d4-f337c15fb5db', '8cafa645-8e11-4569-96ac-882614186536', '2025-05-23 12:55:51', '2025-05-23 05:55:54', NULL, NULL, 0.00),
(128, 2, 'KKS-128-897978', 'alul', 'alul12@gmail.com', '08124561451', 'testtt', 60000.00, 15000.00, 69000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'de34007f-379c-4818-b09a-b4f5cba54868', 'https://app.sandbox.midtrans.com/snap/v4/redirection/de34007f-379c-4818-b09a-b4f5cba54868', '7ce8fa00-ffb9-4f9b-98b2-aed436aafbef', '2025-05-23 12:58:15', '2025-05-23 05:58:17', 7, 'FLUTTER10', 6000.00),
(129, 2, 'KKS-129-062076', 'alul', 'alul12@gmail.com', '08124561451', 'uhihihih', 60000.00, 15000.00, 66000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '2e1205d4-a31d-4776-98d2-3392aa34bd44', 'https://app.sandbox.midtrans.com/snap/v4/redirection/2e1205d4-a31d-4776-98d2-3392aa34bd44', 'a260cb85-be3d-4ee2-b41d-ce5a02168a00', '2025-05-23 13:01:25', '2025-05-23 06:01:01', 5, 'JAVASCRIPT', 9000.00),
(130, NULL, 'KKS-130-074200', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 142000.00, 15000.00, 145000.00, 'bank_transfer', '63891880185931940919307', 'bca', 'accept', 'settlement', '15ef2ea8-7ac6-43b9-bc74-67e193ea56bf', 'https://app.sandbox.midtrans.com/snap/v4/redirection/15ef2ea8-7ac6-43b9-bc74-67e193ea56bf', 'b73f77d3-0de5-4179-b382-2e2bb4a5531d', '2025-05-23 13:34:49', '2025-05-23 06:34:34', 7, 'FLUTTER10', 12000.00),
(131, 3, 'KKS-131-252074', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'test', 330000.00, 15000.00, 325000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '4cbb1abf-2bec-423e-82a5-ee577710e661', 'https://app.sandbox.midtrans.com/snap/v4/redirection/4cbb1abf-2bec-423e-82a5-ee577710e661', '1439569b-0aec-4674-afc0-d1dfd29477b1', '2025-05-23 13:37:39', '2025-05-23 06:37:32', 8, 'ANGULAR20', 20000.00),
(132, 3, 'KKS-132-087319', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingg', 108000.00, 15000.00, 108240.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'da1d3b11-14e5-41f5-9522-04698d57f732', 'https://app.sandbox.midtrans.com/snap/v4/redirection/da1d3b11-14e5-41f5-9522-04698d57f732', '2e78bb88-ad0e-49ce-adf5-2020be83d84c', '2025-05-23 13:51:25', '2025-05-23 06:51:27', 5, 'JAVASCRIPT', 14760.00),
(133, 2, 'KKS-133-378240', 'alul', 'alul12@gmail.com', '08124561451', 'test', 87000.00, 15000.00, 91800.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'f2c3dc4a-997d-4665-b36c-765b2009827a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/f2c3dc4a-997d-4665-b36c-765b2009827a', 'a25d505c-2195-4574-bcd2-9a31df71209e', '2025-05-23 17:32:54', '2025-05-23 10:32:58', 3, 'PYTHON15', 10200.00),
(134, 2, 'KKS-134-699787', 'alul', 'alul12@gmail.com', '08124561451', 'hdwhladhlhl', 60000.00, 15000.00, 75000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '89d5e56a-b1c0-41f5-b29a-d4e9ba3a5636', 'https://app.sandbox.midtrans.com/snap/v4/redirection/89d5e56a-b1c0-41f5-b29a-d4e9ba3a5636', 'ad1c1982-a5d7-49ce-9949-17e10b8ddb22', '2025-05-23 17:38:16', '2025-05-23 10:38:19', NULL, NULL, 0.00),
(135, 3, 'KKS-135-188097', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testtt', 45000.00, 15000.00, 60000.00, 'qris', NULL, NULL, 'accept', 'pending', '5a9ec764-9fa1-4fab-b5af-96f0c5be7615', 'https://app.sandbox.midtrans.com/snap/v4/redirection/5a9ec764-9fa1-4fab-b5af-96f0c5be7615', '175af179-5d82-456e-82ef-86bf679956d9', '2025-05-24 14:48:14', '2025-05-24 07:36:28', NULL, NULL, 0.00),
(136, 3, 'KKS-136-376689', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'rwee', 45000.00, 15000.00, 60000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '9c23e929-beff-4baa-9f83-e20755ada95e', 'https://app.sandbox.midtrans.com/snap/v4/redirection/9c23e929-beff-4baa-9f83-e20755ada95e', 'b2a725ab-54e4-4ab7-a55e-bde1a12f9b90', '2025-05-24 14:51:18', '2025-05-24 07:39:36', NULL, NULL, 0.00),
(137, 2, 'KKS-137-922036', 'alul', 'alul12@gmail.com', '08124561451', 'test', 57000.00, 15000.00, 72000.00, 'all', NULL, NULL, NULL, 'pending', 'a4801308-abe6-47c0-b281-f665388c45da', 'https://app.sandbox.midtrans.com/snap/v4/redirection/a4801308-abe6-47c0-b281-f665388c45da', NULL, NULL, '2025-05-24 07:48:41', NULL, NULL, 0.00),
(138, 3, 'KKS-138-393054', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 66000.00, 15000.00, 81000.00, 'all', NULL, NULL, NULL, 'pending', '5e80bfd9-d60d-42aa-bf49-9cac71dc01c9', 'https://app.sandbox.midtrans.com/snap/v4/redirection/5e80bfd9-d60d-42aa-bf49-9cac71dc01c9', NULL, NULL, '2025-05-25 08:39:53', NULL, NULL, 0.00),
(139, 3, 'KKS-139-045486', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyy meledak', 216000.00, 15000.00, 231000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '7ef9bd17-6f83-4a04-b253-e2b1d23dbb0c', 'https://app.sandbox.midtrans.com/snap/v4/redirection/7ef9bd17-6f83-4a04-b253-e2b1d23dbb0c', 'ef3e3617-f8b8-4abc-9c13-186ccd51e1ec', '2025-05-26 14:37:37', '2025-05-26 07:37:25', NULL, NULL, 0.00),
(140, 3, 'KKS-140-214049', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testinggg', 123000.00, 15000.00, 113000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '6ccdb972-60d7-4e2b-a15a-d864b1fd22d7', 'https://app.sandbox.midtrans.com/snap/v4/redirection/6ccdb972-60d7-4e2b-a15a-d864b1fd22d7', 'ced8104b-ef31-4103-abe2-6dfcdb7bff84', '2025-05-26 15:32:53', '2025-05-26 07:40:13', 4, 'LARAVEL25', 25000.00),
(141, 3, 'KKS-141-386679', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'hguygugugugugwduygwdugwyd8y', 60000.00, 15000.00, 75000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'f64fb550-f8d9-4e34-8662-5de39d47fb44', 'https://app.sandbox.midtrans.com/snap/v4/redirection/f64fb550-f8d9-4e34-8662-5de39d47fb44', '8acef34e-92a9-4ae4-80ca-9032acca2066', '2025-05-26 15:35:34', '2025-05-26 07:43:06', NULL, NULL, 0.00),
(142, 3, 'KKS-142-940520', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'iugiugigigu', 20000.00, 15000.00, 35000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '8c4ac20c-1fe2-4712-b3c8-410c632a4f1e', 'https://app.sandbox.midtrans.com/snap/v4/redirection/8c4ac20c-1fe2-4712-b3c8-410c632a4f1e', '1163ff51-9715-414a-afec-e82c0bd9c2ca', '2025-05-26 16:28:09', '2025-05-26 07:35:40', NULL, NULL, 0.00),
(143, 3, 'KKS-143-979820', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'kjkjhkhkh', 79000.00, 15000.00, 79900.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '79fb187d-9f9a-4026-8f10-1b8f67981a04', 'https://app.sandbox.midtrans.com/snap/v4/redirection/79fb187d-9f9a-4026-8f10-1b8f67981a04', '1a13e077-c249-4309-8cfc-7f22c40c7948', '2025-05-28 22:26:33', '2025-05-28 15:26:19', 14, 'CODEIGNITER15', 14100.00),
(144, 5, 'KKS-144-763090', 'Muhammad Alvin', 'alvinfaris59@gmail.com', '08979945242', 'KP kamurang desa puspasari rt01/07 no 57 gang jempol citeureup bogor', 238000.00, 15000.00, 228000.00, 'credit_card', NULL, NULL, 'accept', 'settlement', '7f48f417-2b08-4112-9ff3-ad8358122840', 'https://app.sandbox.midtrans.com/snap/v4/redirection/7f48f417-2b08-4112-9ff3-ad8358122840', '86dfaba3-9e1d-448c-afba-f20976c50013', '2025-05-29 20:04:34', '2025-05-29 13:02:43', 1, 'REACT50', 25000.00),
(145, 5, 'KKS-145-654891', 'Muhammad Alvin', 'alvinfaris59@gmail.com', '08979945242', 'testingg', 59000.00, 15000.00, 74000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '39c1523d-d1aa-4ce9-bc2d-f8d10496e61a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/39c1523d-d1aa-4ce9-bc2d-f8d10496e61a', '415e2739-73df-47e2-80c4-327548676d3c', '2025-05-29 20:17:56', '2025-05-29 13:17:34', NULL, NULL, 0.00),
(146, 3, 'KKS-146-762935', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'aaaaaaaaa', 56000.00, 15000.00, 71000.00, 'all', NULL, NULL, NULL, 'pending', 'b29350c9-a024-4b21-ad51-76353daf1737', 'https://app.sandbox.midtrans.com/snap/v4/redirection/b29350c9-a024-4b21-ad51-76353daf1737', NULL, NULL, '2025-06-03 08:52:42', NULL, NULL, 0.00),
(147, 3, 'KKS-147-091867', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'testingg', 15000.00, 15000.00, 30000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '359cb5bf-c868-4684-85f5-30d00a327f6a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/359cb5bf-c868-4684-85f5-30d00a327f6a', '41586aea-59b6-4ef9-9246-e97e59be018b', '2025-07-22 12:11:48', '2025-07-22 05:11:31', NULL, NULL, 0.00),
(148, 3, 'KKS-148-677332', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 22000.00, 15000.00, 37000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'f2641fc2-aa08-4e0e-af94-2f5980eeeef0', 'https://app.sandbox.midtrans.com/snap/v4/redirection/f2641fc2-aa08-4e0e-af94-2f5980eeeef0', '9e24eec8-c74e-4a5b-8bd9-570441106676', '2025-07-29 17:08:05', '2025-07-29 10:07:57', NULL, NULL, 0.00),
(149, 3, 'KKS-149-444568', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayyy anjayyy', 22000.00, 15000.00, 37000.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', '9b7ddeba-1fb9-434f-90b0-46f1d8cfa59c', 'https://app.sandbox.midtrans.com/snap/v4/redirection/9b7ddeba-1fb9-434f-90b0-46f1d8cfa59c', '409e8623-3724-4560-9e8e-db60fbd08315', '2025-07-31 17:25:10', '2025-07-31 10:24:04', NULL, NULL, 0.00),
(150, 2, 'KKS-150-353665', 'alul', 'alul12@gmail.com', '08124561451', 'anjayyy', 56000.00, 15000.00, 63900.00, 'bank_transfer', NULL, 'bca', 'accept', 'settlement', 'f2590625-57d4-45d7-8d1c-afbd47e5a83a', 'https://app.sandbox.midtrans.com/snap/v4/redirection/f2590625-57d4-45d7-8d1c-afbd47e5a83a', '3faa33b1-b49f-445b-bd7e-a9fff23534eb', '2025-08-21 19:29:43', '2025-08-21 12:29:13', 17, 'BACKBONE10', 7100.00),
(151, 3, 'KKS-151-763956', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'anjayy', 18000.00, 15000.00, 33000.00, 'bank_transfer', '63891333640743488561230', 'bca', 'accept', 'settlement', 'aa736ffe-dc0b-4429-bdd9-1a893bc1f6dd', 'https://app.sandbox.midtrans.com/snap/v4/redirection/aa736ffe-dc0b-4429-bdd9-1a893bc1f6dd', '06f5bcda-fd69-4f60-bc52-b8aeb964b526', '2025-08-23 21:54:11', '2025-08-23 14:52:43', NULL, NULL, 0.00),
(152, 3, 'KKS-152-461622', 'Kayla Fasya', 'kayla17@gmail.com', '08134562781', 'sasa', 15000.00, 15000.00, 30000.00, 'bank_transfer', '63891022136496364691442', 'bca', 'accept', 'settlement', 'eda0d4b5-2b6d-40bd-9b77-77bacd98db30', 'https://app.sandbox.midtrans.com/snap/v4/redirection/eda0d4b5-2b6d-40bd-9b77-77bacd98db30', 'e0b439fd-fb6c-42b0-a52d-365969eb8c45', '2025-08-24 19:11:07', '2025-08-24 12:11:01', NULL, NULL, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `product_name`, `price`, `quantity`, `subtotal`) VALUES
(1, 1, 7, 'Cookies', 15000.00, 1, 15000.00),
(2, 1, 6, 'Croissant', 18000.00, 1, 18000.00),
(3, 2, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(4, 3, 3, 'Kopi Latte', 28000.00, 4, 112000.00),
(5, 4, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(6, 5, 8, 'Tea', 20000.00, 7, 140000.00),
(7, 6, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(8, 7, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(9, 8, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(10, 9, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(11, 10, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(12, 10, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(13, 11, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(14, 12, 4, 'Matcha Latte', 30000.00, 4, 120000.00),
(15, 13, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(16, 13, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(17, 13, 33, 'Waffle Ice Cream', 25000.00, 1, 25000.00),
(18, 13, 27, 'Rice Bowl Daging', 39000.00, 1, 39000.00),
(19, 13, 6, 'Croissant', 18000.00, 1, 18000.00),
(20, 13, 1, 'Kopi Arabika', 25000.00, 1, 25000.00),
(21, 13, 38, 'Sate Ayam', 32000.00, 1, 32000.00),
(22, 13, 58, 'Kornet Kaleng', 15000.00, 1, 15000.00),
(23, 14, 24, 'Grilled Chicken', 42000.00, 2, 84000.00),
(24, 15, 54, 'Indomie Soto', 10000.00, 4, 40000.00),
(25, 16, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(26, 16, 35, 'Rendang', 45000.00, 1, 45000.00),
(27, 16, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(28, 16, 51, 'Pepperoni Pizza', 48000.00, 1, 48000.00),
(29, 16, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(30, 16, 9, 'Espresso', 20000.00, 1, 20000.00),
(31, 16, 10, 'Americano', 22000.00, 1, 22000.00),
(32, 17, 3, 'Kopi Latte', 28000.00, 4, 112000.00),
(33, 17, 7, 'Cookies', 15000.00, 1, 15000.00),
(34, 17, 13, 'Caramel Macchiato', 30000.00, 1, 30000.00),
(35, 17, 17, 'Honey Lemon', 24000.00, 1, 24000.00),
(36, 17, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(37, 17, 27, 'Rice Bowl Daging', 39000.00, 1, 39000.00),
(38, 17, 26, 'Chicken Katsu', 38000.00, 1, 38000.00),
(39, 17, 34, 'Rawon', 40000.00, 1, 40000.00),
(40, 17, 35, 'Rendang', 45000.00, 1, 45000.00),
(41, 18, 52, 'Beef Steak', 65000.00, 1, 65000.00),
(42, 18, 51, 'Pepperoni Pizza', 48000.00, 1, 48000.00),
(43, 18, 38, 'Sate Ayam', 32000.00, 1, 32000.00),
(44, 18, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(45, 18, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(46, 18, 16, 'Milk Tea', 25000.00, 1, 25000.00),
(47, 18, 10, 'Americano', 22000.00, 2, 44000.00),
(48, 18, 19, 'French Fries', 18000.00, 1, 18000.00),
(49, 18, 21, 'Pisang Goreng Keju', 17000.00, 1, 17000.00),
(50, 19, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(51, 19, 10, 'Americano', 22000.00, 1, 22000.00),
(52, 19, 9, 'Espresso', 20000.00, 1, 20000.00),
(53, 20, 55, 'Pop Mie Pedas', 12000.00, 1, 12000.00),
(54, 20, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(55, 20, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(56, 21, 10, 'Americano', 22000.00, 2, 44000.00),
(57, 21, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(58, 21, 13, 'Caramel Macchiato', 30000.00, 1, 30000.00),
(59, 21, 6, 'Croissant', 18000.00, 2, 36000.00),
(60, 21, 19, 'French Fries', 18000.00, 1, 18000.00),
(61, 21, 23, 'Onion Ring', 16000.00, 1, 16000.00),
(62, 21, 26, 'Chicken Katsu', 38000.00, 1, 38000.00),
(63, 21, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(64, 21, 30, 'Ice Cream Sundae', 22000.00, 1, 22000.00),
(65, 21, 33, 'Waffle Ice Cream', 25000.00, 2, 50000.00),
(66, 21, 34, 'Rawon', 40000.00, 1, 40000.00),
(67, 21, 38, 'Sate Ayam', 32000.00, 1, 32000.00),
(68, 21, 35, 'Rendang', 45000.00, 1, 45000.00),
(69, 21, 52, 'Beef Steak', 65000.00, 1, 65000.00),
(70, 21, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(71, 22, 28, 'Ayam Geprek', 35000.00, 3, 105000.00),
(72, 23, 25, 'Beef Teriyaki', 45000.00, 1, 45000.00),
(73, 23, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(74, 23, 22, 'Spring Roll', 15000.00, 1, 15000.00),
(75, 23, 35, 'Rendang', 45000.00, 1, 45000.00),
(76, 23, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(77, 24, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(78, 24, 10, 'Americano', 22000.00, 1, 22000.00),
(79, 24, 9, 'Espresso', 20000.00, 1, 20000.00),
(80, 24, 18, 'Avocado Juice', 27000.00, 1, 27000.00),
(81, 24, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(82, 24, 21, 'Pisang Goreng Keju', 17000.00, 1, 17000.00),
(83, 24, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(84, 24, 25, 'Beef Teriyaki', 45000.00, 1, 45000.00),
(85, 24, 33, 'Waffle Ice Cream', 25000.00, 1, 25000.00),
(86, 24, 29, 'Brownies', 20000.00, 1, 20000.00),
(87, 24, 38, 'Sate Ayam', 32000.00, 1, 32000.00),
(88, 24, 35, 'Rendang', 45000.00, 1, 45000.00),
(89, 24, 51, 'Pepperoni Pizza', 48000.00, 1, 48000.00),
(90, 24, 53, 'Hot Dog', 35000.00, 1, 35000.00),
(91, 24, 54, 'Indomie Soto', 10000.00, 1, 10000.00),
(92, 25, 1, 'Kopi Arabika', 25000.00, 1, 25000.00),
(93, 25, 54, 'Indomie Soto', 10000.00, 1, 10000.00),
(94, 25, 51, 'Pepperoni Pizza', 48000.00, 1, 48000.00),
(95, 25, 52, 'Beef Steak', 65000.00, 1, 65000.00),
(96, 25, 16, 'Milk Tea', 25000.00, 1, 25000.00),
(97, 26, 11, 'Cappuccino', 26000.00, 2, 52000.00),
(98, 27, 11, 'Cappuccino', 26000.00, 3, 78000.00),
(99, 28, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(100, 29, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(101, 30, 4, 'Matcha Latte', 30000.00, 4, 120000.00),
(102, 31, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(103, 32, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(104, 32, 10, 'Americano', 22000.00, 5, 110000.00),
(105, 33, 2, 'Kopi Robusta', 22000.00, 4, 88000.00),
(106, 34, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(107, 35, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(108, 36, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(109, 37, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(110, 37, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(111, 37, 1, 'Kopi Arabika', 25000.00, 1, 25000.00),
(112, 37, 35, 'Rendang', 45000.00, 1, 45000.00),
(113, 38, 3, 'Kopi Latte', 28000.00, 4, 112000.00),
(114, 39, 37, 'Bakso', 25000.00, 1, 25000.00),
(115, 40, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(116, 40, 16, 'Milk Tea', 25000.00, 1, 25000.00),
(117, 40, 35, 'Rendang', 45000.00, 1, 45000.00),
(118, 40, 34, 'Rawon', 40000.00, 1, 40000.00),
(119, 40, 54, 'Indomie Soto', 10000.00, 1, 10000.00),
(120, 41, 23, 'Onion Ring', 16000.00, 1, 16000.00),
(121, 41, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(122, 41, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(123, 41, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(124, 41, 19, 'French Fries', 18000.00, 1, 18000.00),
(125, 41, 16, 'Milk Tea', 25000.00, 1, 25000.00),
(126, 42, 1, 'Kopi Arabika', 25000.00, 2, 50000.00),
(127, 43, 7, 'Cookies', 15000.00, 3, 45000.00),
(128, 43, 6, 'Croissant', 18000.00, 1, 18000.00),
(129, 44, 7, 'Cookies', 15000.00, 3, 45000.00),
(130, 45, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(131, 46, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(132, 47, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(133, 48, 7, 'Cookies', 15000.00, 3, 45000.00),
(134, 49, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(135, 49, 52, 'Beef Steak', 65000.00, 1, 65000.00),
(136, 49, 51, 'Pepperoni Pizza', 48000.00, 1, 48000.00),
(137, 49, 18, 'Avocado Juice', 27000.00, 1, 27000.00),
(138, 49, 13, 'Caramel Macchiato', 30000.00, 1, 30000.00),
(139, 49, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(140, 49, 19, 'French Fries', 18000.00, 1, 18000.00),
(141, 50, 22, 'Spring Roll', 15000.00, 1, 15000.00),
(142, 51, 19, 'French Fries', 18000.00, 1, 18000.00),
(143, 51, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(144, 52, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(145, 53, 57, 'Bubur Instan Ayam', 10000.00, 2, 20000.00),
(146, 54, 3, 'Kopi Latte', 28000.00, 5, 140000.00),
(147, 55, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(148, 56, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(149, 57, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(150, 58, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(151, 59, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(152, 60, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(153, 61, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(154, 62, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(155, 63, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(156, 64, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(157, 65, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(158, 66, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(159, 67, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(160, 68, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(161, 68, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(162, 69, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(163, 69, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(164, 70, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(165, 70, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(166, 71, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(167, 72, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(168, 73, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(169, 74, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(170, 75, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(171, 76, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(172, 77, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(173, 78, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(174, 79, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(175, 80, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(176, 81, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(177, 82, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(178, 82, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(179, 82, 19, 'French Fries', 18000.00, 1, 18000.00),
(180, 83, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(181, 83, 16, 'Milk Tea', 25000.00, 1, 25000.00),
(182, 84, 7, 'Cookies', 15000.00, 2, 30000.00),
(183, 85, 24, 'Grilled Chicken', 42000.00, 3, 126000.00),
(184, 86, 24, 'Grilled Chicken', 42000.00, 3, 126000.00),
(185, 87, 24, 'Grilled Chicken', 42000.00, 3, 126000.00),
(186, 88, 24, 'Grilled Chicken', 42000.00, 3, 126000.00),
(187, 89, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(188, 90, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(189, 91, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(190, 92, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(191, 93, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(192, 94, 1, 'Kopi Arabika', 25000.00, 2, 50000.00),
(193, 95, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(194, 95, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(195, 95, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(196, 95, 38, 'Sate Ayam', 32000.00, 1, 32000.00),
(197, 95, 52, 'Beef Steak', 65000.00, 1, 65000.00),
(198, 95, 51, 'Pepperoni Pizza', 48000.00, 1, 48000.00),
(199, 95, 13, 'Caramel Macchiato', 30000.00, 1, 30000.00),
(200, 95, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(201, 96, 29, 'Brownies', 20000.00, 1, 20000.00),
(202, 96, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(203, 96, 8, 'Tea', 20000.00, 1, 20000.00),
(204, 97, 29, 'Brownies', 20000.00, 1, 20000.00),
(205, 97, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(206, 97, 8, 'Tea', 20000.00, 1, 20000.00),
(207, 98, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(208, 99, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(209, 100, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(210, 101, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(211, 101, 6, 'Croissant', 18000.00, 1, 18000.00),
(212, 102, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(213, 103, 6, 'Croissant', 18000.00, 1, 18000.00),
(214, 104, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(215, 105, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(216, 106, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(217, 107, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(218, 108, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(219, 108, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(220, 109, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(221, 109, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(222, 110, 4, 'Matcha Latte', 30000.00, 2, 60000.00),
(223, 111, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(224, 112, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(225, 113, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(226, 114, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(227, 115, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(228, 116, 11, 'Cappuccino', 26000.00, 1, 26000.00),
(229, 116, 19, 'French Fries', 18000.00, 1, 18000.00),
(230, 117, 4, 'Matcha Latte', 30000.00, 2, 60000.00),
(231, 118, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(232, 119, 35, 'Rendang', 45000.00, 3, 135000.00),
(233, 120, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(234, 120, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(235, 120, 53, 'Hot Dog', 35000.00, 1, 35000.00),
(236, 121, 35, 'Rendang', 45000.00, 1, 45000.00),
(237, 121, 8, 'Tea', 20000.00, 1, 20000.00),
(238, 121, 10, 'Americano', 22000.00, 1, 22000.00),
(239, 121, 36, 'Gado-Gado', 30000.00, 1, 30000.00),
(240, 122, 2, 'Kopi Robusta', 22000.00, 2, 44000.00),
(241, 123, 27, 'Rice Bowl Daging', 39000.00, 1, 39000.00),
(242, 123, 25, 'Beef Teriyaki', 45000.00, 1, 45000.00),
(243, 123, 7, 'Cookies', 15000.00, 1, 15000.00),
(244, 123, 1, 'Kopi Arabika', 25000.00, 1, 25000.00),
(245, 124, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(246, 124, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(247, 125, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(248, 125, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(249, 126, 3, 'Kopi Latte', 28000.00, 3, 84000.00),
(250, 126, 4, 'Matcha Latte', 30000.00, 1, 30000.00),
(251, 127, 1, 'Kopi Arabika', 25000.00, 1, 25000.00),
(252, 128, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(253, 128, 6, 'Croissant', 18000.00, 1, 18000.00),
(254, 128, 9, 'Espresso', 20000.00, 1, 20000.00),
(255, 129, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(256, 129, 6, 'Croissant', 18000.00, 1, 18000.00),
(257, 129, 9, 'Espresso', 20000.00, 1, 20000.00),
(258, 130, 28, 'Ayam Geprek', 35000.00, 1, 35000.00),
(259, 130, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(260, 130, 52, 'Beef Steak', 65000.00, 1, 65000.00),
(261, 131, 7, 'Cookies', 15000.00, 8, 120000.00),
(262, 131, 24, 'Grilled Chicken', 42000.00, 5, 210000.00),
(263, 132, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(264, 132, 49, 'Spaghetti Bolognese', 42000.00, 1, 42000.00),
(265, 132, 18, 'Avocado Juice', 27000.00, 1, 27000.00),
(266, 133, 8, 'Tea', 20000.00, 1, 20000.00),
(267, 133, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(268, 133, 33, 'Waffle Ice Cream', 25000.00, 1, 25000.00),
(269, 134, 19, 'French Fries', 18000.00, 1, 18000.00),
(270, 134, 18, 'Avocado Juice', 27000.00, 1, 27000.00),
(271, 134, 22, 'Spring Roll', 15000.00, 1, 15000.00),
(272, 135, 18, 'Avocado Juice', 27000.00, 1, 27000.00),
(273, 135, 19, 'French Fries', 18000.00, 1, 18000.00),
(274, 136, 18, 'Avocado Juice', 27000.00, 1, 27000.00),
(275, 136, 19, 'French Fries', 18000.00, 1, 18000.00),
(276, 137, 12, 'Vanilla Latte', 28000.00, 1, 28000.00),
(277, 137, 15, 'Red Velvet Latte', 29000.00, 1, 29000.00),
(278, 138, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(279, 139, 2, 'Kopi Robusta', 22000.00, 3, 66000.00),
(280, 139, 4, 'Matcha Latte', 30000.00, 5, 150000.00),
(281, 140, 3, 'Kopi Latte', 28000.00, 1, 28000.00),
(282, 140, 7, 'Cookies', 15000.00, 1, 15000.00),
(283, 140, 8, 'Tea', 20000.00, 1, 20000.00),
(284, 140, 19, 'French Fries', 18000.00, 1, 18000.00),
(285, 140, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(286, 141, 19, 'French Fries', 18000.00, 1, 18000.00),
(287, 141, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(288, 142, 8, 'Tea', 20000.00, 1, 20000.00),
(289, 143, 19, 'French Fries', 18000.00, 1, 18000.00),
(290, 143, 10, 'Americano', 22000.00, 1, 22000.00),
(291, 143, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(292, 144, 10, 'Americano', 22000.00, 1, 22000.00),
(293, 144, 23, 'Onion Ring', 16000.00, 1, 16000.00),
(294, 144, 21, 'Pisang Goreng Keju', 17000.00, 1, 17000.00),
(295, 144, 5, 'Chocolate Frappe', 32000.00, 1, 32000.00),
(296, 144, 24, 'Grilled Chicken', 42000.00, 1, 42000.00),
(297, 144, 33, 'Waffle Ice Cream', 25000.00, 1, 25000.00),
(298, 144, 35, 'Rendang', 45000.00, 1, 45000.00),
(299, 144, 50, 'Cheeseburger', 39000.00, 1, 39000.00),
(300, 145, 1, 'Kopi Arabika', 25000.00, 1, 25000.00),
(301, 145, 19, 'French Fries', 18000.00, 1, 18000.00),
(302, 145, 20, 'Donat Coklat', 16000.00, 1, 16000.00),
(303, 146, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(304, 147, 7, 'Cookies', 15000.00, 1, 15000.00),
(305, 148, 2, 'Kopi Robusta', 22000.00, 1, 22000.00),
(306, 149, 30, 'Ice Cream Sundae', 22000.00, 1, 22000.00),
(307, 150, 3, 'Kopi Latte', 28000.00, 2, 56000.00),
(308, 151, 6, 'Croissant', 18000.00, 1, 18000.00),
(309, 152, 7, 'Cookies', 15000.00, 1, 15000.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `category` enum('coffee','non-coffee','snack','main-course','dessert','indonesian-food','western-food','instant-food') NOT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `category`, `is_featured`, `created_at`) VALUES
(1, 'Kopi Arabika', 'Kopi premium dengan biji pilihan asal Toraja', 25000.00, 'img/products/kopi-arabika.jpg', 'coffee', 1, '2025-04-13 06:25:25'),
(2, 'Kopi Robusta', 'Kopi dengan rasa kuat dan pahit khas Indonesia', 22000.00, 'img/products/kopi-robusta.jpg', 'coffee', 1, '2025-04-13 06:25:25'),
(3, 'Kopi Latte', 'Kombinasi espresso dan susu dengan latte art spesial', 28000.00, 'img/products/kopi-latte.jpg', 'coffee', 1, '2025-04-13 06:25:25'),
(4, 'Matcha Latte', 'Teh hijau premium dengan susu', 30000.00, 'img/products/matcha-latte.jpg', 'non-coffee', 0, '2025-04-13 06:25:25'),
(5, 'Chocolate Frappe', 'Minuman coklat dingin dengan whipped cream', 32000.00, 'img/products/chocolate-frappe.jpg', 'non-coffee', 0, '2025-04-13 06:25:25'),
(6, 'Croissant', 'Pastry renyah dengan lapisan mentega', 18000.00, 'img/products/croissant.jpg', 'snack', 0, '2025-04-13 06:25:25'),
(7, 'Cookies', 'Cookies coklat chip dengan tekstur crunchy', 15000.00, 'img/products/cookies.jpg', 'snack', 0, '2025-04-13 06:25:25'),
(8, 'Tea', 'Teh premium dengan pilihan rasa', 20000.00, 'img/products/tea.jpg', 'non-coffee', 0, '2025-04-13 06:25:25'),
(9, 'Espresso', 'Kopi hitam pekat tanpa gula', 20000.00, 'img/products/espresso.jpg', 'coffee', 0, '2025-04-19 10:29:10'),
(10, 'Americano', 'Espresso dengan tambahan air panas', 22000.00, 'img/products/americano.jpg', 'coffee', 0, '2025-04-19 10:29:10'),
(11, 'Cappuccino', 'Espresso dengan susu dan foam', 26000.00, 'img/products/cappuccino.jpg', 'coffee', 0, '2025-04-19 10:29:10'),
(12, 'Vanilla Latte', 'Kopi susu dengan rasa vanilla', 28000.00, 'img/products/vanilla-latte.jpg', 'coffee', 0, '2025-04-19 10:29:10'),
(13, 'Caramel Macchiato', 'Espresso, susu, dan caramel', 30000.00, 'img/products/caramel-macchiato.jpg', 'coffee', 0, '2025-04-19 10:29:10'),
(14, 'Taro Latte', 'Minuman taro dengan susu', 28000.00, 'img/products/taro-latte.jpg', 'non-coffee', 0, '2025-04-19 10:37:34'),
(15, 'Red Velvet Latte', 'Minuman red velvet creamy', 29000.00, 'img/products/red-velvet.jpg', 'non-coffee', 0, '2025-04-19 10:37:34'),
(16, 'Milk Tea', 'Teh susu klasik', 25000.00, 'img/products/milk-tea.jpg', 'non-coffee', 0, '2025-04-19 10:37:34'),
(17, 'Honey Lemon', 'Campuran madu dan lemon segar', 24000.00, 'img/products/honey-lemon.jpg', 'non-coffee', 0, '2025-04-19 10:37:34'),
(18, 'Avocado Juice', 'Jus alpukat dengan susu kental', 27000.00, 'img/products/avocado-juice.jpg', 'non-coffee', 0, '2025-04-19 10:37:34'),
(19, 'French Fries', 'Kentang goreng renyah', 18000.00, 'img/products/french-fries.jpg', 'snack', 0, '2025-04-19 10:38:04'),
(20, 'Donat Coklat', 'Donat empuk dengan taburan coklat', 16000.00, 'img/products/donat-coklat.jpg', 'snack', 0, '2025-04-19 10:38:04'),
(21, 'Pisang Goreng Keju', 'Pisang goreng dengan keju dan coklat', 17000.00, 'img/products/pisang-goreng.jpg', 'snack', 0, '2025-04-19 10:38:04'),
(22, 'Spring Roll', 'Lumpia isi sayur', 15000.00, 'img/products/spring-roll.jpg', 'snack', 0, '2025-04-19 10:38:04'),
(23, 'Onion Ring', 'Cincin bawang goreng renyah', 16000.00, 'img/products/onion-ring.jpg', 'snack', 0, '2025-04-19 10:38:04'),
(24, 'Grilled Chicken', 'Ayam bakar saus BBQ dan nasi', 42000.00, 'img/products/grilled-chicken.jpg', 'main-course', 0, '2025-04-19 10:38:53'),
(25, 'Beef Teriyaki', 'Daging sapi teriyaki dengan nasi', 45000.00, 'img/products/beef-teriyaki.jpg', 'main-course', 0, '2025-04-19 10:38:53'),
(26, 'Chicken Katsu', 'Ayam goreng tepung dengan nasi dan saus', 38000.00, 'img/products/chicken-katsu.jpg', 'main-course', 0, '2025-04-19 10:38:53'),
(27, 'Rice Bowl Daging', 'Nasi dengan daging sapi tumis dan telur', 39000.00, 'img/products/rice-bowl.jpg', 'main-course', 0, '2025-04-19 10:38:53'),
(28, 'Ayam Geprek', 'Ayam geprek sambal pedas dengan nasi', 35000.00, 'img/products/ayam-geprek.jpg', 'main-course', 0, '2025-04-19 10:38:53'),
(29, 'Brownies', 'Brownies coklat lembut', 20000.00, 'img/products/brownies.jpg', 'dessert', 0, '2025-04-19 10:40:10'),
(30, 'Ice Cream Sundae', 'Es krim dengan saus coklat dan kacang', 22000.00, 'img/products/ice-cream.jpg', 'dessert', 0, '2025-04-19 10:40:10'),
(31, 'Pudding Coklat', 'Puding lembut rasa coklat', 18000.00, 'img/products/pudding.jpg', 'dessert', 0, '2025-04-19 10:40:10'),
(32, 'Crepes', 'Crepes tipis isi pisang coklat', 20000.00, 'img/products/crepes.jpg', 'dessert', 0, '2025-04-19 10:40:10'),
(33, 'Waffle Ice Cream', 'Waffle hangat dengan es krim di atasnya', 25000.00, 'img/products/waffle.jpg', 'dessert', 0, '2025-04-19 10:40:10'),
(34, 'Rawon', 'Sup daging hitam khas Jawa Timur', 40000.00, 'img/products/rawon.jpg', 'indonesian-food', 0, '2025-04-19 10:40:20'),
(35, 'Rendang', 'Daging sapi bumbu rendang khas Padang', 45000.00, 'img/products/rendang.jpg', 'indonesian-food', 0, '2025-04-19 10:40:20'),
(36, 'Gado-Gado', 'Sayur rebus dengan bumbu kacang', 30000.00, 'img/products/gado-gado.jpg', 'indonesian-food', 0, '2025-04-19 10:40:20'),
(37, 'Bakso', 'Bakso sapi dengan kuah kaldu', 25000.00, 'img/products/bakso.jpg', 'indonesian-food', 0, '2025-04-19 10:40:20'),
(38, 'Sate Ayam', 'Sate ayam dengan bumbu kacang dan lontong', 32000.00, 'img/products/sate-ayam.jpg', 'indonesian-food', 0, '2025-04-19 10:40:20'),
(49, 'Spaghetti Bolognese', 'Spaghetti dengan saus daging sapi Italia', 42000.00, 'img/products/spaghetti-bolognese.jpg', 'western-food', 0, '2025-04-19 10:41:29'),
(50, 'Cheeseburger', 'Burger isi daging sapi, keju, dan sayuran segar', 39000.00, 'img/products/cheeseburger.jpg', 'western-food', 0, '2025-04-19 10:41:29'),
(51, 'Pepperoni Pizza', 'Pizza topping pepperoni dan keju mozzarella', 48000.00, 'img/products/pepperoni-pizza.jpg', 'western-food', 0, '2025-04-19 10:41:29'),
(52, 'Beef Steak', 'Daging sapi panggang dengan saus mushroom', 65000.00, 'img/products/beef-steak.jpg', 'western-food', 0, '2025-04-19 10:41:29'),
(53, 'Hot Dog', 'Sosis panggang dalam roti dengan saus dan sayuran', 35000.00, 'img/products/hot-dog.jpg', 'western-food', 0, '2025-04-19 10:41:29'),
(54, 'Indomie Soto', 'Mie instan rasa soto ayam', 10000.00, 'img/products/indomie-soto.jpg', 'instant-food', 0, '2025-04-19 10:41:52'),
(55, 'Pop Mie Pedas', 'Pop mie dengan rasa pedas mantap', 12000.00, 'img/products/popmie-pedas.jpg', 'instant-food', 0, '2025-04-19 10:41:52'),
(56, 'Mie Gelas', 'Mie instan mini dalam gelas', 8000.00, 'img/products/mie-gelas.jpg', 'instant-food', 0, '2025-04-19 10:41:52'),
(57, 'Bubur Instan Ayam', 'Bubur instan rasa ayam', 10000.00, 'img/products/bubur-instan.jpg', 'instant-food', 0, '2025-04-19 10:41:52'),
(58, 'Kornet Kaleng', 'Daging kornet siap saji dalam kaleng', 15000.00, 'img/products/kornet.jpg', 'instant-food', 0, '2025-04-19 10:41:52');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `reservation_number` varchar(50) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `reservation_date` date NOT NULL,
  `reservation_time` time NOT NULL,
  `duration_hours` int(11) NOT NULL DEFAULT 2,
  `room_type` enum('coding-zone','meeting-room','quiet-corner','open-space') NOT NULL,
  `table_number` varchar(10) NOT NULL,
  `guest_count` int(11) NOT NULL DEFAULT 1,
  `special_request` text DEFAULT NULL,
  `status` enum('pending','confirmed','completed','cancelled','no-show') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `price_per_hour` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_price` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `user_id`, `reservation_number`, `customer_name`, `email`, `phone`, `reservation_date`, `reservation_time`, `duration_hours`, `room_type`, `table_number`, `guest_count`, `special_request`, `status`, `created_at`, `updated_at`, `price_per_hour`, `total_price`) VALUES
(1, 3, 'RES-1-569872', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-05-25', '19:00:00', 2, 'coding-zone', 'CZ-01', 1, 'testing', 'cancelled', '2025-05-24 07:42:49', '2025-05-25 07:46:18', 15000.00, 0.00),
(2, 3, 'RES-2-450828', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-05-27', '15:00:00', 3, 'meeting-room', 'MR-02', 4, 'anjayy testing', 'cancelled', '2025-05-24 08:30:50', '2025-05-25 07:46:21', 20000.00, 0.00),
(3, 2, 'RES-3-497002', 'alul', 'alul12@gmail.com', '08134562781', '2025-05-25', '02:00:00', 2, 'quiet-corner', 'QC-01', 1, '', 'confirmed', '2025-05-24 07:41:36', '2025-05-25 08:41:57', 10000.00, 0.00),
(4, 3, 'RES-4-506325', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-05-25', '17:00:00', 2, 'open-space', 'OS-01', 2, '', 'confirmed', '2025-05-25 08:41:46', '2025-05-25 08:41:57', 8000.00, 0.00),
(5, 3, 'RES-5-047906', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-06-20', '10:00:00', 2, 'coding-zone', 'CZ-01', 1, 'tsetsuugug', 'confirmed', '2025-05-25 07:44:07', '2025-05-25 07:44:07', 15000.00, 30000.00),
(6, 3, 'RES-6-272571', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-05-25', '20:00:00', 2, 'coding-zone', 'CZ-01', 1, '', 'confirmed', '2025-05-25 07:47:52', '2025-05-25 07:47:52', 15000.00, 30000.00),
(7, NULL, 'RES-7-847787', 'kayla fasya ', 'kayla17@gmail.com', '08134562781', '2025-05-25', '20:00:00', 2, 'quiet-corner', 'QC-01', 1, '', 'confirmed', '2025-05-25 08:30:47', '2025-05-25 08:30:47', 10000.00, 20000.00),
(8, 3, 'RES-8-830980', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-05-29', '20:00:00', 2, 'quiet-corner', 'QC-01', 1, '', 'confirmed', '2025-05-28 15:23:50', '2025-05-28 15:23:50', 200000.00, 400000.00),
(9, 5, 'RES-9-455597', 'Muhammad Alvin Faris', 'alvinfaris59@gmail.com', '08979945242', '2025-05-29', '21:00:00', 1, 'coding-zone', 'CZ-03', 2, '', 'confirmed', '2025-05-29 12:57:35', '2025-05-29 12:57:35', 250000.00, 250000.00),
(10, 3, 'RES-10-761670', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-06-09', '10:00:00', 2, 'coding-zone', 'CZ-01', 1, '', 'confirmed', '2025-06-03 01:06:01', '2025-06-03 01:06:01', 250000.00, 500000.00),
(11, 3, 'RES-11-344622', 'kayla fasya ', 'kayla17@gmail.com', '08124561451', '2025-07-23', '12:17:00', 2, 'coding-zone', 'CZ-03', 1, 'anjayyy', 'confirmed', '2025-07-22 05:15:44', '2025-07-22 05:15:44', 250000.00, 500000.00),
(12, 3, 'RES-12-104718', 'alul', 'kayla17@gmail.com', '08124561451', '2025-08-25', '21:13:00', 2, 'meeting-room', '2', 3, '', 'confirmed', '2025-08-24 12:21:44', '2025-08-24 12:21:44', 0.00, 0.00),
(13, 3, 'RES-13-236011', 'anjayyy', 'anjay@gmail.com', '08134562781', '2025-08-29', '21:23:00', 2, 'coding-zone', '2', 1, '', 'confirmed', '2025-08-24 12:23:56', '2025-08-24 12:23:56', 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `reservation_history`
--

CREATE TABLE `reservation_history` (
  `id` int(11) NOT NULL,
  `reservation_id` int(11) NOT NULL,
  `action` enum('created','rescheduled','cancelled','confirmed','completed') NOT NULL,
  `old_date` date DEFAULT NULL,
  `old_time` time DEFAULT NULL,
  `new_date` date DEFAULT NULL,
  `new_time` time DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation_history`
--

INSERT INTO `reservation_history` (`id`, `reservation_id`, `action`, `old_date`, `old_time`, `new_date`, `new_time`, `notes`, `created_at`) VALUES
(1, 1, 'created', NULL, NULL, '2025-05-25', '17:00:00', 'Reservasi dibuat', '2025-05-24 07:42:49'),
(2, 1, 'rescheduled', '2025-05-25', '17:00:00', '2025-05-25', '20:00:00', 'Reservasi dijadwal ulang', '2025-05-24 08:26:26'),
(3, 2, 'created', NULL, NULL, '2025-05-27', '15:00:00', 'Reservasi dibuat', '2025-05-24 08:30:50'),
(4, 3, 'created', NULL, NULL, '2025-05-25', '02:00:00', 'Reservasi dibuat', '2025-05-24 07:41:37'),
(5, 1, 'rescheduled', '2025-05-25', '20:00:00', '2025-05-25', '19:00:00', 'Reservasi dijadwal ulang', '2025-05-25 08:02:57'),
(6, 4, 'created', NULL, NULL, '2025-05-25', '17:00:00', 'Reservasi dibuat', '2025-05-25 08:41:46'),
(7, 5, 'created', NULL, NULL, '2025-06-20', '10:00:00', 'Reservasi dibuat', '2025-05-25 07:44:07'),
(8, 1, 'cancelled', NULL, NULL, NULL, NULL, 'Dibatalkan oleh customer', '2025-05-25 07:46:18'),
(9, 2, 'cancelled', NULL, NULL, NULL, NULL, 'Dibatalkan oleh customer', '2025-05-25 07:46:21'),
(10, 6, 'created', NULL, NULL, '2025-05-25', '20:00:00', 'Reservasi dibuat', '2025-05-25 07:47:52'),
(11, 7, 'created', NULL, NULL, '2025-05-25', '20:00:00', 'Reservasi dibuat', '2025-05-25 08:30:47'),
(12, 8, 'created', NULL, NULL, '2025-05-29', '20:00:00', 'Reservasi dibuat', '2025-05-28 15:23:50'),
(13, 9, 'created', NULL, NULL, '2025-05-29', '21:00:00', 'Reservasi dibuat', '2025-05-29 12:57:35'),
(14, 10, 'created', NULL, NULL, '2025-06-09', '10:00:00', 'Reservasi dibuat', '2025-06-03 01:06:01'),
(15, 11, 'created', NULL, NULL, '2025-07-23', '12:17:00', 'Reservasi dibuat', '2025-07-22 05:15:44'),
(16, 12, 'created', NULL, NULL, '2025-08-25', '21:13:00', 'Reservasi dibuat', '2025-08-24 12:21:44'),
(17, 13, 'created', NULL, NULL, '2025-08-29', '21:23:00', 'Reservasi dibuat', '2025-08-24 12:23:56');

-- --------------------------------------------------------

--
-- Table structure for table `room_tables`
--

CREATE TABLE `room_tables` (
  `id` int(11) NOT NULL,
  `room_type` enum('coding-zone','meeting-room','quiet-corner','open-space') NOT NULL,
  `table_number` varchar(10) NOT NULL,
  `capacity` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `price_per_hour` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_tables`
--

INSERT INTO `room_tables` (`id`, `room_type`, `table_number`, `capacity`, `description`, `is_available`, `price_per_hour`) VALUES
(1, 'coding-zone', 'CZ-01', 1, 'Single desk dengan monitor 27 inch, mechanical keyboard', 1, 250000.00),
(2, 'coding-zone', 'CZ-02', 1, 'Single desk dengan dual monitor setup', 1, 250000.00),
(3, 'coding-zone', 'CZ-03', 2, 'Pair programming station dengan shared screen', 1, 250000.00),
(4, 'coding-zone', 'CZ-04', 2, 'Collaboration desk dengan whiteboard', 1, 250000.00),
(5, 'meeting-room', 'MR-01', 6, 'Meeting room dengan projector dan whiteboard', 1, 400000.00),
(6, 'meeting-room', 'MR-02', 4, 'Small meeting room untuk scrum meeting', 1, 300000.00),
(7, 'meeting-room', 'MR-03', 8, 'Large meeting room untuk presentasi', 1, 400000.00),
(8, 'quiet-corner', 'QC-01', 1, 'Single seat dengan sound isolation', 1, 200000.00),
(9, 'quiet-corner', 'QC-02', 1, 'Corner desk dengan natural lighting', 1, 200000.00),
(10, 'quiet-corner', 'QC-03', 2, 'Quiet booth untuk video call', 1, 200000.00),
(11, 'open-space', 'OS-01', 4, 'High table untuk standing meeting', 1, 150000.00),
(12, 'open-space', 'OS-02', 6, 'Large communal table', 1, 150000.00),
(13, 'open-space', 'OS-03', 3, 'Lounge area dengan sofa', 1, 150000.00),
(14, 'open-space', 'OS-04', 4, 'Bar counter dengan high chairs', 1, 150000.00);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('yu2WR6wLYWxSDCSW6uLik_vP3c0Zqa_K', 1756124636, '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2025-08-24T14:50:06.766Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\",\"sameSite\":\"lax\"},\"userId\":3,\"user\":{\"id\":3,\"name\":\"Kayla Fasya\",\"email\":\"kayla17@gmail.com\",\"phone\":\"08134562781\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(255) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `created_at`, `role`) VALUES
(1, 'alvin', 'alvin123456@gmail.com', '$2b$10$ZEn9zXGSoCEx7KH9D9XjY.7KNpXGRkFxWOelStkvumKeJV.4bW97m', '08979945242', '2025-04-13 10:30:19', 'user'),
(2, 'alul', 'alul12@gmail.com', '$2b$10$NZiLx./DyGzjegXe9bwPyeWavzVN0xTMzWF4wSw2lUgf.BxJxCX7K', '08124561451', '2025-04-13 10:31:37', 'admin'),
(3, 'Kayla Fasya', 'kayla17@gmail.com', '$2b$10$ropyPCU0OnQ8v5FhuzulYu6BDY422/LN4JoZ6x9uadT7exKbyK2ZG', '08134562781', '2025-04-20 07:25:23', 'user'),
(4, 'anindya ramadhani', 'anindya127@gmail.com', '$2b$10$loHJNVOaAMsYDeYzdCKWtuQ.BhyXAedaJsqOUxvK2xLpqS5J5OHg.', '0812456721451', '2025-05-09 13:55:08', 'user'),
(5, 'Muhammad Alvin', 'alvinfaris59@gmail.com', '$2b$10$8rz/JdtEDqX/yg5R9wW5hee/hGB3f0faB.NG0RjGmr0cipTsg3SzO', '08979945242', '2025-05-29 12:52:48', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_voucher_usage`
--

CREATE TABLE `user_voucher_usage` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `voucher_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `used_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_voucher_usage`
--

INSERT INTO `user_voucher_usage` (`id`, `user_id`, `voucher_id`, `email`, `used_at`) VALUES
(1, 2, 8, 'alul12@gmail.com', '2025-05-23 04:04:01'),
(2, 2, 7, 'alul12@gmail.com', '2025-05-23 05:58:18'),
(3, 2, 5, 'alul12@gmail.com', '2025-05-23 06:01:02'),
(4, NULL, 7, 'kayla17@gmail.com', '2025-05-23 06:34:34'),
(5, 3, 8, 'kayla17@gmail.com', '2025-05-23 06:37:32'),
(6, 3, 5, 'kayla17@gmail.com', '2025-05-23 06:51:27'),
(7, 2, 3, 'alul12@gmail.com', '2025-05-23 10:32:58'),
(8, 3, 4, 'kayla17@gmail.com', '2025-05-26 07:40:14'),
(9, 3, 14, 'kayla17@gmail.com', '2025-05-28 15:26:19'),
(10, 5, 1, 'alvinfaris59@gmail.com', '2025-05-29 13:02:43'),
(11, 2, 17, 'alul12@gmail.com', '2025-08-21 12:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `discount_type` enum('percentage','fixed') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order` decimal(10,2) DEFAULT 0.00,
  `max_discount` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vouchers`
--

INSERT INTO `vouchers` (`id`, `code`, `name`, `description`, `discount_type`, `discount_value`, `min_order`, `max_discount`, `is_active`, `created_at`) VALUES
(1, 'REACT50', 'React Developer', 'Diskon 15% untuk para React Developer', 'percentage', 15.00, 50000.00, 25000.00, 1, '2025-05-23 03:49:03'),
(2, 'NODEJS20', 'Node.js Master', 'Diskon Rp 20,000 untuk Node.js enthusiast', 'fixed', 20000.00, 75000.00, NULL, 1, '2025-05-23 03:49:03'),
(3, 'PYTHON15', 'Python Coder', 'Diskon 10% untuk Python programmer', 'percentage', 10.00, 40000.00, 15000.00, 1, '2025-05-23 03:49:03'),
(4, 'LARAVEL25', 'Laravel Artisan', 'Diskon Rp 25,000 untuk Laravel developer', 'fixed', 25000.00, 100000.00, NULL, 1, '2025-05-23 03:49:03'),
(5, 'JAVASCRIPT', 'JS Ninja', 'Diskon 12% untuk JavaScript master', 'percentage', 12.00, 60000.00, 20000.00, 1, '2025-05-23 03:49:03'),
(6, 'NEXTJS30', 'Next.js Pro', 'Diskon Rp 30,000 untuk Next.js developer', 'fixed', 30000.00, 120000.00, NULL, 1, '2025-05-23 03:49:03'),
(7, 'FLUTTER10', 'Flutter Dev', 'Diskon 8% untuk Flutter developer', 'percentage', 8.00, 35000.00, 12000.00, 1, '2025-05-23 03:49:03'),
(8, 'ANGULAR20', 'Angular Expert', 'Diskon Rp 20,000 untuk Angular specialist', 'fixed', 20000.00, 80000.00, NULL, 1, '2025-05-23 03:49:03'),
(9, 'SPRINGDEV20', 'Spring Developer', 'Diskon Rp 20,000 untuk pengguna Spring Framework', 'fixed', 20000.00, 80000.00, NULL, 1, '2025-05-28 15:19:36'),
(10, 'HIBERNATE10', 'Hibernate Hero', 'Diskon 10% untuk user Hibernate ORM', 'percentage', 10.00, 60000.00, 18000.00, 1, '2025-05-28 15:19:36'),
(11, 'DJANGO25', 'Django Ninja', 'Diskon Rp 25,000 untuk pengembang Django', 'fixed', 25000.00, 95000.00, NULL, 1, '2025-05-28 15:19:36'),
(12, 'FLASK10', 'Flask Minimalist', 'Diskon 10% untuk pengguna Flask yang simple', 'percentage', 10.00, 50000.00, 15000.00, 1, '2025-05-28 15:19:36'),
(13, 'FASTAPI15', 'FastAPI Speedster', 'Diskon 15% untuk API developer dengan FastAPI', 'percentage', 15.00, 70000.00, 20000.00, 1, '2025-05-28 15:19:36'),
(14, 'CODEIGNITER15', 'CodeIgniter Power', 'Diskon 15% untuk pengguna CodeIgniter', 'percentage', 15.00, 55000.00, 17000.00, 1, '2025-05-28 15:19:36'),
(15, 'SYMFONY20', 'Symfony Pro', 'Diskon Rp 20,000 untuk developer Symfony', 'fixed', 20000.00, 70000.00, NULL, 1, '2025-05-28 15:19:36'),
(16, 'EMBER15', 'Ember Fire', 'Diskon 15% untuk pengembang Ember.js', 'percentage', 15.00, 65000.00, 20000.00, 1, '2025-05-28 15:19:36'),
(17, 'BACKBONE10', 'Backbone Classic', 'Diskon 10% untuk pengguna Backbone.js', 'percentage', 10.00, 50000.00, 15000.00, 1, '2025-05-28 15:19:36'),
(18, 'REACTNATIVE20', 'React Native Mobile', 'Diskon Rp 20,000 untuk developer React Native', 'fixed', 20000.00, 80000.00, NULL, 1, '2025-05-28 15:19:36'),
(19, 'FLUTTERXTRA12', 'Flutter Boost', 'Diskon 12% untuk fans Flutter sejati', 'percentage', 12.00, 60000.00, 18000.00, 1, '2025-05-28 15:19:36'),
(20, 'XAMARIN15', 'Xamarin Xpert', 'Diskon 15% untuk pengguna Xamarin', 'percentage', 15.00, 70000.00, 21000.00, 1, '2025-05-28 15:19:36'),
(21, 'IONIC10', 'Ionic Coder', 'Diskon 10% untuk pengguna Ionic Framework', 'percentage', 10.00, 55000.00, 17000.00, 1, '2025-05-28 15:19:36'),
(22, 'EXPRESSJS20', 'Express Route', 'Diskon Rp 20,000 untuk backend developer Express.js', 'fixed', 20000.00, 75000.00, NULL, 1, '2025-05-28 15:19:36'),
(23, 'NESTJS25', 'NestJS Warrior', 'Diskon Rp 25,000 untuk arsitek NestJS', 'fixed', 25000.00, 90000.00, NULL, 1, '2025-05-28 15:19:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `voucher_id` (`voucher_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reservation_number` (`reservation_number`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `reservation_datetime` (`reservation_date`,`reservation_time`);

--
-- Indexes for table `reservation_history`
--
ALTER TABLE `reservation_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservation_id` (`reservation_id`);

--
-- Indexes for table `room_tables`
--
ALTER TABLE `room_tables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `room_table_unique` (`room_type`,`table_number`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_voucher_usage`
--
ALTER TABLE `user_voucher_usage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `voucher_id` (`voucher_id`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=310;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `reservation_history`
--
ALTER TABLE `reservation_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `room_tables`
--
ALTER TABLE `room_tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_voucher_usage`
--
ALTER TABLE `user_voucher_usage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_voucher` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `reservation_history`
--
ALTER TABLE `reservation_history`
  ADD CONSTRAINT `reservation_history_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_voucher_usage`
--
ALTER TABLE `user_voucher_usage`
  ADD CONSTRAINT `user_voucher_usage_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `user_voucher_usage_ibfk_2` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
