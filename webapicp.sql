-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.37-log - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para webapicp
CREATE DATABASE IF NOT EXISTS `webapicp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci */;
USE `webapicp`;

-- Volcando estructura para tabla webapicp.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `ultimo_pago` datetime DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla webapicp.clientes: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `nombre`, `telefono`, `ultimo_pago`, `fecha_creacion`) VALUES
	(1, 'Felipe de Jesús', '5565243766', '2022-03-28 14:38:41', '2022-03-27 11:39:45'),
	(2, 'Jesus', '5543567897', '2022-03-29 01:32:43', '2022-03-27 11:24:16'),
	(3, 'Juan', '55792739', '2022-03-30 05:24:14', '2022-03-28 08:49:35'),
	(6, 'Oscar', '4453434', NULL, '2022-03-30 03:04:39'),
	(7, 'karla', '34534353', '2022-03-30 05:52:22', '2022-03-30 04:40:53'),
	(8, 'Alan', '5663434', NULL, '2022-03-30 04:42:55'),
	(9, 'David', '55634482', NULL, '2022-03-30 04:43:29'),
	(10, 'Kaytlen', '554634', '2022-03-30 05:55:13', '2022-03-30 04:51:15'),
	(11, 'Laura', '644523', '2022-03-30 06:07:41', '2022-03-30 06:07:25');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla webapicp.clientes_pagos_anterior
CREATE TABLE IF NOT EXISTS `clientes_pagos_anterior` (
  `cliente_id` int(11) NOT NULL,
  `pago_id` int(11) NOT NULL,
  KEY `cliente_pagp` (`cliente_id`),
  KEY `pago_cliente` (`pago_id`),
  CONSTRAINT `cliente_pagp` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pago_cliente` FOREIGN KEY (`pago_id`) REFERENCES `pagos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla webapicp.clientes_pagos_anterior: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `clientes_pagos_anterior` DISABLE KEYS */;
INSERT INTO `clientes_pagos_anterior` (`cliente_id`, `pago_id`) VALUES
	(2, 6),
	(1, 11),
	(1, 12),
	(1, 13),
	(1, 14);
/*!40000 ALTER TABLE `clientes_pagos_anterior` ENABLE KEYS */;

-- Volcando estructura para tabla webapicp.pagos
CREATE TABLE IF NOT EXISTS `pagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `monto` double NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_pagos` (`cliente_id`),
  CONSTRAINT `cliente_pagos` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla webapicp.pagos: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` (`id`, `cliente_id`, `monto`, `fecha_creacion`) VALUES
	(1, 1, 43523, '2022-03-28 09:34:06'),
	(2, 2, 67353, '2022-03-28 09:34:06'),
	(3, 1, 4654, '2022-03-28 09:53:46'),
	(4, 1, 8676, '2022-03-27 09:53:46'),
	(5, 1, 14293, '2022-03-28 14:38:41'),
	(6, 2, 3423, '2022-03-29 01:32:43'),
	(7, 3, 9032, '2022-03-30 05:24:14'),
	(8, 7, 7860, '2022-03-30 05:52:22'),
	(9, 10, 9087, '2022-03-30 05:55:13'),
	(10, 11, 8076, '2022-03-30 06:07:41'),
	(11, 1, 2355, '2022-03-29 06:39:55'),
	(12, 1, 45634, '2022-03-29 06:40:02'),
	(13, 1, 6785, '2022-03-29 06:40:06'),
	(14, 1, 1097, '2022-03-29 06:40:12');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;

-- Volcando estructura para procedimiento webapicp.sp_pagoscliente
DELIMITER //
CREATE PROCEDURE `sp_pagoscliente`(
	IN `p_clienteid` INT,
	IN `p_monto` DOUBLE,
	IN `p_fechacreacion` DATETIME
)
    DETERMINISTIC
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
DECLARE EXIT HANDLER FOR SQLWARNING ROLLBACK;

INSERT INTO pagos (cliente_id, monto, fecha_creacion) VALUES (p_clienteid, p_monto, p_fechacreacion);

UPDATE clientes SET ultimo_pago=p_fechacreacion WHERE id = p_clienteid;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
