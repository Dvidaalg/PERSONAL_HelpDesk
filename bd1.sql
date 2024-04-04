-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-04-2024 a las 14:05:30
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd1`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `filtrar_ticket` (IN `tick_titulo` VARCHAR(50), IN `cat_id` INT, IN `prio_id` INT)   BEGIN

IF tick_titulo = '' THEN
SET tick_titulo = NULL;
END IF;

IF cat_id = '' THEN
SET cat_id = NULL;
END IF;

IF prio_id = '' THEN
SET prio_id = NULL;
END IF;

SELECT 
tm_ticket.tick_id,
tm_ticket.usu_id,
tm_ticket.cat_id,
tm_ticket.tick_titulo,
tm_ticket.tick_descrip,
tm_ticket.tick_estado,
tm_ticket.fech_crea,
tm_ticket.fech_cierre,
tm_ticket.usu_asig,
tm_ticket.fech_asig, 
tm_usuario.usu_nom,
tm_usuario.usu_ape,
tm_categoria.cat_nom,
tm_ticket.prio_id,
tm_prioridad.prio_nom
FROM 
tm_ticket
INNER join tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id
INNER join tm_usuario on tm_ticket.usu_id = tm_usuario.usu_id
INNER join tm_prioridad on tm_ticket.prio_id = tm_prioridad.prio_id
WHERE
tm_ticket.est = 1
AND tm_ticket.tick_titulo like IFNULL(tick_titulo,tm_ticket.tick_titulo)
AND tm_ticket.cat_id = IFNULL(cat_id,tm_ticket.cat_id)
AND tm_ticket.prio_id = IFNULL(prio_id,tm_ticket.prio_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ticket_compras` (IN `tick_titulo` VARCHAR(1590), IN `prio_id` INT(11))   BEGIN

IF tick_titulo = '' THEN
SET tick_titulo = NULL;
END IF;

IF prio_id = '' THEN
SET prio_id = NULL;
END IF;

SELECT 
tm_ticket.tick_id,
tm_ticket.usu_id,
tm_ticket.cat_id,
tm_ticket.tick_titulo,
tm_ticket.tick_descrip,
tm_ticket.tick_estado,
tm_ticket.fech_crea,
tm_ticket.fech_cierre,
tm_ticket.usu_asig,
tm_ticket.fech_asig, 
tm_usuario.usu_nom,
tm_usuario.usu_ape,
tm_categoria.cat_nom,
tm_ticket.prio_id,
tm_prioridad.prio_nom
FROM 
tm_ticket
INNER JOIN tm_categoria ON tm_ticket.cat_id = tm_categoria.cat_id
INNER JOIN tm_usuario ON tm_ticket.usu_id = tm_usuario.usu_id
INNER JOIN tm_prioridad ON tm_ticket.prio_id = tm_prioridad.prio_id
WHERE
tm_ticket.est = 1
AND tm_ticket.tick_titulo LIKE IFNULL(tick_titulo, tm_ticket.tick_titulo)
AND tm_ticket.prio_id = IFNULL(prio_id, tm_ticket.prio_id)
AND tm_categoria.cat_nom = 'Compras';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ticket_TNO` (IN `tick_titulo` VARCHAR(50), IN `prio_id` INT)   BEGIN

IF tick_titulo = '' THEN
SET tick_titulo = NULL;
END IF;

IF prio_id = '' THEN
SET prio_id = NULL;
END IF;

SELECT 
tm_ticket.tick_id,
tm_ticket.usu_id,
tm_ticket.cat_id,
tm_ticket.tick_titulo,
tm_ticket.tick_descrip,
tm_ticket.tick_estado,
tm_ticket.fech_crea,
tm_ticket.fech_cierre,
tm_ticket.usu_asig,
tm_ticket.fech_asig, 
tm_usuario.usu_nom,
tm_usuario.usu_ape,
tm_categoria.cat_nom,
tm_ticket.prio_id,
tm_prioridad.prio_nom
FROM 
tm_ticket
INNER join tm_categoria on tm_ticket.cat_id = tm_categoria.cat_id
INNER join tm_usuario on 
tm_ticket.usu_id = tm_usuario.usu_id
INNER join tm_prioridad on tm_ticket.prio_id = tm_prioridad.prio_id
WHERE
tm_ticket.est = 1
AND tm_ticket.tick_titulo like IFNULL(tick_titulo,tm_ticket.tick_titulo)
AND tm_ticket.prio_id = IFNULL(prio_id,tm_ticket.prio_id)
AND tm_categoria.cat_nom = 'TNO'; -- Filtra por la categoría TNO
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_d_usuario_01` (IN `xusu_id` INT)   BEGIN
	UPDATE tm_usuario 
	SET 
		est='0',
		fech_elim = now() 
	where usu_id=xusu_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_i_ticketdetalle_01` (IN `xtick_id` INT, IN `xusu_id` INT)   BEGIN
	INSERT INTO td_ticketdetalle 
    (tickd_id,tick_id,usu_id,tickd_descrip,fech_crea,est) 
    VALUES 
    (NULL,xtick_id,xusu_id,'Ticket Cerrado...',now(),'1');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_usuario_01` ()   BEGIN
	SELECT * FROM tm_usuario where est='1';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_l_usuario_02` (IN `xusu_id` INT)   BEGIN
	SELECT * FROM tm_usuario where usu_id=xusu_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento`
--

CREATE TABLE `td_documento` (
  `doc_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `doc_nom` varchar(400) NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_documento`
--

INSERT INTO `td_documento` (`doc_id`, `tick_id`, `doc_nom`, `fech_crea`, `est`) VALUES
(14, 107, 'D_NQ_NP_929234-MLM44681467680_012021-F.jpg', '2024-03-21 09:40:57', 1),
(15, 108, 'D_NQ_NP_929234-MLM44681467680_012021-F.jpg', '2024-03-21 09:59:18', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_documento_detalle`
--

CREATE TABLE `td_documento_detalle` (
  `det_id` int(11) NOT NULL,
  `tickd_id` int(11) NOT NULL,
  `det_nom` varchar(200) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `td_documento_detalle`
--

INSERT INTO `td_documento_detalle` (`det_id`, `tickd_id`, `det_nom`, `est`) VALUES
(9, 123, 'D_NQ_NP_929234-MLM44681467680_012021-F.jpg', 1),
(10, 124, 'D_NQ_NP_929234-MLM44681467680_012021-F.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_ticketdetalle`
--

CREATE TABLE `td_ticketdetalle` (
  `tickd_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `tickd_descrip` mediumtext NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_ticketdetalle`
--

INSERT INTO `td_ticketdetalle` (`tickd_id`, `tick_id`, `usu_id`, `tickd_descrip`, `fech_crea`, `est`) VALUES
(123, 107, 13, '<p>buenos dias, espero pronta respuesta</p>', '2024-03-21 09:41:26', 1),
(124, 108, 13, '<p>buenos dias, solicito reparar lo que esta en la foto por favor&nbsp;</p>', '2024-03-21 09:59:47', 1),
(125, 108, 13, '<p>quedo atento a su respuesta</p>', '2024-03-21 09:59:59', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_categoria`
--

CREATE TABLE `tm_categoria` (
  `cat_id` int(11) NOT NULL,
  `cat_nom` varchar(150) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_categoria`
--

INSERT INTO `tm_categoria` (`cat_id`, `cat_nom`, `est`) VALUES
(7, 'COMPRAS', 1),
(9, 'TNO', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_estado`
--

CREATE TABLE `tm_estado` (
  `est_id` int(11) NOT NULL,
  `est_nom` varchar(50) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_estado`
--

INSERT INTO `tm_estado` (`est_id`, `est_nom`, `est`) VALUES
(1, 'Abierto', 1),
(2, 'En Tratamiento', 1),
(3, 'Cerrado', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_notificacion`
--

CREATE TABLE `tm_notificacion` (
  `not_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `not _mensaje` varchar(400) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_prioridad`
--

CREATE TABLE `tm_prioridad` (
  `prio_id` int(11) NOT NULL,
  `prio_nom` varchar(50) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `tm_prioridad`
--

INSERT INTO `tm_prioridad` (`prio_id`, `prio_nom`, `est`) VALUES
(1, 'Bajo', 1),
(2, 'Medio', 1),
(3, 'Alto', 1),
(5, 'Urgente', 1),
(7, 're urgente ', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_subcategoria`
--

CREATE TABLE `tm_subcategoria` (
  `cats_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cats_nom` varchar(150) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `tm_subcategoria`
--

INSERT INTO `tm_subcategoria` (`cats_id`, `cat_id`, `cats_nom`, `est`) VALUES
(1, 7, 'Cotización de producto', 1),
(2, 7, 'Compra de producto', 1),
(3, 9, 'Reparaciones infraestructura ', 1),
(4, 9, 'Reparaciones electrónicas', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_ticket`
--

CREATE TABLE `tm_ticket` (
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cats_id` int(11) NOT NULL,
  `tick_titulo` varchar(250) NOT NULL,
  `tick_descrip` mediumtext NOT NULL,
  `tick_estado` varchar(15) DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `usu_asig` int(11) DEFAULT NULL,
  `fech_asig` datetime DEFAULT NULL,
  `fech_cierre` datetime DEFAULT NULL,
  `prio_id` int(11) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_ticket`
--

INSERT INTO `tm_ticket` (`tick_id`, `usu_id`, `cat_id`, `cats_id`, `tick_titulo`, `tick_descrip`, `tick_estado`, `fech_crea`, `usu_asig`, `fech_asig`, `fech_cierre`, `prio_id`, `est`) VALUES
(107, 13, 7, 1, 'primera prueba de compras', '<p>Buenos dias, solicito cotizar el siguiente producto</p>', '1', '2024-03-21 09:40:57', NULL, NULL, NULL, 1, 1),
(108, 13, 9, 3, 'primera prueba de tno', '<p>buenos dias, solicito reparar lo que esta en la imagen por favor&nbsp;</p>', '1', '2024-03-21 09:59:18', NULL, NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE `tm_usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nom` varchar(150) DEFAULT NULL,
  `usu_ape` varchar(150) DEFAULT NULL,
  `usu_correo` varchar(150) NOT NULL,
  `usu_pass` varchar(150) NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `fech_modi` datetime DEFAULT NULL,
  `fech_elim` datetime DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla Mantenedor de Usuarios';

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`usu_id`, `usu_nom`, `usu_ape`, `usu_correo`, `usu_pass`, `rol_id`, `emp_id`, `fech_crea`, `fech_modi`, `fech_elim`, `est`) VALUES
(12, 'admin general', 'Invertec', 'admin@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 2, NULL, '2024-03-07 12:01:49', NULL, '2024-03-12 12:25:25', 1),
(13, 'Diego', 'Vidal', 'diego@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, '2024-03-07 12:02:10', NULL, NULL, 1),
(25, 'Diego', 'Gaete', 'dgaete@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, '2024-03-18 11:40:24', NULL, NULL, 1),
(27, 'Departamento ', 'TNO', 'tno@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 3, 1, '2024-03-18 16:16:44', NULL, NULL, 1),
(28, 'Departamento', 'Compras', 'compras@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 3, 2, '2024-03-18 16:16:58', NULL, NULL, 1),
(29, 'Julia', 'lizama', 'jlizama@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, '2024-03-18 16:17:41', NULL, NULL, 1),
(31, 'Sergio uribe ', 'marchant', 'sergio@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 2, 1, '2024-03-21 10:45:33', NULL, NULL, 1),
(32, 'Wilmer Correa ', 'perez', 'wilmer@invertec.cl', 'e10adc3949ba59abbe56e057f20f883e', 2, 1, '2024-03-21 10:47:15', NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `td_documento`
--
ALTER TABLE `td_documento`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indices de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  ADD PRIMARY KEY (`det_id`);

--
-- Indices de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  ADD PRIMARY KEY (`tickd_id`);

--
-- Indices de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `tm_estado`
--
ALTER TABLE `tm_estado`
  ADD PRIMARY KEY (`est_id`);

--
-- Indices de la tabla `tm_notificacion`
--
ALTER TABLE `tm_notificacion`
  ADD PRIMARY KEY (`not_id`);

--
-- Indices de la tabla `tm_prioridad`
--
ALTER TABLE `tm_prioridad`
  ADD PRIMARY KEY (`prio_id`);

--
-- Indices de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  ADD PRIMARY KEY (`cats_id`);

--
-- Indices de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  ADD PRIMARY KEY (`tick_id`);

--
-- Indices de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  ADD PRIMARY KEY (`usu_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `td_documento`
--
ALTER TABLE `td_documento`
  MODIFY `doc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `td_documento_detalle`
--
ALTER TABLE `td_documento_detalle`
  MODIFY `det_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  MODIFY `tickd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tm_estado`
--
ALTER TABLE `tm_estado`
  MODIFY `est_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tm_notificacion`
--
ALTER TABLE `tm_notificacion`
  MODIFY `not_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tm_prioridad`
--
ALTER TABLE `tm_prioridad`
  MODIFY `prio_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  MODIFY `cats_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  MODIFY `tick_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
