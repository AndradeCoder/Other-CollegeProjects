-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2022 at 06:42 AM
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
-- Database: `mundial_futebol`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `golos_NoJogo` (`jg_ID` INT(11)) RETURNS INT(11)  BEGIN
DECLARE golos numeric;
SELECT COUNT(*) INTO golos
FROM golo g, jogo j
WHERE g.Jogo_Numero=jg_ID AND g.Jogo_Numero=j.Numero
GROUP BY g.Jogo_Numero;

IF(golos IS NULL) THEN
 RETURN 0;
ELSE RETURN golos;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cartaoamarelo`
--

CREATE TABLE `cartaoamarelo` (
  `Penalizacao_Jogo_numero` int(11) NOT NULL,
  `Penalizacao_NumeroCartao` tinyint(4) NOT NULL,
  `JogadorEmCampo_Jogo_numero` int(11) NOT NULL,
  `JogadorEmCampo_Pais` varchar(60) NOT NULL,
  `JogadorEmCampo_Ano` smallint(6) NOT NULL,
  `JogadorEmCampo_NumCamisola` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cartaovermelho`
--

CREATE TABLE `cartaovermelho` (
  `Penalizacao_Jogo_numero` int(11) NOT NULL,
  `Penalizacao_NumeroCartao` tinyint(4) NOT NULL,
  `JogadorEmCampo_Jogo_numero` int(11) NOT NULL,
  `JogadorEmCampo_Pais` varchar(60) NOT NULL,
  `JogadorEmCampo_Ano` smallint(6) NOT NULL,
  `JogadorEmCampo_NumCamisola` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cartaovermelho`
--

INSERT INTO `cartaovermelho` (`Penalizacao_Jogo_numero`, `Penalizacao_NumeroCartao`, `JogadorEmCampo_Jogo_numero`, `JogadorEmCampo_Pais`, `JogadorEmCampo_Ano`, `JogadorEmCampo_NumCamisola`) VALUES
(1, 2, 1, 'Espanha', 2022, 11),
(1, 1, 1, 'Portugal', 2022, 4),
(3, 1, 3, 'Portugal', 2018, 23),
(4, 1, 4, 'Espanha', 2022, 11);

-- --------------------------------------------------------

--
-- Table structure for table `clubefutebol`
--

CREATE TABLE `clubefutebol` (
  `NomeClube` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comitiva`
--

CREATE TABLE `comitiva` (
  `Pais` varchar(60) NOT NULL,
  `Ano` smallint(6) NOT NULL,
  `Mascote` varchar(60) DEFAULT NULL,
  `Patrocinador_Oficial_sigla` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comitiva`
--

INSERT INTO `comitiva` (`Pais`, `Ano`, `Mascote`, `Patrocinador_Oficial_sigla`) VALUES
('Espanha', 2018, NULL, 'SAM'),
('Espanha', 2022, NULL, 'NOK'),
('Marrocos', 2022, NULL, 'SAM'),
('Portugal', 2018, NULL, 'HUA'),
('Portugal', 2022, NULL, 'APL'),
('Suíça', 2018, NULL, 'NOK'),
('Suíça', 2022, NULL, 'HUA');

-- --------------------------------------------------------

--
-- Table structure for table `edicao`
--

CREATE TABLE `edicao` (
  `Ano` smallint(6) NOT NULL,
  `Designacao` varchar(60) DEFAULT NULL,
  `Orcamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `edicao`
--

INSERT INTO `edicao` (`Ano`, `Designacao`, `Orcamento`) VALUES
(2014, 'Brasil World Cup 2014', 20345),
(2018, 'Russia World Cup 2018', 30000),
(2022, 'Qatar World Cup 2022', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `elementocomitiva`
--

CREATE TABLE `elementocomitiva` (
  `NumeroSerie` smallint(6) NOT NULL,
  `Comitiva_Pais` varchar(60) NOT NULL,
  `Comitiva_Ano` smallint(6) NOT NULL,
  `Pessoa_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `elementocomitiva`
--

INSERT INTO `elementocomitiva` (`NumeroSerie`, `Comitiva_Pais`, `Comitiva_Ano`, `Pessoa_ID`) VALUES
(1, 'Portugal', 2022, 5),
(2, 'Suíça', 2022, 2),
(3, 'Espanha', 2022, 3),
(4, 'Marrocos', 2022, 4),
(5, 'Marrocos', 2022, 1),
(6, 'Marrocos', 2022, 6),
(7, 'Espanha', 2022, 7),
(8, 'Espanha', 2018, 8),
(9, 'Suíça', 2018, 9),
(10, 'Portugal', 2022, 10),
(11, 'Portugal', 2018, 10),
(12, 'Portugal', 2018, 11);

-- --------------------------------------------------------

--
-- Table structure for table `equipajogo`
--

CREATE TABLE `equipajogo` (
  `Jogo_numero` int(11) NOT NULL,
  `Selecao_Pais` varchar(60) NOT NULL,
  `Selecao_Ano` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipajogo`
--

INSERT INTO `equipajogo` (`Jogo_numero`, `Selecao_Pais`, `Selecao_Ano`) VALUES
(1, 'Espanha', 2022),
(1, 'Portugal', 2022),
(2, 'Marrocos', 2022),
(2, 'Suíça', 2022),
(3, 'Portugal', 2018),
(3, 'Suíça', 2018),
(4, 'Espanha', 2022),
(4, 'Marrocos', 2022),
(21, 'Marrocos', 2022),
(21, 'Portugal', 2022);

-- --------------------------------------------------------

--
-- Table structure for table `estadio`
--

CREATE TABLE `estadio` (
  `Nome` varchar(60) NOT NULL,
  `Pais_nome` varchar(60) NOT NULL,
  `Localidade` varchar(60) DEFAULT NULL,
  `Lotacao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `federacao`
--

CREATE TABLE `federacao` (
  `Nome` varchar(60) NOT NULL,
  `Pais` varchar(60) NOT NULL,
  `NumFederados` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `federacao`
--

INSERT INTO `federacao` (`Nome`, `Pais`, `NumFederados`) VALUES
('Federação Espanhola de Futebol', 'Espanha', NULL),
('Federação Marroquina de Futebol', 'Marrocos', NULL),
('Federação Portuguesa de Futebol', 'Portugal', NULL),
('Federação Suíça de Futebol ', 'Suíça', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `funcao`
--

CREATE TABLE `funcao` (
  `Funcao` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `funcaotecnica`
--

CREATE TABLE `funcaotecnica` (
  `Funcao` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `golo`
--

CREATE TABLE `golo` (
  `Jogo_Numero` int(11) NOT NULL,
  `Golo_Numero` tinyint(4) NOT NULL,
  `Marcador_JogadorEmCampo_Jogo_numero` int(11) NOT NULL,
  `Marcador_JogadorEmCampo_Pais` varchar(60) NOT NULL,
  `Marcador_JogadorEmCampo_Ano` smallint(6) NOT NULL,
  `Marcador_JogadorEmCampo_NumCamisola` tinyint(4) NOT NULL,
  `Assistencia_JogadorEmCampo_Jogo_numero` int(11) DEFAULT NULL,
  `Assistencia_JogadorEmCampo_Pais` varchar(60) DEFAULT NULL,
  `Assistencia_JogadorEmCampo_Ano` smallint(6) DEFAULT NULL,
  `Assistencia_JogadorEmCampo_NumCamisola` tinyint(4) DEFAULT NULL,
  `Momento` time DEFAULT NULL,
  `Autogolo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `golo`
--

INSERT INTO `golo` (`Jogo_Numero`, `Golo_Numero`, `Marcador_JogadorEmCampo_Jogo_numero`, `Marcador_JogadorEmCampo_Pais`, `Marcador_JogadorEmCampo_Ano`, `Marcador_JogadorEmCampo_NumCamisola`, `Assistencia_JogadorEmCampo_Jogo_numero`, `Assistencia_JogadorEmCampo_Pais`, `Assistencia_JogadorEmCampo_Ano`, `Assistencia_JogadorEmCampo_NumCamisola`, `Momento`, `Autogolo`) VALUES
(1, 1, 1, 'Portugal', 2022, 7, 2, 'Suíça', 2022, 8, NULL, NULL),
(1, 2, 1, 'Portugal', 2022, 7, 2, 'Suíça', 2022, 8, NULL, NULL),
(1, 4, 1, 'Espanha', 2022, 11, 2, 'Marrocos', 2022, 20, NULL, NULL),
(2, 2, 2, 'Suíça', 2022, 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 3, 2, 'Marrocos', 2022, 9, 1, 'Espanha', 2022, 11, NULL, NULL),
(21, 1, 21, 'Marrocos', 2022, 5, 21, 'Marrocos', 2022, 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `grupo`
--

CREATE TABLE `grupo` (
  `Edicao_Ano` smallint(6) NOT NULL,
  `Letra` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grupo`
--

INSERT INTO `grupo` (`Edicao_Ano`, `Letra`) VALUES
(2018, 'D'),
(2022, 'A'),
(2022, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `jogador`
--

CREATE TABLE `jogador` (
  `Pessoa_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jogador`
--

INSERT INTO `jogador` (`Pessoa_ID`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11);

-- --------------------------------------------------------

--
-- Table structure for table `jogadoremcampo`
--

CREATE TABLE `jogadoremcampo` (
  `Jogo_numero` int(11) NOT NULL,
  `JogadorSelecao_Pais` varchar(60) NOT NULL,
  `JogadorSelecao_Ano` smallint(6) NOT NULL,
  `JogadorSelecao_NumCamisola` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jogadoremcampo`
--

INSERT INTO `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) VALUES
(1, 'Espanha', 2022, 10),
(1, 'Espanha', 2022, 11),
(1, 'Portugal', 2022, 4),
(1, 'Portugal', 2022, 7),
(2, 'Marrocos', 2022, 5),
(2, 'Marrocos', 2022, 9),
(2, 'Marrocos', 2022, 20),
(2, 'Suíça', 2022, 8),
(3, 'Portugal', 2018, 4),
(3, 'Portugal', 2018, 23),
(4, 'Espanha', 2022, 11),
(4, 'Marrocos', 2022, 5),
(4, 'Marrocos', 2022, 9),
(21, 'Marrocos', 2022, 5);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jogadorescomvermelhos_ultimaedicao`
-- (See below for the actual view)
--
CREATE TABLE `jogadorescomvermelhos_ultimaedicao` (
`Ultima_Edicao` smallint(6)
,`Pais` varchar(60)
,`Nr_Camisola` tinyint(4)
,`Nr_Vermelhos` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jogadores_comsubstituicoes`
-- (See below for the actual view)
--
CREATE TABLE `jogadores_comsubstituicoes` (
`Edicao` smallint(6)
,`Pais` varchar(60)
,`Camisa_Jogador` tinyint(4)
,`Num_Substituicoes` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `jogadorjogo`
--

CREATE TABLE `jogadorjogo` (
  `JogadorSelecao_Pais` varchar(60) NOT NULL,
  `JogadorSelecao_Ano` smallint(6) NOT NULL,
  `JogadorSelecao_NumCamisola` tinyint(4) NOT NULL,
  `Jogo_numero` int(11) NOT NULL,
  `EstadoJogador` enum('convocado','dispensado','lesionado','castigado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jogadorjogo`
--

INSERT INTO `jogadorjogo` (`JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`, `Jogo_numero`, `EstadoJogador`) VALUES
('Espanha', 2022, 10, 1, NULL),
('Espanha', 2022, 11, 1, NULL),
('Espanha', 2022, 11, 4, NULL),
('Marrocos', 2022, 5, 2, NULL),
('Marrocos', 2022, 5, 4, NULL),
('Marrocos', 2022, 5, 21, NULL),
('Marrocos', 2022, 9, 2, NULL),
('Marrocos', 2022, 9, 4, NULL),
('Marrocos', 2022, 20, 2, NULL),
('Portugal', 2018, 4, 3, NULL),
('Portugal', 2018, 23, 3, NULL),
('Portugal', 2022, 4, 1, NULL),
('Portugal', 2022, 7, 1, NULL),
('Suíça', 2022, 8, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jogadorselecao`
--

CREATE TABLE `jogadorselecao` (
  `ElementoComitiva_Numero` smallint(6) NOT NULL,
  `ClubeFutebol_NomeClube` varchar(60) DEFAULT NULL,
  `Pessoa_ID` int(11) NOT NULL,
  `Selecao_Pais` varchar(60) NOT NULL,
  `Selecao_Ano` smallint(6) NOT NULL,
  `NumCamisola` tinyint(4) NOT NULL,
  `NumInternacionalizacoes` smallint(6) DEFAULT NULL,
  `EstadoJogador` enum('Convocado','Dispensado','Lesionado','Castigado') DEFAULT NULL,
  `PosicaoJogo` enum('guarda-redes','defesa','medio','avancado') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jogadorselecao`
--

INSERT INTO `jogadorselecao` (`ElementoComitiva_Numero`, `ClubeFutebol_NomeClube`, `Pessoa_ID`, `Selecao_Pais`, `Selecao_Ano`, `NumCamisola`, `NumInternacionalizacoes`, `EstadoJogador`, `PosicaoJogo`) VALUES
(8, NULL, 8, 'Espanha', 2018, 10, NULL, NULL, NULL),
(3, NULL, 3, 'Espanha', 2022, 10, NULL, NULL, NULL),
(7, NULL, 7, 'Espanha', 2022, 11, NULL, NULL, NULL),
(5, NULL, 1, 'Marrocos', 2022, 5, NULL, NULL, NULL),
(6, NULL, 6, 'Marrocos', 2022, 9, NULL, NULL, NULL),
(4, NULL, 4, 'Marrocos', 2022, 20, NULL, NULL, NULL),
(11, NULL, 10, 'Portugal', 2018, 4, NULL, NULL, NULL),
(12, NULL, 11, 'Portugal', 2018, 23, NULL, NULL, NULL),
(10, NULL, 10, 'Portugal', 2022, 4, NULL, NULL, NULL),
(1, NULL, 5, 'Portugal', 2022, 7, NULL, NULL, NULL),
(9, NULL, 9, 'Suíça', 2018, 8, NULL, NULL, NULL),
(2, NULL, 2, 'Suíça', 2022, 8, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jogo`
--

CREATE TABLE `jogo` (
  `Grupo_Edicao_Ano` smallint(6) DEFAULT NULL,
  `Grupo_Letra` char(1) DEFAULT NULL,
  `Estadio_Nome` varchar(60) DEFAULT NULL,
  `Numero` int(11) NOT NULL,
  `Fase` enum('Grupos','Oitavos','Quartos','Meias','Final') DEFAULT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jogo`
--

INSERT INTO `jogo` (`Grupo_Edicao_Ano`, `Grupo_Letra`, `Estadio_Nome`, `Numero`, `Fase`, `Data`) VALUES
(2022, 'A', NULL, 1, NULL, NULL),
(2022, 'B', NULL, 2, NULL, NULL),
(2018, NULL, NULL, 3, NULL, NULL),
(2022, 'A', NULL, 4, NULL, NULL),
(2022, 'A', NULL, 8, NULL, NULL),
(2022, 'A', NULL, 10, NULL, NULL),
(NULL, NULL, NULL, 11, NULL, NULL),
(NULL, NULL, NULL, 12, NULL, NULL),
(NULL, NULL, NULL, 21, NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `numero_participantes_edicao`
-- (See below for the actual view)
--
CREATE TABLE `numero_participantes_edicao` (
`Edicao` smallint(6)
,`Numero_participantes` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `organizacao`
--

CREATE TABLE `organizacao` (
  `Edicao_Ano_` smallint(6) NOT NULL,
  `Federacao_organizadora` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `organizacao`
--

INSERT INTO `organizacao` (`Edicao_Ano_`, `Federacao_organizadora`) VALUES
(2018, 'Federação Marroquina de Futebol'),
(2022, 'Federação Espanhola de Futebol'),
(2022, 'Federação Portuguesa de Futebol'),
(2022, 'Federação Suíça de Futebol ');

-- --------------------------------------------------------

--
-- Table structure for table `outrafuncao`
--

CREATE TABLE `outrafuncao` (
  `Funcao` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `outro`
--

CREATE TABLE `outro` (
  `ElementoComitiva_Numero` smallint(6) NOT NULL,
  `Funcao` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pais`
--

CREATE TABLE `pais` (
  `Nome` varchar(60) NOT NULL,
  `NumHabitantes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pais`
--

INSERT INTO `pais` (`Nome`, `NumHabitantes`) VALUES
('Brasil', NULL),
('Espanha', NULL),
('Marrocos', NULL),
('Portugal', NULL),
('Suíça', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patrocinador`
--

CREATE TABLE `patrocinador` (
  `Sigla` char(4) NOT NULL,
  `Nome` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patrocinador`
--

INSERT INTO `patrocinador` (`Sigla`, `Nome`) VALUES
('APL', NULL),
('HP', NULL),
('HUA', NULL),
('NOK', NULL),
('SAM', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patrocinio`
--

CREATE TABLE `patrocinio` (
  `Comitiva_Pais_` varchar(60) NOT NULL,
  `Comitiva_Ano_` smallint(6) NOT NULL,
  `Patrocinador_Sigla_` char(4) NOT NULL,
  `Montante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patrocinio`
--

INSERT INTO `patrocinio` (`Comitiva_Pais_`, `Comitiva_Ano_`, `Patrocinador_Sigla_`, `Montante`) VALUES
('Espanha', 2018, 'SAM', 390),
('Espanha', 2022, 'APL', 100),
('Espanha', 2022, 'HP', 400),
('Marrocos', 2022, 'SAM', 100),
('Portugal', 2022, 'APL', 100),
('Suíça', 2022, 'HUA', 100);

-- --------------------------------------------------------

--
-- Table structure for table `penalizacao`
--

CREATE TABLE `penalizacao` (
  `Jogo_Numero` int(11) NOT NULL,
  `NumeroCartao` tinyint(4) NOT NULL,
  `Momento` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penalizacao`
--

INSERT INTO `penalizacao` (`Jogo_Numero`, `NumeroCartao`, `Momento`) VALUES
(1, 1, NULL),
(1, 2, NULL),
(1, 3, NULL),
(2, 1, NULL),
(2, 2, NULL),
(3, 1, NULL),
(4, 1, NULL),
(12, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pessoa`
--

CREATE TABLE `pessoa` (
  `Pessoa_ID` int(11) NOT NULL,
  `Nome` varchar(60) DEFAULT NULL,
  `DtNasc` date DEFAULT NULL,
  `Pais_Nome` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pessoa`
--

INSERT INTO `pessoa` (`Pessoa_ID`, `Nome`, `DtNasc`, `Pais_Nome`) VALUES
(1, NULL, NULL, 'Portugal'),
(2, NULL, NULL, 'Suíça'),
(3, NULL, NULL, 'Espanha'),
(4, NULL, NULL, 'Marrocos'),
(5, NULL, NULL, 'Portugal'),
(6, NULL, NULL, 'Marrocos'),
(7, NULL, NULL, 'Suíça'),
(8, NULL, NULL, 'Portugal'),
(9, NULL, NULL, 'Portugal'),
(10, NULL, NULL, 'Brasil'),
(11, NULL, NULL, 'Espanha'),
(12, NULL, NULL, 'Marrocos');

-- --------------------------------------------------------

--
-- Table structure for table `presidente`
--

CREATE TABLE `presidente` (
  `ElementoComitiva_Numero` smallint(6) NOT NULL,
  `AnoNomeacao` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `selecao`
--

CREATE TABLE `selecao` (
  `Pais` varchar(60) NOT NULL,
  `Ano` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `selecao`
--

INSERT INTO `selecao` (`Pais`, `Ano`) VALUES
('Espanha', 2018),
('Espanha', 2022),
('Marrocos', 2022),
('Portugal', 2018),
('Portugal', 2022),
('Suíça', 2018),
('Suíça', 2022);

-- --------------------------------------------------------

--
-- Stand-in structure for view `selecao_num_jogo`
-- (See below for the actual view)
--
CREATE TABLE `selecao_num_jogo` (
`JogoID` int(11)
,`Selecao` varchar(60)
);

-- --------------------------------------------------------

--
-- Table structure for table `substituicao`
--

CREATE TABLE `substituicao` (
  `Substituido_Jogo_numero` int(11) NOT NULL,
  `Substituido_JogadorSelecao_Pais` varchar(60) NOT NULL,
  `Substituido_JogadorSelecao_Ano` smallint(6) NOT NULL,
  `Substituido_JogadorSelecao_NumCamisola` tinyint(4) NOT NULL,
  `Substituto_Jogo_numero` int(11) NOT NULL,
  `Substituto_JogadorSelecao_Pais` varchar(60) NOT NULL,
  `Substituto_JogadorSelecao_Ano` smallint(6) NOT NULL,
  `Substituto_JogadorSelecao_NumCamisola` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `substituicao`
--

INSERT INTO `substituicao` (`Substituido_Jogo_numero`, `Substituido_JogadorSelecao_Pais`, `Substituido_JogadorSelecao_Ano`, `Substituido_JogadorSelecao_NumCamisola`, `Substituto_Jogo_numero`, `Substituto_JogadorSelecao_Pais`, `Substituto_JogadorSelecao_Ano`, `Substituto_JogadorSelecao_NumCamisola`) VALUES
(1, 'Portugal', 2022, 4, 1, 'Portugal', 2022, 7),
(2, 'Marrocos', 2022, 9, 2, 'Marrocos', 2022, 20),
(3, 'Portugal', 2018, 4, 3, 'Portugal', 2018, 23),
(4, 'Marrocos', 2022, 9, 4, 'Marrocos', 2022, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tecnico`
--

CREATE TABLE `tecnico` (
  `ElementoComitiva_Numero` smallint(6) NOT NULL,
  `Funcao` varchar(30) NOT NULL,
  `AnosExperiencia` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure for view `jogadorescomvermelhos_ultimaedicao`
--
DROP TABLE IF EXISTS `jogadorescomvermelhos_ultimaedicao`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jogadorescomvermelhos_ultimaedicao`  AS SELECT `cv`.`JogadorEmCampo_Ano` AS `Ultima_Edicao`, `cv`.`JogadorEmCampo_Pais` AS `Pais`, `cv`.`JogadorEmCampo_NumCamisola` AS `Nr_Camisola`, count(0) AS `Nr_Vermelhos` FROM `cartaovermelho` AS `cv` WHERE `cv`.`JogadorEmCampo_Ano` = (select max(`edicao`.`Ano`) from `edicao`) GROUP BY `cv`.`JogadorEmCampo_NumCamisola` ;

-- --------------------------------------------------------

--
-- Structure for view `jogadores_comsubstituicoes`
--
DROP TABLE IF EXISTS `jogadores_comsubstituicoes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jogadores_comsubstituicoes`  AS SELECT `t`.`Edicao` AS `Edicao`, `t`.`Pais` AS `Pais`, `t`.`Camisa_Jogador` AS `Camisa_Jogador`, count(0) AS `Num_Substituicoes` FROM (select `s`.`Substituido_JogadorSelecao_Ano` AS `Edicao`,`s`.`Substituido_JogadorSelecao_NumCamisola` AS `Camisa_Jogador`,`s`.`Substituido_JogadorSelecao_Pais` AS `Pais` from `substituicao` `s`) AS `t` GROUP BY `t`.`Edicao`, `t`.`Camisa_Jogador`, `t`.`Pais` ORDER BY count(0) ;

-- --------------------------------------------------------

--
-- Structure for view `numero_participantes_edicao`
--
DROP TABLE IF EXISTS `numero_participantes_edicao`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `numero_participantes_edicao`  AS SELECT `ec`.`Comitiva_Ano` AS `Edicao`, count(0) AS `Numero_participantes` FROM `elementocomitiva` AS `ec` GROUP BY `ec`.`Comitiva_Ano` ;

-- --------------------------------------------------------

--
-- Structure for view `selecao_num_jogo`
--
DROP TABLE IF EXISTS `selecao_num_jogo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `selecao_num_jogo`  AS SELECT `j`.`Numero` AS `JogoID`, `ej`.`Selecao_Pais` AS `Selecao` FROM (`jogo` `j` join `equipajogo` `ej`) WHERE `ej`.`Jogo_numero` = `j`.`Numero` union select `j1`.`Numero` AS `Numero`,'N.A.' AS `N.A.` from `jogo` `j1` where !(`j1`.`Numero` in (select `equipajogo`.`Jogo_numero` from `equipajogo`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cartaoamarelo`
--
ALTER TABLE `cartaoamarelo`
  ADD PRIMARY KEY (`Penalizacao_Jogo_numero`,`Penalizacao_NumeroCartao`),
  ADD KEY `FK_CartaoAmarelo___JogadorEmCampo` (`JogadorEmCampo_Jogo_numero`,`JogadorEmCampo_Pais`,`JogadorEmCampo_Ano`,`JogadorEmCampo_NumCamisola`);

--
-- Indexes for table `cartaovermelho`
--
ALTER TABLE `cartaovermelho`
  ADD PRIMARY KEY (`Penalizacao_Jogo_numero`,`Penalizacao_NumeroCartao`),
  ADD KEY `FK_CartaoVermelho___JogadorEmCampo` (`JogadorEmCampo_Jogo_numero`,`JogadorEmCampo_Pais`,`JogadorEmCampo_Ano`,`JogadorEmCampo_NumCamisola`);

--
-- Indexes for table `clubefutebol`
--
ALTER TABLE `clubefutebol`
  ADD PRIMARY KEY (`NomeClube`);

--
-- Indexes for table `comitiva`
--
ALTER TABLE `comitiva`
  ADD PRIMARY KEY (`Pais`,`Ano`),
  ADD KEY `FK_Comitiva___Edicao` (`Ano`),
  ADD KEY `FK_Comitiva__PatrocinadorOficial___Patrocinador` (`Patrocinador_Oficial_sigla`);

--
-- Indexes for table `edicao`
--
ALTER TABLE `edicao`
  ADD PRIMARY KEY (`Ano`);

--
-- Indexes for table `elementocomitiva`
--
ALTER TABLE `elementocomitiva`
  ADD PRIMARY KEY (`NumeroSerie`),
  ADD KEY `FK_ElementoComitiva___Comitiva` (`Comitiva_Pais`,`Comitiva_Ano`),
  ADD KEY `FK_ElementoComitiva___Pessoa` (`Pessoa_ID`);

--
-- Indexes for table `equipajogo`
--
ALTER TABLE `equipajogo`
  ADD PRIMARY KEY (`Jogo_numero`,`Selecao_Pais`,`Selecao_Ano`),
  ADD KEY `FK_EquipaJogo___Selecao` (`Selecao_Pais`,`Selecao_Ano`);

--
-- Indexes for table `estadio`
--
ALTER TABLE `estadio`
  ADD PRIMARY KEY (`Nome`),
  ADD KEY `FK_Estadio___Pais` (`Pais_nome`);

--
-- Indexes for table `federacao`
--
ALTER TABLE `federacao`
  ADD PRIMARY KEY (`Nome`),
  ADD KEY `FK_Federacao___Pais` (`Pais`);

--
-- Indexes for table `funcao`
--
ALTER TABLE `funcao`
  ADD PRIMARY KEY (`Funcao`);

--
-- Indexes for table `funcaotecnica`
--
ALTER TABLE `funcaotecnica`
  ADD PRIMARY KEY (`Funcao`);

--
-- Indexes for table `golo`
--
ALTER TABLE `golo`
  ADD PRIMARY KEY (`Jogo_Numero`,`Golo_Numero`),
  ADD KEY `FK_Golo___Marcador_JogadorEmCampo` (`Marcador_JogadorEmCampo_Jogo_numero`,`Marcador_JogadorEmCampo_Pais`,`Marcador_JogadorEmCampo_Ano`,`Marcador_JogadorEmCampo_NumCamisola`),
  ADD KEY `FK_Golo___Assitencia_JogadorEmCampo` (`Assistencia_JogadorEmCampo_Jogo_numero`,`Assistencia_JogadorEmCampo_Pais`,`Assistencia_JogadorEmCampo_Ano`,`Assistencia_JogadorEmCampo_NumCamisola`);

--
-- Indexes for table `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`Edicao_Ano`,`Letra`);

--
-- Indexes for table `jogador`
--
ALTER TABLE `jogador`
  ADD PRIMARY KEY (`Pessoa_ID`);

--
-- Indexes for table `jogadoremcampo`
--
ALTER TABLE `jogadoremcampo`
  ADD PRIMARY KEY (`Jogo_numero`,`JogadorSelecao_Pais`,`JogadorSelecao_Ano`,`JogadorSelecao_NumCamisola`);

--
-- Indexes for table `jogadorjogo`
--
ALTER TABLE `jogadorjogo`
  ADD PRIMARY KEY (`JogadorSelecao_Pais`,`JogadorSelecao_Ano`,`JogadorSelecao_NumCamisola`,`Jogo_numero`),
  ADD KEY `FK_JogadorJogo___Jogo` (`Jogo_numero`);

--
-- Indexes for table `jogadorselecao`
--
ALTER TABLE `jogadorselecao`
  ADD PRIMARY KEY (`Selecao_Pais`,`Selecao_Ano`,`NumCamisola`),
  ADD UNIQUE KEY `FK_JogadorSelecao_ElementoComitiva` (`ElementoComitiva_Numero`) USING BTREE,
  ADD KEY `FK_JogadorSelecao___ClubeFutebol` (`ClubeFutebol_NomeClube`),
  ADD KEY `FK_JogadorSelecao___Jogador` (`Pessoa_ID`);

--
-- Indexes for table `jogo`
--
ALTER TABLE `jogo`
  ADD PRIMARY KEY (`Numero`),
  ADD KEY `FK_Jogo___Grupo` (`Grupo_Edicao_Ano`,`Grupo_Letra`),
  ADD KEY `FK_Jogo___Estadio` (`Estadio_Nome`);

--
-- Indexes for table `organizacao`
--
ALTER TABLE `organizacao`
  ADD PRIMARY KEY (`Edicao_Ano_`,`Federacao_organizadora`),
  ADD KEY `FK_Federacao_Organizacao_Edicao_organizadora` (`Federacao_organizadora`);

--
-- Indexes for table `outrafuncao`
--
ALTER TABLE `outrafuncao`
  ADD PRIMARY KEY (`Funcao`);

--
-- Indexes for table `outro`
--
ALTER TABLE `outro`
  ADD PRIMARY KEY (`ElementoComitiva_Numero`),
  ADD KEY `FK_Outro___OutraFuncao` (`Funcao`);

--
-- Indexes for table `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`Nome`);

--
-- Indexes for table `patrocinador`
--
ALTER TABLE `patrocinador`
  ADD PRIMARY KEY (`Sigla`);

--
-- Indexes for table `patrocinio`
--
ALTER TABLE `patrocinio`
  ADD PRIMARY KEY (`Comitiva_Pais_`,`Comitiva_Ano_`,`Patrocinador_Sigla_`),
  ADD KEY `FK_Patrocinador_Patrocinio_Comitiva_` (`Patrocinador_Sigla_`);

--
-- Indexes for table `penalizacao`
--
ALTER TABLE `penalizacao`
  ADD PRIMARY KEY (`Jogo_Numero`,`NumeroCartao`);

--
-- Indexes for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`Pessoa_ID`),
  ADD KEY `FK_Pessoa_Naturalidade_Pais` (`Pais_Nome`);

--
-- Indexes for table `presidente`
--
ALTER TABLE `presidente`
  ADD PRIMARY KEY (`ElementoComitiva_Numero`);

--
-- Indexes for table `selecao`
--
ALTER TABLE `selecao`
  ADD PRIMARY KEY (`Pais`,`Ano`),
  ADD KEY `FK_Selecao___edicao` (`Ano`);

--
-- Indexes for table `substituicao`
--
ALTER TABLE `substituicao`
  ADD PRIMARY KEY (`Substituido_Jogo_numero`,`Substituido_JogadorSelecao_Pais`,`Substituido_JogadorSelecao_Ano`,`Substituido_JogadorSelecao_NumCamisola`,`Substituto_Jogo_numero`,`Substituto_JogadorSelecao_Pais`,`Substituto_JogadorSelecao_Ano`,`Substituto_JogadorSelecao_NumCamisola`),
  ADD KEY `FK_Substituicao___substituto_JogadorEmCampo` (`Substituto_Jogo_numero`,`Substituto_JogadorSelecao_Pais`,`Substituto_JogadorSelecao_Ano`,`Substituto_JogadorSelecao_NumCamisola`);

--
-- Indexes for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`ElementoComitiva_Numero`),
  ADD KEY `FK_Tecnico___FuncaoTecnica` (`Funcao`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cartaoamarelo`
--
ALTER TABLE `cartaoamarelo`
  ADD CONSTRAINT `FK_CartaoAmarelo___JogadorEmCampo` FOREIGN KEY (`JogadorEmCampo_Jogo_numero`,`JogadorEmCampo_Pais`,`JogadorEmCampo_Ano`,`JogadorEmCampo_NumCamisola`) REFERENCES `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CartaoAmarelo___Penalizacao` FOREIGN KEY (`Penalizacao_Jogo_numero`,`Penalizacao_NumeroCartao`) REFERENCES `penalizacao` (`Jogo_Numero`, `NumeroCartao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cartaovermelho`
--
ALTER TABLE `cartaovermelho`
  ADD CONSTRAINT `FK_CartaoVermelho___JogadorEmCampo` FOREIGN KEY (`JogadorEmCampo_Jogo_numero`,`JogadorEmCampo_Pais`,`JogadorEmCampo_Ano`,`JogadorEmCampo_NumCamisola`) REFERENCES `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CartaoVermelho___Penalizacao` FOREIGN KEY (`Penalizacao_Jogo_numero`,`Penalizacao_NumeroCartao`) REFERENCES `penalizacao` (`Jogo_Numero`, `NumeroCartao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comitiva`
--
ALTER TABLE `comitiva`
  ADD CONSTRAINT `FK_Comitiva__PatrocinadorOficial___Patrocinador` FOREIGN KEY (`Patrocinador_Oficial_sigla`) REFERENCES `patrocinador` (`Sigla`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Comitiva___Edicao` FOREIGN KEY (`Ano`) REFERENCES `edicao` (`Ano`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Comitiva___Pais` FOREIGN KEY (`Pais`) REFERENCES `pais` (`Nome`) ON UPDATE CASCADE;

--
-- Constraints for table `elementocomitiva`
--
ALTER TABLE `elementocomitiva`
  ADD CONSTRAINT `FK_ElementoComitiva___Comitiva` FOREIGN KEY (`Comitiva_Pais`,`Comitiva_Ano`) REFERENCES `comitiva` (`Pais`, `Ano`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ElementoComitiva___Pessoa` FOREIGN KEY (`Pessoa_ID`) REFERENCES `pessoa` (`Pessoa_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `equipajogo`
--
ALTER TABLE `equipajogo`
  ADD CONSTRAINT `FK_EquipaJogo_Jogo` FOREIGN KEY (`Jogo_numero`) REFERENCES `jogo` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EquipaJogo___Selecao` FOREIGN KEY (`Selecao_Pais`,`Selecao_Ano`) REFERENCES `selecao` (`Pais`, `Ano`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `estadio`
--
ALTER TABLE `estadio`
  ADD CONSTRAINT `FK_Estadio___Pais` FOREIGN KEY (`Pais_nome`) REFERENCES `pais` (`Nome`) ON UPDATE CASCADE;

--
-- Constraints for table `federacao`
--
ALTER TABLE `federacao`
  ADD CONSTRAINT `FK_Federacao___Pais` FOREIGN KEY (`Pais`) REFERENCES `pais` (`Nome`) ON UPDATE CASCADE;

--
-- Constraints for table `funcaotecnica`
--
ALTER TABLE `funcaotecnica`
  ADD CONSTRAINT `FK_FuncaoTecnica_Funcao` FOREIGN KEY (`Funcao`) REFERENCES `funcao` (`Funcao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `golo`
--
ALTER TABLE `golo`
  ADD CONSTRAINT `FK_Golo___Assitencia_JogadorEmCampo` FOREIGN KEY (`Assistencia_JogadorEmCampo_Jogo_numero`,`Assistencia_JogadorEmCampo_Pais`,`Assistencia_JogadorEmCampo_Ano`,`Assistencia_JogadorEmCampo_NumCamisola`) REFERENCES `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Golo___Jogo` FOREIGN KEY (`Jogo_Numero`) REFERENCES `jogo` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Golo___Marcador_JogadorEmCampo` FOREIGN KEY (`Marcador_JogadorEmCampo_Jogo_numero`,`Marcador_JogadorEmCampo_Pais`,`Marcador_JogadorEmCampo_Ano`,`Marcador_JogadorEmCampo_NumCamisola`) REFERENCES `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON UPDATE CASCADE;

--
-- Constraints for table `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `FK_Grupo___Edicao` FOREIGN KEY (`Edicao_Ano`) REFERENCES `edicao` (`Ano`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jogador`
--
ALTER TABLE `jogador`
  ADD CONSTRAINT `FK_Jogador_Pessoa` FOREIGN KEY (`Pessoa_ID`) REFERENCES `pessoa` (`Pessoa_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jogadoremcampo`
--
ALTER TABLE `jogadoremcampo`
  ADD CONSTRAINT `FK_JogadorEmCampo___JogadorJogo` FOREIGN KEY (`Jogo_numero`,`JogadorSelecao_Pais`,`JogadorSelecao_Ano`,`JogadorSelecao_NumCamisola`) REFERENCES `jogadorjogo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jogadorjogo`
--
ALTER TABLE `jogadorjogo`
  ADD CONSTRAINT `FK_JogadorJogo___Jogador` FOREIGN KEY (`JogadorSelecao_Pais`,`JogadorSelecao_Ano`,`JogadorSelecao_NumCamisola`) REFERENCES `jogadorselecao` (`Selecao_Pais`, `Selecao_Ano`, `NumCamisola`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_JogadorJogo___Jogo` FOREIGN KEY (`Jogo_numero`) REFERENCES `jogo` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jogadorselecao`
--
ALTER TABLE `jogadorselecao`
  ADD CONSTRAINT `FK_JogadorSelecao_ElementoComitiva` FOREIGN KEY (`ElementoComitiva_Numero`) REFERENCES `elementocomitiva` (`NumeroSerie`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_JogadorSelecao___ClubeFutebol` FOREIGN KEY (`ClubeFutebol_NomeClube`) REFERENCES `clubefutebol` (`NomeClube`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_JogadorSelecao___Jogador` FOREIGN KEY (`Pessoa_ID`) REFERENCES `jogador` (`Pessoa_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_JogadorSelecao___Selecao` FOREIGN KEY (`Selecao_Pais`,`Selecao_Ano`) REFERENCES `selecao` (`Pais`, `Ano`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jogo`
--
ALTER TABLE `jogo`
  ADD CONSTRAINT `FK_Jogo___Estadio` FOREIGN KEY (`Estadio_Nome`) REFERENCES `estadio` (`Nome`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Jogo___Grupo` FOREIGN KEY (`Grupo_Edicao_Ano`,`Grupo_Letra`) REFERENCES `grupo` (`Edicao_Ano`, `Letra`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `organizacao`
--
ALTER TABLE `organizacao`
  ADD CONSTRAINT `FK_Edicao_Organizacao_Federacao_` FOREIGN KEY (`Edicao_Ano_`) REFERENCES `edicao` (`Ano`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Federacao_Organizacao_Edicao_organizadora` FOREIGN KEY (`Federacao_organizadora`) REFERENCES `federacao` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `outrafuncao`
--
ALTER TABLE `outrafuncao`
  ADD CONSTRAINT `FK_OutraFuncao___Funcao` FOREIGN KEY (`Funcao`) REFERENCES `funcao` (`Funcao`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `outro`
--
ALTER TABLE `outro`
  ADD CONSTRAINT `FK_Outro___ElementoComitiva` FOREIGN KEY (`ElementoComitiva_Numero`) REFERENCES `elementocomitiva` (`NumeroSerie`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Outro___OutraFuncao` FOREIGN KEY (`Funcao`) REFERENCES `outrafuncao` (`Funcao`) ON UPDATE CASCADE;

--
-- Constraints for table `patrocinio`
--
ALTER TABLE `patrocinio`
  ADD CONSTRAINT `FK_Comitiva_Patrocinio_Patrocinador_` FOREIGN KEY (`Comitiva_Pais_`,`Comitiva_Ano_`) REFERENCES `comitiva` (`Pais`, `Ano`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Patrocinador_Patrocinio_Comitiva_` FOREIGN KEY (`Patrocinador_Sigla_`) REFERENCES `patrocinador` (`Sigla`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `penalizacao`
--
ALTER TABLE `penalizacao`
  ADD CONSTRAINT `FK_Penalizacao___Jogo` FOREIGN KEY (`Jogo_Numero`) REFERENCES `jogo` (`Numero`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD CONSTRAINT `FK_Pessoa_Naturalidade_Pais` FOREIGN KEY (`Pais_Nome`) REFERENCES `pais` (`Nome`) ON UPDATE CASCADE;

--
-- Constraints for table `presidente`
--
ALTER TABLE `presidente`
  ADD CONSTRAINT `FK_Presidente___ElementoComitiva` FOREIGN KEY (`ElementoComitiva_Numero`) REFERENCES `elementocomitiva` (`NumeroSerie`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `selecao`
--
ALTER TABLE `selecao`
  ADD CONSTRAINT `FK_Selecao___Pais` FOREIGN KEY (`Pais`) REFERENCES `pais` (`Nome`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Selecao___edicao` FOREIGN KEY (`Ano`) REFERENCES `edicao` (`Ano`) ON UPDATE CASCADE;

--
-- Constraints for table `substituicao`
--
ALTER TABLE `substituicao`
  ADD CONSTRAINT `FK_Substituicao___substituido_JogadorEmCampo` FOREIGN KEY (`Substituido_Jogo_numero`,`Substituido_JogadorSelecao_Pais`,`Substituido_JogadorSelecao_Ano`,`Substituido_JogadorSelecao_NumCamisola`) REFERENCES `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Substituicao___substituto_JogadorEmCampo` FOREIGN KEY (`Substituto_Jogo_numero`,`Substituto_JogadorSelecao_Pais`,`Substituto_JogadorSelecao_Ano`,`Substituto_JogadorSelecao_NumCamisola`) REFERENCES `jogadoremcampo` (`Jogo_numero`, `JogadorSelecao_Pais`, `JogadorSelecao_Ano`, `JogadorSelecao_NumCamisola`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `FK_Tecnico___ElementoComitiva` FOREIGN KEY (`ElementoComitiva_Numero`) REFERENCES `elementocomitiva` (`NumeroSerie`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Tecnico___FuncaoTecnica` FOREIGN KEY (`Funcao`) REFERENCES `funcaotecnica` (`Funcao`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
