-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_franquia
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `id_adm` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_restaurante` bigint unsigned DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  `nivel_adm` enum('normal','superadmin') COLLATE utf8mb4_unicode_ci DEFAULT 'normal',
  `senha_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_adm`),
  KEY `fk_adm_usuario` (`email`),
  KEY `fk_adm_restaurante` (`id_restaurante`),
  CONSTRAINT `fk_adm_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1,4,'bqUr8WEWuNdnh5kFf+Nllsy6bkKA+3lVuy7CtsD1+DZRsnjx81uMYsEW3k9wEejlpU7XydLawu+ON4Oz2Q7YAD/kAAWgZ002PBRjbyb2lFI=','2025-11-26 15:27:38','normal','$2y$12$cOrSl2KBn9gAlYzCsM3QRea837OAGbf7giZzj8wXc63fXlUcVxdCu','$2y$12$LbMScAkAgXD5psL6w6AJbugsKLFFhx...1eLjlkPQVlp/nhZKoi3u','y6gI4iOgL3J289sXSIpvPNHX5nkih/2R66DMd3TuZLiKV7rkwstt3s78yd2gAlDn28FjJc29ZTySyX2jvI8zeg=='),(2,5,'cB2pDjKZroPnVy90tGWEWglQtjba7pntf6+HUZNbAwIIQ61J7rI5pvnLAJpuDcy2+1JJoOaLGkwd04wP+K9ZhFhxeMGWa4LudaXYrEpelpk=','2025-11-26 16:02:57','normal','$2y$12$/bxZS4OzRvJ64AQIH18Z4e10aLUUuEDz/tv51zYujFN8YBt7TRZLy','$2y$12$vj50F9/cbOpEygurcOySSetGeZa0UiLAyzVvwQTAsUiKDts/7cGRS','Pu2NVn94Q6OSM3kBJsMFx2dyvZ2hkHJZTSOeWgPKRbOCtsjYC4R175ermYeX6CCHptBArYpPbsCy6chZ0F+uaw=='),(12,15,'uAxfA7LyuqBogKdpUJvNLjE73TYHh0V/+k+dUO8s7+BQN4UzXNEcXaPacVDWdmyntbYMBZO4XknJURVM+/35cQ==','2025-11-29 15:16:50','normal','$2y$12$xF/G1.IRB.Mumb3hR1mEZOXSlgyie7sEZ5i11shHnDhJxqy3F6oBS','08300827510','3YU2LGcL0UE4p5I9bAr04Cxn6vqizt6YF4VsqQc6QUR/PWkd7isAf6U/fH+bm+zwMagT8WHUpY8aBmVFNSxW1Q=='),(13,16,'8iXMPJdjP2gsyuCVap+Pkp8RlF3NxW2VcWCbUr8eLjhDijPtD3Goe0+HPhVa6Ky188cElF+wnoblQLwFR5ay6Q==','2025-11-29 15:16:51','normal','$2y$12$Gfx9lhnYFTqQX3ukThI.3O/J9gIxz/FEQrwNlDNkjypUkYYq1L7lK','08300827510','fbAPiZKE0/QqiAqGTGS4USRgk3Rx6Ko/wffjpUaRXvCKMluMVxlc+Sq79PEJ5x2AvJAATLVWZjf4+6W8kuB/iA=='),(14,17,'3q0iRzfwuLqcPzEX7+jOKppBrwSP21nGLNDt3pOy5Nes+oG4J+Bv3B7PfLlo9z35HbGr1XHhJ0u6QlgXSF1s9g==','2025-11-29 15:23:20','normal','$2y$12$Hx.MF7jHp8UulTLLbJvtlOpGhAQe/4d0v2bDU5KOHzVOaDmoGSEWm','12345678909','7mUtdiCCvaTe3Ds3KhGrGhjn8UyRiYW9bOwtL2NAPMTpVJi86vgyDYRa50eX8XajTIEWfsrg2cOR2SrtWWHtHw=='),(15,18,'KkSTpS/VuHI5+Na3/vlmfUZikLt0rpxKCu3BqKqNXgodWdgTyJP4XzuOuLeYNZzWpJf4R9IjYBR8zWrxGrQxIQ==','2025-11-29 15:43:22','normal','$2y$12$3b3rgagYUAqhNel4GsblN.5b5c7Hok/9rb0ul7nWsZE0cx8N4t31C','12345678909','JGuDxxRPFksrrpxhuij5BlEvlTyzEPVqsHcNTBZGXLU42GJ3kVPKHA0mly5TPfHAVia2/ojqSlnpPIPDiZBgYQ=='),(16,19,'JxDPYORO5ST+cxFL51htSua7a0U3ZlOkagtqfdxm26FTjnSi/2I2x781iJDYeDf0xJILuNh7Vt8yHVrHFDaMTg==','2025-11-29 15:49:57','normal','$2y$12$N4PuklpVMNa2Ce4fWBstSOwfGEjdXh6l5ji01vptLufOzgENkhKxq','12345678909','QrnnczNz6JcdsJ2mdjUHvom9NF7YWcaOJswj3SLoY3eL5HlEj0CJBIjKQlrBYFt/4m0cV8GT1xDBsCMjj4M2LQ=='),(17,20,'IFuzrLlp+Wze9IqB0xquDSoH20uzba45P219sfWQbDfSwSUeW0vn0GgAgfmY3q86imfIZabJInWFNRTmzXxpiQ==','2025-11-29 15:52:25','normal','$2y$12$BwbikdSczV5vIhVQWj.N6eDxDu2RwdFraaU8Z/RAu4kzic9r5ATh2','08300827510','tZz3IfQAWnwwZwMYzzDDeUgaZIqlny0ZaSATtBQGBAfvvePAhvUNUqOtOmbe9YtTs634S3V3hbYHZLZ301f97w=='),(18,21,'5CD/ajaS03YlKbFX0iI4lyZ8EGG6aLZtvAJD4wGjwul2laxXzeFhhUpZa9HeJheqedsMQrk8AnmKze3hQs8KscO/qc0x/mH+Zpy9XB+mMtk=','2025-11-29 22:51:32','normal','$2y$12$UjlCRvDVdwcVshdVnUY3dO2SkXxF8Xk.6OPbw4Mft180FadBC24wi','08300827510','iAeh3qVW1ikQZLUrFAy7zeZkDGuPxwC2bNQ5lpXJrix1G/YkJE86Fb+43CfvaB538453Db07vAec9k0ixDRmLw=='),(19,22,'/G9PEktlz18yZIGfiCS0SjbNo9TJkYXC2cnfA1ReovK8H0bs0dp/OuCLqND678a2qqo0B355jlV/c/RMX2iuOMbfbxuFVvc1yxNZ2I7c0bk=','2025-11-29 22:55:58','normal','$2y$12$9UXHYjqXBiYPH/geACY0VeIzwpky/RQsxKfLHork/DLQHIHSeWXS6','08300827510','CBGg7o0guMXhvjrU+XOJkw63i+eXxOgjQi+qvNz0RRq5eWPor8jeQLboHuS645N2vkAqkzKq048g4dzD9UZjwg=='),(20,23,'8a+1iQuOAqx81k/EIOggsqsyelImCF/5dsbRP42fXDIfZVM9XcahmyMWT/nOfKOFnS1UPjqiHNNQL9DcrHZDNA==','2025-11-30 09:06:06','normal','$2y$12$78wQ4ewssXUHIbDaQl3UYuXxu5mvcP1/2Zn44evO2yq6S9i/KR4Kq','12345678909','TRrTolGcKzE5sjssP5h9W/0B6eSoNcjcJeKUwm4TAbi4NZm8GKFMRIxZC8zIt2wSJoMyQaY80Nqg+Nt8okJiqg=='),(21,24,'NegVMTElMRIye1/SyJuMwa0LUUSZnDHk9C5KO7VY1g4ipExYsMDxaeIBplGOs2fZ1dC/SQRBWJzneDEoT951EdEQEaJcdqvIg6LHMPnyYzo=','2025-11-30 09:24:43','normal','$2y$12$KmWBq2aqxkii/DGI/YVi6.jNtl79hhVJxG6emgqBtp7.YXY3qbmGi','12345678909','tf0kYiCsnG5ASM0H3+1WM95vc1mm2jfm0Wf/DCk3AAUzE8jx20p+GHrPXfDQxn7zrC2eKGb13pJz5xNyLrWgAw=='),(22,25,'kQIOHuXoZvtVNMpB1DwFEfndA9Xmf3S1a5IJG2ZofvlcIF4hyccaJIhl02S1b0vOBh5JDY2CB5gSGipq2zjD4HLymoQ6JFENGOhsATczuzY=','2025-11-30 09:27:50','normal','$2y$12$ORHfchxAGskaq8t.FfDp.e/sbpAuBTZjdoZ7e/ziwMHK35L2u1Ify','12345678909','6M9bP/fKfxx28npgdvUlbRaG4DwuTUdneviKpv8bZ2QsmY4DmRTRNM5WoD+PJDdOucCYAYqNB5giZqRz+J5EmA=='),(23,26,'op1b+d8YSNzRnKQ1pSqia7nbZnAQIv5uDpn7A5PKoHATHe5TmrMxATSgppkQjBQDpGyd8AUXcif/S3f/zm0hbw==','2025-11-30 10:12:23','normal','$2y$12$vwUj.37lPL6hpFSjUWPDe.NMVKwxYB8K51wp2EGPNunKWU5Pf8fdm','12345678909','3uxGCgGByjGagZp2XaEOGlelyDDr9fFF24DyYRvl1LC1PRZaNjFsL02xlql8RgozbvQtGYSbt/oz279gK3W3kA=='),(24,27,'SabRD9lqbPW3wHf9Xx21NUipN81aeJugsoufqt28ElWhPGx5sqmUcmPXX34kbRL3MWRD9rQyIRA5QaHa4rLDYNFfwc18NZkaU+q3g9i+oNQ=','2025-11-30 16:18:46','normal','$2y$12$HcXi/YRmaa3DgS1Q.nmO4.Zy0VZLI5H0SAABMJT1moQ.e181GNIBq','987.654.321-00','D58VoQGDCUORC2PcRodzB4p5Fmj5RRBG7Z5ryxqNzn/N515CQPJ/ue/nib8M939PRnkZCSvhOO4mkyBoJg5G0Q=='),(25,28,'ABRRWC9zFbcYANg4D/Ve7HBGRdFTW3F1VRXEtGI5KNc3tnfKOKjBjhu+2BzQBU8TbMKZcp5565KiKRJGYOyRPh8yo2gTYE5TCzJeVbJ7An4=','2025-11-30 16:23:17','normal','$2y$12$BhA6J5N5RrS7BpU9BSQ.B.6TCWf/HALTMq4de0pBl5WpHJGoZxqLO','987.654.321-00','n379a7RadZ/aVY94htPzIAxpEDv5ujU0RJVvXAkIT0TSWr4gG/VA7ByxvpFdoDMouErqBGX/7F3Ymq6q48iYLw=='),(26,29,'uJhg9U9Xag3s1xgOksraXEnOxGjSLJiFDzGSQnMynXY/jP1F3J2DefqgWe3xQX73rgouhwEr78BPoElAGTXr8A==','2025-12-01 15:21:09','normal','$2y$12$std9eZ8IzGaCy5fXZz3.MOo1esUM3jW3rtQfNquRyglu20b3RRofG','987.654.321-00','kreF7ibYd/xkbMUP5YqrPo0bqzKg5CTvAEAF4cxtqzkD3gFJNGTjqVgvOU0A0Sv6xBpCOMmGy24zsNDtRxwZCA==');
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_adm_check_insert` BEFORE INSERT ON `administrador` FOR EACH ROW BEGIN
    IF NEW.nivel_adm = 'normal' AND NEW.id_restaurante IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Administrador normal deve ter restaurante.';
    ELSEIF NEW.nivel_adm = 'superadmin' AND NEW.id_restaurante IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Superadmin n√£o pode ter restaurante.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_adm_check_update` BEFORE UPDATE ON `administrador` FOR EACH ROW BEGIN
    IF NEW.nivel_adm = 'normal' AND NEW.id_restaurante IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Administrador normal deve ter restaurante.';
    ELSEIF NEW.nivel_adm = 'superadmin' AND NEW.id_restaurante IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Superadmin n√£o pode ter restaurante.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `agendamento`
--

DROP TABLE IF EXISTS `agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamento` (
  `id_agendamento` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint unsigned DEFAULT NULL,
  `nome_completo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_pessoas` int unsigned DEFAULT NULL,
  `id_mesa` bigint unsigned DEFAULT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `status` enum('confirmado','cancelado','concluido') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'confirmado',
  `id_restaurante` bigint unsigned DEFAULT NULL,
  `mensagem` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_agendamento`),
  UNIQUE KEY `uq_agendamento_mesa_data_hora` (`id_mesa`,`data`,`hora`),
  KEY `idx_agendamento_cliente` (`id_cliente`),
  KEY `idx_agendamento_mesa` (`id_mesa`),
  KEY `idx_agendamento_data` (`data`),
  KEY `fk_agendamento_restaurante` (`id_restaurante`),
  CONSTRAINT `fk_agendamento_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_agendamento_mesa` FOREIGN KEY (`id_mesa`) REFERENCES `mesa` (`id_mesa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_agendamento_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamento`
--

LOCK TABLES `agendamento` WRITE;
/*!40000 ALTER TABLE `agendamento` DISABLE KEYS */;
INSERT INTO `agendamento` VALUES (2,NULL,'andre pereira santos','jose123@gmail.com','99981539156',NULL,NULL,'1111-11-11','11:11:00','confirmado',NULL,NULL),(4,NULL,'teste terceiro','jose123@gmail.com','99981539156',NULL,NULL,'1111-11-11','11:11:00','confirmado',NULL,NULL),(7,NULL,'Pedro','pedro@gmail.com','77981539156',NULL,NULL,'2012-12-12','21:45:00','confirmado',NULL,NULL),(8,NULL,'Heitor Fernandes Silva','heitor@gmail.com','77981539156',NULL,NULL,'2025-12-04','22:30:00','confirmado',NULL,NULL),(9,NULL,'Pedro','pedro@gmail.com','77981539156',NULL,NULL,'1111-11-11','11:11:00','confirmado',NULL,NULL),(10,NULL,'joao','joao@gmail.com','77981539156',NULL,NULL,'1111-11-11','11:11:00','confirmado',NULL,NULL);
/*!40000 ALTER TABLE `agendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacao` (
  `id_restaurante` bigint unsigned DEFAULT NULL,
  `avaliacao` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `avaliacao___fk` (`id_restaurante`),
  CONSTRAINT `avaliacao___fk` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao`
--

LOCK TABLES `avaliacao` WRITE;
/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chave_adm`
--

DROP TABLE IF EXISTS `chave_adm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chave_adm` (
  `id_adm` bigint unsigned NOT NULL,
  `chave_criptografia` varbinary(32) DEFAULT NULL,
  `chave_email` varbinary(32) DEFAULT NULL,
  PRIMARY KEY (`id_adm`),
  CONSTRAINT `chave_criptografia_fk` FOREIGN KEY (`id_adm`) REFERENCES `administrador` (`id_adm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chave_adm`
--

LOCK TABLES `chave_adm` WRITE;
/*!40000 ALTER TABLE `chave_adm` DISABLE KEYS */;
INSERT INTO `chave_adm` VALUES (12,_binary '\Î∂\‰î;)ëç°\‡…£\›)/Eé*9©˝AÑ\ÓZ\‰\ı',NULL),(13,_binary 'í.ˇü\nçÑCu5≤õú\Û\÷˚3ÜYéD\Ô\r†ÖÉ\Àyj',NULL),(14,_binary '\ÚÉ »Ç\ÿZyà¸g\⁄\∆≈≠LD@h›†´°Tãk)íH\‘',NULL),(15,_binary 'eQì^”à\–,>´|•\ÏÇW\Ë\’O\˜\¬o»Ö97xÜ¿\Ïg;',NULL),(16,_binary '™\núUPV\ﬁ\‡\◊>Y~™˘∂pˇáM80¯\·≤I∑5p',NULL),(17,_binary 'üM\‡ëxauu\Ï\Áä\Â\ ?Ωbe>S\Ú\Î\˜E!Zl™\Á\À◊ê',NULL),(18,_binary '11qnò$&&\À$PA\‰s?Åff´åíÿã‰Ω¢1\≈-,',NULL),(19,_binary '©H\Ÿw+ØMÑCçêZê\˜\—$0´†\ﬁ\◊J∆ü=\” ∑\Ÿ^)',NULL),(20,_binary 'AD©øA¨3\“˚\‹%y\ıR\ \‹äµè\Ú≥^\Êfgj!',NULL),(21,_binary 'ç∂\Úy\⁄=])	\ \…\…s_ZI3çQ\»_™?é.',NULL),(22,_binary '›ó¢n∞e}]g\ﬂtm™S\◊\”{“¥\rDIg¿\·HR',NULL),(23,_binary '\⁄Yø\¿|ò\n\Ûfú™1XØe\n<¥f\»øQ\∆>ß\ıET',NULL),(24,_binary 'π â†›æçP\rR\¬H\Òa\ÈX\n~\ÈÅ¸\À6fN9®0\\©',NULL),(25,_binary 'ûñ\—¿\„mf\r\“\ˆAgxºì˝C\ﬂ#•XÑù˚\Ì \'ä',NULL),(26,_binary '∞ëÀ∑Z\‹#\ﬁ>\ÏF[Ñ%êê\Õ\∆]Çî¥èñ\⁄\ƒDW',NULL);
/*!40000 ALTER TABLE `chave_adm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chave_email_adm`
--

DROP TABLE IF EXISTS `chave_email_adm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chave_email_adm` (
  `chave_email` varbinary(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chave_email_adm`
--

LOCK TABLES `chave_email_adm` WRITE;
/*!40000 ALTER TABLE `chave_email_adm` DISABLE KEYS */;
INSERT INTO `chave_email_adm` VALUES (_binary '\Î∂\‰î;)ëç°\‡…£\›)/Eé*9©˝AÑ\ÓZ\‰\ı');
/*!40000 ALTER TABLE `chave_email_adm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cpf` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '1',
  `senha_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `fk_cliente_usuario` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_desconto`
--

DROP TABLE IF EXISTS `cliente_desconto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_desconto` (
  `id_cliente_desconto` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint unsigned NOT NULL,
  `id_desconto` bigint unsigned NOT NULL,
  `id_doacao` bigint unsigned DEFAULT NULL,
  `status` enum('disponivel','usado','expirado','cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disponivel',
  `data_atribuicao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_utilizacao` datetime DEFAULT NULL,
  `valor_aplicado` decimal(10,2) DEFAULT NULL,
  `id_restaurante_origem` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id_cliente_desconto`),
  KEY `idx_cd_cliente` (`id_cliente`),
  KEY `idx_cd_desconto` (`id_desconto`),
  KEY `idx_cd_status` (`status`),
  KEY `fk_cd_doacao` (`id_doacao`),
  KEY `fk_cd_restaurante_origem` (`id_restaurante_origem`),
  CONSTRAINT `fk_cd_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cd_desconto` FOREIGN KEY (`id_desconto`) REFERENCES `desconto` (`id_desconto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cd_doacao` FOREIGN KEY (`id_doacao`) REFERENCES `doacao` (`id_doacao`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_cd_restaurante_origem` FOREIGN KEY (`id_restaurante_origem`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_desconto`
--

LOCK TABLES `cliente_desconto` WRITE;
/*!40000 ALTER TABLE `cliente_desconto` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_desconto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentario` (
  `id_comentario` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint unsigned DEFAULT NULL,
  `id_produto` bigint unsigned NOT NULL,
  `id_restaurante` bigint unsigned NOT NULL,
  `conteudo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nota` tinyint unsigned NOT NULL,
  `data_criacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comentario`),
  KEY `idx_comentario_cliente` (`id_cliente`),
  KEY `idx_comentario_produto` (`id_produto`),
  KEY `idx_comentario_restaurante` (`id_restaurante`),
  CONSTRAINT `fk_comentario_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_comentario_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comentario_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comentario_chk_1` CHECK ((`nota` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
/*!40000 ALTER TABLE `comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id_compra` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pagamento` bigint unsigned DEFAULT NULL,
  `id_cliente` bigint unsigned DEFAULT NULL,
  `id_restaurante` bigint unsigned DEFAULT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `data_compra` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipo_compra` enum('presencial','online','delivery') DEFAULT 'presencial',
  `observacoes` text,
  PRIMARY KEY (`id_compra`),
  KEY `fk_compra_pagamento` (`id_pagamento`),
  KEY `fk_compra_cliente` (`id_cliente`),
  KEY `fk_compra_restaurante` (`id_restaurante`),
  CONSTRAINT `fk_compra_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_compra_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `compra_chk_1` CHECK ((`valor_total` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desconto`
--

DROP TABLE IF EXISTS `desconto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desconto` (
  `id_desconto` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_restaurante` bigint unsigned DEFAULT NULL,
  `id_doacao` bigint unsigned DEFAULT NULL,
  `id_adm_criador` bigint unsigned NOT NULL,
  `criado_por_snapshot` json NOT NULL,
  `id_adm_atualizador` bigint unsigned DEFAULT NULL,
  `atualizado_por_snapshot` json DEFAULT NULL,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `tipo` enum('percentual','valor_fixo') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_inicio` datetime NOT NULL,
  `data_fim` datetime DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `global` tinyint(1) NOT NULL DEFAULT '0',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_desconto`),
  KEY `idx_desconto_restaurante` (`id_restaurante`),
  KEY `idx_desconto_ativo_global` (`ativo`,`global`),
  KEY `idx_desconto_periodo` (`data_inicio`,`data_fim`),
  KEY `fk_desconto_doacao` (`id_doacao`),
  CONSTRAINT `fk_desconto_doacao` FOREIGN KEY (`id_doacao`) REFERENCES `doacao` (`id_doacao`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_desconto_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `desconto_chk_1` CHECK ((`valor` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desconto`
--

LOCK TABLES `desconto` WRITE;
/*!40000 ALTER TABLE `desconto` DISABLE KEYS */;
/*!40000 ALTER TABLE `desconto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doacao`
--

DROP TABLE IF EXISTS `doacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doacao` (
  `id_doacao` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint unsigned DEFAULT NULL,
  `id_restaurante_destino` bigint unsigned NOT NULL,
  `valor_doacao` decimal(10,2) NOT NULL,
  `observacao` varchar(255) DEFAULT NULL,
  `data_doacao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_doacao`),
  KEY `fk_doacao_cliente` (`id_cliente`),
  KEY `fk_doacao_restaurante` (`id_restaurante_destino`),
  CONSTRAINT `fk_doacao_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_doacao_restaurante` FOREIGN KEY (`id_restaurante_destino`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doacao`
--

LOCK TABLES `doacao` WRITE;
/*!40000 ALTER TABLE `doacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `doacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_pedido`
--

DROP TABLE IF EXISTS `item_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_pedido` (
  `id_item` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pedido` bigint unsigned NOT NULL,
  `id_produto` bigint unsigned NOT NULL,
  `quantidade` int NOT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`quantidade` * `valor_unitario`)) STORED,
  PRIMARY KEY (`id_item`),
  KEY `fk_item_pedido` (`id_pedido`),
  KEY `fk_item_produto` (`id_produto`),
  CONSTRAINT `fk_item_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_item_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_valor_unitario_pos` CHECK ((`valor_unitario` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_pedido`
--

LOCK TABLES `item_pedido` WRITE;
/*!40000 ALTER TABLE `item_pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_adm_acao`
--

DROP TABLE IF EXISTS `log_adm_acao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_adm_acao` (
  `id_log` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_administrador` bigint unsigned NOT NULL,
  `acao` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tabela_afetada` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_registro_afetado` bigint unsigned DEFAULT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci,
  `data_acao` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`),
  KEY `fk_log_adm_acao_administrador` (`id_administrador`),
  CONSTRAINT `fk_log_adm_acao_administrador` FOREIGN KEY (`id_administrador`) REFERENCES `administrador` (`id_adm`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_adm_acao`
--

LOCK TABLES `log_adm_acao` WRITE;
/*!40000 ALTER TABLE `log_adm_acao` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_adm_acao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_adm_acesso`
--

DROP TABLE IF EXISTS `log_adm_acesso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_adm_acesso` (
  `id_log` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_administrador` bigint unsigned NOT NULL,
  `ultimo_login` datetime DEFAULT CURRENT_TIMESTAMP,
  `ultima_alteracao_senha` datetime DEFAULT NULL,
  `ip_origem` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dispositivo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `navegador` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  KEY `fk_log_adm_acesso_administrador` (`id_administrador`),
  CONSTRAINT `fk_log_adm_acesso_administrador` FOREIGN KEY (`id_administrador`) REFERENCES `administrador` (`id_adm`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_adm_acesso`
--

LOCK TABLES `log_adm_acesso` WRITE;
/*!40000 ALTER TABLE `log_adm_acesso` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_adm_acesso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesa`
--

DROP TABLE IF EXISTS `mesa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mesa` (
  `id_mesa` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_restaurante` bigint unsigned NOT NULL,
  `numero` int unsigned NOT NULL,
  `status` enum('disponivel','reservada','ocupada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disponivel',
  `capacidade` tinyint NOT NULL,
  PRIMARY KEY (`id_mesa`),
  KEY `idx_mesa_restaurante` (`id_restaurante`),
  CONSTRAINT `fk_mesa_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesa`
--

LOCK TABLES `mesa` WRITE;
/*!40000 ALTER TABLE `mesa` DISABLE KEYS */;
/*!40000 ALTER TABLE `mesa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `id_pagamento` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_pedido` bigint unsigned NOT NULL,
  `id_cliente` bigint unsigned DEFAULT NULL,
  `id_cliente_desconto` bigint unsigned DEFAULT NULL,
  `id_restaurante` bigint unsigned NOT NULL,
  `forma_pagamento` int NOT NULL,
  `valor_pagamento` decimal(10,2) NOT NULL,
  `data_pagamento` datetime DEFAULT CURRENT_TIMESTAMP,
  `status_pagamento` int NOT NULL,
  `detalhes_transacao` json NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  KEY `fk_pagamento_pedido` (`id_pedido`),
  KEY `fk_pagamento_cliente` (`id_cliente`),
  KEY `fk_pagamento_restaurante` (`id_restaurante`),
  KEY `fk_pagamento_cliente_desconto` (`id_cliente_desconto`),
  CONSTRAINT `fk_pagamento_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_pagamento_cliente_desconto` FOREIGN KEY (`id_cliente_desconto`) REFERENCES `cliente_desconto` (`id_cliente_desconto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_pagamento_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pagamento_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id_pedido` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_cliente` bigint unsigned NOT NULL,
  `id_restaurante` bigint unsigned NOT NULL,
  `data_pedido` datetime DEFAULT CURRENT_TIMESTAMP,
  `status_pedido` enum('pendente','em_preparo','concluido','cancelado') DEFAULT 'pendente',
  `valor_pedido` decimal(10,2) DEFAULT '0.00',
  `forma_pagamento` int DEFAULT NULL,
  `observacoes` text,
  PRIMARY KEY (`id_pedido`),
  KEY `fk_pedido_cliente` (`id_cliente`),
  KEY `fk_pedido_restaurante` (`id_restaurante`),
  CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id_produto` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_restaurante` bigint unsigned NOT NULL,
  `id_administrador` bigint unsigned DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text,
  `categoria` varchar(100) DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  `tempo_preparo_min` int DEFAULT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `fk_produto_restaurante` (`id_restaurante`),
  KEY `fk_produto_administrador` (`id_administrador`),
  CONSTRAINT `fk_produto_administrador` FOREIGN KEY (`id_administrador`) REFERENCES `administrador` (`id_adm`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_produto_restaurante` FOREIGN KEY (`id_restaurante`) REFERENCES `restaurante` (`id_restaurante`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (8,15,12,'bolo',NULL,NULL,40.00,1,'2025-12-04 17:55:56',NULL),(9,15,12,'bolonhesa',NULL,NULL,20.00,1,'2025-12-04 19:37:02',NULL),(10,15,12,'lasanha',NULL,NULL,15.00,1,'2025-12-05 15:17:31',NULL);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurante`
--

DROP TABLE IF EXISTS `restaurante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurante` (
  `id_restaurante` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `endereco` json DEFAULT NULL,
  `cnpj` char(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ativo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Indica se o restaurante est√° ativo',
  `cod` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_restaurante`),
  UNIQUE KEY `telefone` (`telefone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurante`
--

LOCK TABLES `restaurante` WRITE;
/*!40000 ALTER TABLE `restaurante` DISABLE KEYS */;
INSERT INTO `restaurante` VALUES (1,'Restaurante Sabor Caseiro','1133334444',NULL,'{\"rua\": \"Rua das Flores\", \"cidade\": \"S√£o Paulo\", \"numero\": 100}','12345678000100','2025-11-18 16:37:59','2025-11-18 16:37:59',1,NULL),(2,'Pizzaria Massa Fina','1144445555',NULL,'{\"rua\": \"Av. Central\", \"cidade\": \"Santos\", \"numero\": 200}','98765432000199','2025-11-18 16:37:59','2025-11-18 16:37:59',1,NULL),(4,'RcPoZhtGgCK77UsaQHRsxAzOah31FwhXdbt5HXWHEfmmZDi4k61T/tjdIGH1H9ki+nFzdwuFjBlRueVxIVfDdA==',NULL,NULL,NULL,NULL,'2025-11-26 15:27:38','2025-11-26 15:27:38',1,'M/JjwpKg1QuB0QWnXe2Axwul7XsNum+YJkJkp/imqwjXEla9TBi3SfN2J79KInZ9yo+2CQArjXkmN4fLxlbHYQ=='),(5,'6ZjgOuYvEY3VS5F8N4NY9Tz3Jd4Sj8EWUMEw3vjxmAhqpZE6fFPRVySHoLENfXZxOzZ951ggRJQj2aqOlaJdXg==',NULL,NULL,NULL,NULL,'2025-11-26 16:02:57','2025-11-26 16:02:57',1,'NsjC/vVwKnry6ZdgE80DyFkZNzlYjzTas+xkhIRypKuAslmAh7uvZY0x2lEIqK+zXpU9kmfUZyEiEEnFZ92WfQ=='),(15,'/tx1k2qvccP2y/ZZLRIku5t4QB0li3E788BmXjIArDtJ/Phwobp0/X3hZoNNOjOig01Rv+C6LX3OnPD0DL5nhw==',NULL,NULL,NULL,NULL,'2025-11-29 15:16:50','2025-11-29 15:16:50',1,'0xn5mjgmwVxluz7QAh0v1utV8t+aovBnUmiZWZK5Ll90OpJgpTk2zHfABp8TY0ycEKSyBa6Jt65oGFX60whDPg=='),(16,'NHkbnvEor8mju34ncpyG8CrI+A0NMV38o7WbPRpoARnQxfgUcoFTGI5QgjQXMDHLrLBDhysP3duT+KyMEZlxyQ==',NULL,NULL,NULL,NULL,'2025-11-29 15:16:51','2025-11-29 15:16:51',1,'XxiwTv0qU4r+2Q2J1ynJvW/M5uApiUFVhZMQ+n8uxTxe9M7fDi/bYfDnjnsIcOWa+nbZzp6anm+0smhSGsKWuw=='),(17,'C36LH90ztd/I5wJ0C0aweSKUSBQuRDkS56aui4feWmMg2dax1KIc2MoV+dWr2hYjFcP5fkksecD7Q3YkMuwuww==',NULL,NULL,NULL,NULL,'2025-11-29 15:23:20','2025-11-29 15:23:20',1,'YGPSLlbozFgME4vFaKdcgEiUr5I5WrR/Q9ToumbEi/2Ea/aq219X96V8iH8Gmf8CSE3t4uaRpKxZNGdsgOdHLg=='),(18,'H2qIMN53dni7Cco1ACflDtCm9rmiIEGrntwYG77Tn4sL2H3LGM+JJYKF27NDls7vPzy68G7y0T3rILLpUtooKg==',NULL,NULL,NULL,NULL,'2025-11-29 15:43:22','2025-11-29 15:43:22',1,'YES56iX0qWo5s/Tjdh1EfVoy+W0m2oZXVvSAkKxrt91AOXJaH9xsAbtlnNFDzazeQeB1QjAVs6/tXp07SICJ+w=='),(19,'ocTXcg3PAA+4q/mbCuTMePS9OsizVgijteeM6Qc1veI1hu+YGHMXXvhvjD45farfTRuxkFC7kTsBZCkWwh2TDw==',NULL,NULL,NULL,NULL,'2025-11-29 15:49:57','2025-11-29 15:49:57',1,'0XwJcvpVhTDlQ0vSCWYfmAXpUtCoeZMuwG015/Dwz7JozdygNksWngh9JZWnEuMUk8kFm1g33sG1oPuaUeu+2w=='),(20,'r6KwyjFVlvWJNDvkQ5opizpqeW1T5/7VG+ItYQ+04jVpCiPKyXihlJ8mXzRa4MzJHurkOewPTuw0gLwXdYs7lg==',NULL,NULL,NULL,NULL,'2025-11-29 15:52:25','2025-11-29 15:52:25',1,'XicidFxpS+vRGutA85qOhrVYvA0ihydknQuCkeGdxU0x4ZwbfFEzPQCCmo2dStl8n1nk8YpwbXE/DFxnx2hSpg=='),(21,'Bn25A2e/zG9mrCxJZ88cH49mpfV4O/CYsqqBmUbogN9VymmgTLfyNqTd2Xy+9CRVBjd8QWr+UMAQeykqRah27g==',NULL,NULL,NULL,NULL,'2025-11-29 22:51:32','2025-11-29 22:51:32',1,'/QAxEokXim3yhoQfAp8eFXH5EeJQRIyKFuMH2mO3eDQWj04B5oqWPYzs7y0+xIadH8KSA1ctAcNsN6oo+p8rZg=='),(22,'d4nn9XSgWrPbN3RMpUg1VSz11Y1TksR528ya9bIU78elfssYOcmSskXxxvLw+BDpgnjokKaH6Nbe5i5A83imaw==',NULL,NULL,NULL,NULL,'2025-11-29 22:55:58','2025-11-29 22:55:58',1,'1P2qCfb0oqsd5yu718zi6MbTXOXsRoGBQADwFwYi+teCHTvc9ryCiEL8CKy8YGsh49SBbYVzBuTDnwdhCA0g5w=='),(23,'DtjiKbBh135e364GgU7kiQ0VvEJvGjg/yV/hU9nXbYERLDOR4SJIEh/BkDQO7DjtYDLpeHifFatdc0r1sWD1tw==',NULL,NULL,NULL,NULL,'2025-11-30 09:06:06','2025-11-30 09:06:06',1,'6OhG/hn16mSGiRjSu59LfMjcdW3cXJeh4lEOLWftEod71qkjSSGyMeZt9+vougCe8B/IfAjaK9MpxRiv6HdYVg=='),(24,'RfqUCzPHznjFxZzjEW75PSQdsXliSgT7m7yds92C/QYwStPuGKy+DN8ICvD4SYNwpbqZ/YyudMk6uMaqZDatgg==',NULL,NULL,NULL,NULL,'2025-11-30 09:24:43','2025-11-30 09:24:43',1,'sVeUTMx0xP9tm7zHUoroYL5rgdj389G1QWO9NQrAM4mAaTjmmmP7UTQPwtXv41UXpG+kFLMQa9eQnR5jJDwmnA=='),(25,'pmBTz9HH42UxQTLjUOLaIpecONPNGauK+d024hEjgxKenbQzSZM2Nq2pwlRVNRAV6+28TPZhEr73x/8z2u6Ozg==',NULL,NULL,NULL,NULL,'2025-11-30 09:27:50','2025-11-30 09:27:50',1,'1NPVRRuI1GRpuOd5La7HdH83y+xuOS0CZqRnR/XFkEj93+RuQpnT/rLo5KnEJi3LpmJTpk3tOwge5ccEDLKxdQ=='),(26,'O2nVEXLnxyK/u/Hw4vGTXMumMO3IQQQNyULUTfM8zrm6oHGyei/DRjET7eZR70b7Lm70gnr16YX3lmQFWIBw+g==',NULL,NULL,NULL,NULL,'2025-11-30 10:12:23','2025-11-30 10:12:23',1,'HRIIFboqWS1upsm5cNbIDj53YCjRjHfmrwVmcIsN5jneKJOeJ0oypV19ohQ3Q9P6r8I9RRP7Jgn+4uav4kxZeg=='),(27,'UJx3KXu16hfKSVR9lg6rxEKjwWexBvurLxrIrPN01R3sNGjFz/1HGr5ALtP2d3wf5YfnGzLM2lZ9d658cu5FhA==',NULL,NULL,NULL,NULL,'2025-11-30 16:18:46','2025-11-30 16:18:46',1,'kbqBBm0obL8IjgP7CS1YPF3Y0a5tKpgNZvXR1X23DT5ikDNqK5z0KGBioHF/nyGvcKsP+KZBlQG+ZIOhGD7F+A=='),(28,'uH5jl5wIOfp3E/k4DmaEqsDmWlFSkG2AHW+C5nS9twcHw+fy21fvDA+sqm1dgCFxQx/OJqYbkH/pAkopTUXRyw==',NULL,NULL,NULL,NULL,'2025-11-30 16:23:17','2025-11-30 16:23:17',1,'kKzd09itxvedlQpW2ii7l69/ebaktMDITptACNDv3l6BsvPNYSnVt7Bmsqjw2huXe01xqP1OT7XQKgt1lhCE9w=='),(29,'LUDEIJ45IKw5yeOZ2xU8yDjiE0uhjVhn1/Dt5PDNIiF16LaH85MQk/ZHNWqfr+qqWKljnCmkHgfCa3OesubYVg==',NULL,NULL,NULL,NULL,'2025-12-01 15:21:09','2025-12-01 15:21:09',1,'WO8TeVGnLd0qUwxlhx5fidCBTdtNJ2+4ZjqiBRGbVUqw2gkgnyTKYyk/dysUlvple5EUdrBrE7ZDJgbvGzr1Yg==');
/*!40000 ALTER TABLE `restaurante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `cpf` char(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nome` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefone` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `senha_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `telefone` (`telefone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('0000000000',NULL,'4F/Pck3+4eJ8XueG3z6QSTJlZ/jJfO2DA7lGytaIRnfH3/mGQPWWCpumlsv+kby3lI083Vo+J23NOewM4CjF5w==',NULL,'$2y$12$QX5XaV8bIgTE3p29ku8o6.J5qFz/cvr9Ycy8P3JI5OXQkGLZScoiK','2025-12-01 18:47:13','2025-12-01 18:47:13'),('00000000000',NULL,'fCZHMaNNQx1nI3XnpNhoz0tJJLuxgut85cVhS4dHNm4HcCjF99g9dU96BQ+HvTaeK6ntmgiNyQ/Oyo4nlorv9g==',NULL,'$2y$12$N2Hq9U91w4U2mRUprzTKjeeXf4FibVWp6z5BKehpc/DiOw77OQh8G','2025-12-01 16:46:55','2025-12-01 16:46:55'),('01032344466',NULL,'336TJhqrFEfoZ9JnzStq49vEbmchRJS7jAmSTFuQk/UCToaaU0t5ESXA2kJSJMvvRQpgbruKqLHt2ZRW2hBlLw==',NULL,'$2y$12$Md0lDiZWIbt4afdzYaleIO57rn7ngf7rMRVpuFEm5LyxUIB1Iwl6W','2025-12-04 12:54:14','2025-12-04 12:54:14'),('01177178516',NULL,'1QcSiANXiJZr7dPRvtqGxWkyDk2oqCQsCXQ4ERthIUZhzryyz0RVtehzGR2lKr/3V2cnA6kCOBLs2lsTCxk9b/CvIh9LCmCzSmJJ6AbuHJY=',NULL,'$2y$12$gtiIKQhvb9Yw3zsEpvns5.G524Eu2bkpWu0o6OBvzuOtcuiWo0hdu','2025-11-29 23:20:33','2025-11-29 23:20:33'),('08300827510',NULL,'/O9HN2RpyUklLxtOUd3QGl5EOeknzWtqKu+ClCap2vNKmjkXdLvnEn/oc1fFMhRzFWc/7NcNiDHAoo+ZcS+blsxfrhVtLvGa+u2EaPEgRBM=',NULL,'$2y$12$h4j0uzqvGb1YWgOMfLd/Xu0OT3lr5O5XnwZYVJk7lzD63SL2DdKf6','2025-11-29 23:15:13','2025-11-29 23:15:13'),('09153915623',NULL,'cR7oIHcqA7P2qz0mIz6/x81hwX6RNaZtrfIMLhpt62EE/mDC7JlRu52OTzSjZZ5Nnw8I8I6YGcSW0y5/NSsFTA==',NULL,'$2y$12$mwEJkbAXS6w.LkrjNoBvse9hvOSw9TJloJl/weO8CDusgQY3aNhSq','2025-12-04 08:33:07','2025-12-04 08:33:07'),('11122233396',NULL,'iEKb4tKlSxFXLjyMSasHwcECcLvqQgsppAOu1omO/Dcwzx+UydLXzRSTOS89AExTXhhBDLtmoDNQf30AqCH5Ig==',NULL,'$2y$12$t.NFsMaWaLtsHN9KOeBmIey/Nnys.wRRD1RdXINAzHhNKBLyHiF9u','2025-12-05 11:25:43','2025-12-05 11:25:43'),('12233344499',NULL,'1pD+GQa6KSWdbXBNn/SZEitJIP/cWX8DpNaabLxFz1oeUwFQDRVroQ3HuGG/lPD6L9tTEZffd71kqVn6YhDT0A==',NULL,'$2y$12$0hAs84ba0QPoJe1uKgf0c.I9XEk3oNjtfQ/fmg6FX83Fj4s/MDm9m','2025-12-04 08:43:18','2025-12-04 08:43:18'),('12345678909',NULL,'ML6qxYfKKkWPxAb1oTXrpwJSunZjPqVThEDJEcutFC592m/LRWS2MsiQpvHvVTyctgvhRVCdNiNh28/OqYuT9g==',NULL,'$2y$12$bX9t4/YcbEhlvI3LNaSFqesIhcbmWHMNajnXj6JI78yG9EuV1GJxq','2025-11-29 15:33:06','2025-11-29 15:33:06'),('33388899924',NULL,'Bqc2Fvb9+9tXA7WnEkx4xsupohRhk35ecbtOtvnJQPP2AAnoHCU5GLdT1kZezDtoPLbALf1M+H7qccinUfoW2A==',NULL,'$2y$12$YEj2h1f65AIvpusmxs6rqOuL2B4pmznUG1OtVAt9N8RCH.O8bwWIu','2025-12-05 15:10:41','2025-12-05 15:10:41'),('40048922102',NULL,'RxLUt1UZUOJYzk1IqL49K6QfJcFm2magaBQWCRy66uuyHlku+srEFA86a0432BACI+XopAINwAnAH3npEJgPZw==',NULL,'$2y$12$ckWkRxjbDbQV5t0K.44D.um3jSWkfGkxQLrD5rr.f3FXl4GSjfAFK','2025-12-04 09:58:27','2025-12-04 09:58:27'),('77755544443',NULL,'fV9AUUoXzqpLSmf/S7dtK7PynX49xUn/lIhRw4iq1cpcJrDs00iKQbin2rAwfIphAwWb8r8TgAD+pMUzNOSFNQ==',NULL,'$2y$12$hZkp.7zgyRxSEIhKCluSJu5kixnBHlHNecgkJo63.jh44SBhIMRZq','2025-11-30 16:41:05','2025-11-30 16:41:05'),('78774777750',NULL,'Aorl5V+AIGAvhdw/VBi3pWEy/6Ma5yPFAejVn6gb+463hYYAhxK0rMsOM+ETryRTTjfXnZ2vM+RjF+1gZUmYTA==',NULL,'$2y$12$Sef4fWXpHXFPS3ntqSfaCu7.Hv/mgp6sLHn90VDxGMqZsI7WvralS','2025-12-04 08:27:31','2025-12-04 08:27:31'),('88153915681',NULL,'65beLk6G/5/0arCW2uHkE5K/LCHNMrN4LDEZDSeeHS5Lw/+ypqTOjDJpPf2WS5UnfVyJDy7OLDIi9VwfH9Kvi8HgOEo9cFhVl+1fAwN1RIQ=',NULL,'$2y$12$Ab4kp5/.WiCr4RCTq/l0x.4q83LJazYqDXyuFAP20EYDkC6lpH0Ru','2025-11-30 16:33:37','2025-11-30 16:33:37'),('88899977704',NULL,'5uJtxpJ7JCDXyTGdQqlawf8985PFRUVHLmwnMduki1GneeWNV6qyn2as0HH/hK6GV/1Vzr5gmJgYe3++gOvIJw==',NULL,'$2y$12$yDaORGxSiCdJknYFMqxQS./kYRpsug5dv8YbBpZBAfxDnRcIIPhwi','2025-12-04 12:47:53','2025-12-04 12:47:53'),('98153915690',NULL,'kzleDdFcDjIbaaV5Fh5RI3XCg1S0kzInLb0ObksgQrsO2uZFcQPRuOCugLGvgQsSjYx9w5mESoyEDnMMQCvf94EOBYilSw6ihKUFUhtaXds=',NULL,'$2y$12$uMLMh2wrEiVBxqhL89qvcewxE0V27Uo4CLgpCcLo31a9liZ1iXe5C','2025-11-30 16:32:11','2025-11-30 16:32:11'),('98765432100',NULL,'NRtMF266mkfwvKHCN3o1TZQ8IA7/L0DsMPC6+raeMBxkhZU9icICwBYu4oq7UHzKvYdRVUlhI356ssKKd3qpJg==',NULL,'$2y$12$jkvJaJPYaTmNORnKdm8OPeFa4AvyvomcnPprBAn4VQ1FSFNN6U0Q6','2025-11-30 09:44:22','2025-11-30 09:44:22'),('99977755540',NULL,'fVApObz5srqmYKDCtbaZHw3jMTm8ehhrXGC5qqvFIEE06tTE7KlkQ4CxttdviCCCdbZYPVI0s5QOcLQrrSqjwg==',NULL,'$2y$12$DjpupL5PywJN1tXDKxDFUenr2eRiazUpVqQYa1m0CDdaqbiVcnWMK','2025-12-02 12:35:16','2025-12-02 12:35:16'),('99981539139',NULL,'1+2k2f8+ka1K04oTXclOoi9SauephGVvwlAAt1C8Ouj7TBuKgaXtBggiL5zw7YFchGvQiDW1ebUVTTCvQ9Uj9Q==',NULL,'$2y$12$UBW9QMvJRbfUYqw61yXTUuY1HbpYT/7AMg/0C3iSXjgiiMVrSWRh2','2025-12-01 23:45:10','2025-12-01 23:45:10'),('99988877714',NULL,'ANzapPTfOu/86xpYpOTK7DsjhT+ccK6sUaWYeyiXF5TGJnDB1A/q2z1CIfqJGAEjD/3obnIgfADhL8ZbbjJSZw==',NULL,'$2y$12$Cx16Qq0Hm4uAB4kLb1lH7e1fX9KmdvVERE5RNFsYgVJf6LqlaA3UK','2025-12-03 09:48:49','2025-12-03 09:48:49');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_chave`
--

DROP TABLE IF EXISTS `usuario_chave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_chave` (
  `cpf` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chave_criptografia` varbinary(32) NOT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  `ativo` tinyint(1) DEFAULT '1',
  `senha_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_adm` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`cpf`),
  KEY `usuario_chave_adm_fk` (`id_adm`),
  CONSTRAINT `usuario_chave_adm_fk` FOREIGN KEY (`id_adm`) REFERENCES `administrador` (`id_adm`),
  CONSTRAINT `usuario_chave_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `usuario` (`cpf`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_chave`
--

LOCK TABLES `usuario_chave` WRITE;
/*!40000 ALTER TABLE `usuario_chave` DISABLE KEYS */;
INSERT INTO `usuario_chave` VALUES ('0000000000',_binary 'SàÜ\≈\›#=1uå™Z\—x\…ÀïMîH\Ë\Á}∞b','2025-12-01 18:47:13',1,'$2y$12$QX5XaV8bIgTE3p29ku8o6.J5qFz/cvr9Ycy8P3JI5OXQkGLZScoiK',NULL),('00000000000',_binary '\Ÿ\⁄x1t}∑∞’ö\'\–\–G\ÿJ.)\‰\”g∂V/\rjk§µ\ﬂG','2025-12-01 16:46:55',1,'$2y$12$N2Hq9U91w4U2mRUprzTKjeeXf4FibVWp6z5BKehpc/DiOw77OQh8G',NULL),('01032344466',_binary 'j5\"\…ﬁΩ\n3\ﬁhRÎéæ\‘—ælõÑ\Ó\ÿhí·õ≤7','2025-12-04 12:54:15',1,'$2y$12$Md0lDiZWIbt4afdzYaleIO57rn7ngf7rMRVpuFEm5LyxUIB1Iwl6W',NULL),('01177178516',_binary '\»eFÉ\˜5ßO£µ¥˝’∞±!=\'Snd0N\À\Èe(','2025-11-29 23:20:33',1,'$2y$12$gtiIKQhvb9Yw3zsEpvns5.G524Eu2bkpWu0o6OBvzuOtcuiWo0hdu',NULL),('08300827510',_binary '\\\Ãq\Z\È\÷¸DeÅÅö≠EÉ\‘`®j#˝Æ\Íq\Ò√ÇÜÈ§ª','2025-11-29 23:15:13',1,'$2y$12$h4j0uzqvGb1YWgOMfLd/Xu0OT3lr5O5XnwZYVJk7lzD63SL2DdKf6',NULL),('09153915623',_binary '\\\¬\— àz+µ£ù∂ù\Í\‘H˙q\‰s.#£\\8\ˆ}<\ÃmN\·=','2025-12-04 08:33:07',1,'$2y$12$mwEJkbAXS6w.LkrjNoBvse9hvOSw9TJloJl/weO8CDusgQY3aNhSq',NULL),('11122233396',_binary '%µ3\'\—\'\œ3∫jÉ6>•`∫í;Sπ\nW\÷\'\0\Õ\„ã\€Hv','2025-12-05 11:25:43',1,'$2y$12$t.NFsMaWaLtsHN9KOeBmIey/Nnys.wRRD1RdXINAzHhNKBLyHiF9u',NULL),('12233344499',_binary '6õ§UqÑŒã5\Ã|E>)\'af*\Í;…Äêß\∆=\ƒ2∏E8','2025-12-04 08:43:18',1,'$2y$12$0hAs84ba0QPoJe1uKgf0c.I9XEk3oNjtfQ/fmg6FX83Fj4s/MDm9m',NULL),('12345678909',_binary 'sp~œÑ∫êé\¬n¥≠3˘⁄ßºt¢æ§kYæ`WCêF','2025-11-29 15:33:06',1,'$2y$12$bX9t4/YcbEhlvI3LNaSFqesIhcbmWHMNajnXj6JI78yG9EuV1GJxq',NULL),('33388899924',_binary '9î]K£Ñ!ò¢\“L-\–\À\Ï∂5\ı2ç\ÊmV\Áî˘º\','2025-12-05 15:10:41',1,'$2y$12$YEj2h1f65AIvpusmxs6rqOuL2B4pmznUG1OtVAt9N8RCH.O8bwWIu',NULL),('40048922102',_binary '\‹\√]\÷Nüp\Ê\·2FY\Ò¢]R]\ıJi@@ ø-3/wh','2025-12-04 09:58:27',1,'$2y$12$ckWkRxjbDbQV5t0K.44D.um3jSWkfGkxQLrD5rr.f3FXl4GSjfAFK',NULL),('77755544443',_binary '©>ÇsL[¨o>\√¿≥\ı\Ê3=]O/Ul¥¢ép\…\ˆ\Ó\À','2025-11-30 16:41:05',1,'$2y$12$hZkp.7zgyRxSEIhKCluSJu5kixnBHlHNecgkJo63.jh44SBhIMRZq',NULL),('78774777750',_binary '\ÿ	h*7ë^0\"\≈\∆¿1oP\Ê€ëª=º/ª,uwò√†∂','2025-12-04 08:27:31',1,'$2y$12$Sef4fWXpHXFPS3ntqSfaCu7.Hv/mgp6sLHn90VDxGMqZsI7WvralS',NULL),('88153915681',_binary '36M\Ù7pMp	ÇÑ5:∫UJWdu>jn°E±\›¯<¡','2025-11-30 16:33:37',1,'$2y$12$Ab4kp5/.WiCr4RCTq/l0x.4q83LJazYqDXyuFAP20EYDkC6lpH0Ru',NULL),('88899977704',_binary 'Pkñêb\Ò, ã=*\√\‚*vk{\ÒEûµê∫¯)\Ò\nk;','2025-12-04 12:47:53',1,'$2y$12$yDaORGxSiCdJknYFMqxQS./kYRpsug5dv8YbBpZBAfxDnRcIIPhwi',NULL),('98153915690',_binary '˛≠\«ﬂÆ\Ÿ&2î\Ï¡›è\ﬁ\‹‹ó9Uã\«\Ïï\ÃZ!±!','2025-11-30 16:32:11',1,'$2y$12$uMLMh2wrEiVBxqhL89qvcewxE0V27Uo4CLgpCcLo31a9liZ1iXe5C',NULL),('98765432100',_binary '{˝\ËEÇ<≥¬≤\ÁqBFº>∫\ áµ\“9\ˆ¯¬Éûº¥','2025-11-30 09:44:22',1,'$2y$12$jkvJaJPYaTmNORnKdm8OPeFa4AvyvomcnPprBAn4VQ1FSFNN6U0Q6',NULL),('99977755540',_binary '	<£¶N\”-UA\ZL5u∞¶[@\ı\Ú\ÍìÜé\‰\ÿ[\‡¯','2025-12-02 12:35:16',1,'$2y$12$DjpupL5PywJN1tXDKxDFUenr2eRiazUpVqQYa1m0CDdaqbiVcnWMK',NULL),('99981539139',_binary 'w¿uÀë<}°7T90ó8\‘GxBLe,\ı{ÜÀ∞(\˜\⁄>','2025-12-01 23:45:10',1,'$2y$12$UBW9QMvJRbfUYqw61yXTUuY1HbpYT/7AMg/0C3iSXjgiiMVrSWRh2',NULL),('99988877714',_binary '™Ç´LS≠¨<d\«\'WA`eπ˘∑&˝dƒ∫\◊To\„¢','2025-12-03 09:48:49',1,'$2y$12$Cx16Qq0Hm4uAB4kLb1lH7e1fX9KmdvVERE5RNFsYgVJf6LqlaA3UK',NULL);
/*!40000 ALTER TABLE `usuario_chave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_agendamento_detalhes`
--

DROP TABLE IF EXISTS `vw_agendamento_detalhes`;
/*!50001 DROP VIEW IF EXISTS `vw_agendamento_detalhes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agendamento_detalhes` AS SELECT 
 1 AS `id_agendamento`,
 1 AS `id_cliente`,
 1 AS `nome_cliente`,
 1 AS `data`,
 1 AS `hora`,
 1 AS `numero_pessoas`,
 1 AS `mensagem`,
 1 AS `id_restaurante`,
 1 AS `restaurante`,
 1 AS `endereco_restaurante`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_cardapio`
--

DROP TABLE IF EXISTS `vw_cardapio`;
/*!50001 DROP VIEW IF EXISTS `vw_cardapio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cardapio` AS SELECT 
 1 AS `id_produto`,
 1 AS `nome_produto`,
 1 AS `preco`,
 1 AS `tempo_preparo_min`,
 1 AS `id_restaurante`,
 1 AS `restaurante`,
 1 AS `status_exibicao`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_cliente_detalhes`
--

DROP TABLE IF EXISTS `vw_cliente_detalhes`;
/*!50001 DROP VIEW IF EXISTS `vw_cliente_detalhes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cliente_detalhes` AS SELECT 
 1 AS `id_cliente`,
 1 AS `cpf`,
 1 AS `nome`,
 1 AS `email`,
 1 AS `telefone`,
 1 AS `data_registro`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_cliente_metricas_cadastro`
--

DROP TABLE IF EXISTS `vw_cliente_metricas_cadastro`;
/*!50001 DROP VIEW IF EXISTS `vw_cliente_metricas_cadastro`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cliente_metricas_cadastro` AS SELECT 
 1 AS `mes`,
 1 AS `nome_mes`,
 1 AS `total_cadastrados`,
 1 AS `ativos`,
 1 AS `inativos`,
 1 AS `sem_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_filiais_populares_avaliadas`
--

DROP TABLE IF EXISTS `vw_filiais_populares_avaliadas`;
/*!50001 DROP VIEW IF EXISTS `vw_filiais_populares_avaliadas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_filiais_populares_avaliadas` AS SELECT 
 1 AS `id_restaurante`,
 1 AS `filial`,
 1 AS `cidade`,
 1 AS `total_pedidos`,
 1 AS `total_vendas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_financeiro_mensal_adm`
--

DROP TABLE IF EXISTS `vw_financeiro_mensal_adm`;
/*!50001 DROP VIEW IF EXISTS `vw_financeiro_mensal_adm`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_financeiro_mensal_adm` AS SELECT 
 1 AS `id_restaurante`,
 1 AS `restaurante`,
 1 AS `total_recebido_mes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_informacoes_pessoais_adm`
--

DROP TABLE IF EXISTS `vw_informacoes_pessoais_adm`;
/*!50001 DROP VIEW IF EXISTS `vw_informacoes_pessoais_adm`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_informacoes_pessoais_adm` AS SELECT 
 1 AS `id_adm`,
 1 AS `nome_administrador`,
 1 AS `email`,
 1 AS `telefone`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_mesas_disponibilidade`
--

DROP TABLE IF EXISTS `vw_mesas_disponibilidade`;
/*!50001 DROP VIEW IF EXISTS `vw_mesas_disponibilidade`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_mesas_disponibilidade` AS SELECT 
 1 AS `id_mesa`,
 1 AS `numero`,
 1 AS `capacidade`,
 1 AS `id_restaurante`,
 1 AS `hora_ocupada`,
 1 AS `data_ocupada`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_novos_cadastros`
--

DROP TABLE IF EXISTS `vw_novos_cadastros`;
/*!50001 DROP VIEW IF EXISTS `vw_novos_cadastros`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_novos_cadastros` AS SELECT 
 1 AS `data_cadastro`,
 1 AS `total_novos_clientes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_pratos_mais_vendidos`
--

DROP TABLE IF EXISTS `vw_pratos_mais_vendidos`;
/*!50001 DROP VIEW IF EXISTS `vw_pratos_mais_vendidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_pratos_mais_vendidos` AS SELECT 
 1 AS `nome_produto`,
 1 AS `nome_restaurante`,
 1 AS `quantidade_vendida`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_reservas`
--

DROP TABLE IF EXISTS `vw_reservas`;
/*!50001 DROP VIEW IF EXISTS `vw_reservas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_reservas` AS SELECT 
 1 AS `id_restaurante`,
 1 AS `id_agendamento`,
 1 AS `cliente_nome`,
 1 AS `cliente_telefone`,
 1 AS `data_reserva`,
 1 AS `hora_reserva`,
 1 AS `acao`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_reservas_semanais`
--

DROP TABLE IF EXISTS `vw_reservas_semanais`;
/*!50001 DROP VIEW IF EXISTS `vw_reservas_semanais`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_reservas_semanais` AS SELECT 
 1 AS `semana_iso`,
 1 AS `total_reservas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_total_vendas_diario`
--

DROP TABLE IF EXISTS `vw_total_vendas_diario`;
/*!50001 DROP VIEW IF EXISTS `vw_total_vendas_diario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_total_vendas_diario` AS SELECT 
 1 AS `data_venda`,
 1 AS `id_restaurante`,
 1 AS `restaurante`,
 1 AS `total_vendas`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_agendamento_detalhes`
--

/*!50001 DROP VIEW IF EXISTS `vw_agendamento_detalhes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agendamento_detalhes` AS select `a`.`id_agendamento` AS `id_agendamento`,`a`.`id_cliente` AS `id_cliente`,`u`.`nome` AS `nome_cliente`,`a`.`data` AS `data`,`a`.`hora` AS `hora`,`a`.`numero_pessoas` AS `numero_pessoas`,`a`.`mensagem` AS `mensagem`,`r`.`id_restaurante` AS `id_restaurante`,`r`.`nome` AS `restaurante`,concat(coalesce(json_unquote(json_extract(`r`.`endereco`,'$.logradouro')),''),', ',coalesce(json_unquote(json_extract(`r`.`endereco`,'$.numero')),''),' - ',coalesce(json_unquote(json_extract(`r`.`endereco`,'$.bairro')),''),', ',coalesce(json_unquote(json_extract(`r`.`endereco`,'$.cidade')),''),' - ',coalesce(json_unquote(json_extract(`r`.`endereco`,'$.uf')),'')) AS `endereco_restaurante` from (((`agendamento` `a` join `cliente` `c` on((`a`.`id_cliente` = `c`.`id_cliente`))) join `usuario` `u` on((`c`.`cpf` = `u`.`cpf`))) join `restaurante` `r` on((`a`.`id_restaurante` = `r`.`id_restaurante`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cardapio`
--

/*!50001 DROP VIEW IF EXISTS `vw_cardapio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cardapio` AS select `p`.`id_produto` AS `id_produto`,`p`.`nome` AS `nome_produto`,`p`.`preco` AS `preco`,`p`.`tempo_preparo_min` AS `tempo_preparo_min`,`r`.`id_restaurante` AS `id_restaurante`,`r`.`nome` AS `restaurante`,(case when ((`p`.`ativo` = 1) and (`r`.`ativo` = 1)) then 'Dispon√≠vel' else 'Indispon√≠vel' end) AS `status_exibicao` from (`produto` `p` join `restaurante` `r` on((`p`.`id_restaurante` = `r`.`id_restaurante`))) where ((`p`.`ativo` = 1) and (`r`.`ativo` = 1)) order by `r`.`nome`,`p`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cliente_detalhes`
--

/*!50001 DROP VIEW IF EXISTS `vw_cliente_detalhes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cliente_detalhes` AS select `c`.`id_cliente` AS `id_cliente`,`u`.`cpf` AS `cpf`,`u`.`nome` AS `nome`,`u`.`email` AS `email`,`u`.`telefone` AS `telefone`,`c`.`data_registro` AS `data_registro`,`c`.`status` AS `status` from (`cliente` `c` join `usuario` `u` on((`c`.`cpf` = `u`.`cpf`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cliente_metricas_cadastro`
--

/*!50001 DROP VIEW IF EXISTS `vw_cliente_metricas_cadastro`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cliente_metricas_cadastro` AS select date_format(`u`.`data_cadastro`,'%Y-%m-01') AS `mes`,(case date_format(`u`.`data_cadastro`,'%c') when 1 then concat('Janeiro ',year(`u`.`data_cadastro`)) when 2 then concat('Fevereiro ',year(`u`.`data_cadastro`)) when 3 then concat('Mar√ßo ',year(`u`.`data_cadastro`)) when 4 then concat('Abril ',year(`u`.`data_cadastro`)) when 5 then concat('Maio ',year(`u`.`data_cadastro`)) when 6 then concat('Junho ',year(`u`.`data_cadastro`)) when 7 then concat('Julho ',year(`u`.`data_cadastro`)) when 8 then concat('Agosto ',year(`u`.`data_cadastro`)) when 9 then concat('Setembro ',year(`u`.`data_cadastro`)) when 10 then concat('Outubro ',year(`u`.`data_cadastro`)) when 11 then concat('Novembro ',year(`u`.`data_cadastro`)) when 12 then concat('Dezembro ',year(`u`.`data_cadastro`)) end) AS `nome_mes`,count(0) AS `total_cadastrados`,sum((`c`.`status` = true)) AS `ativos`,sum((`c`.`status` = false)) AS `inativos`,sum((`c`.`status` is null)) AS `sem_status` from (`cliente` `c` join `usuario` `u` on((`c`.`cpf` = `u`.`cpf`))) group by date_format(`u`.`data_cadastro`,'%Y-%m-01'),year(`u`.`data_cadastro`),month(`u`.`data_cadastro`) order by `mes` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_filiais_populares_avaliadas`
--

/*!50001 DROP VIEW IF EXISTS `vw_filiais_populares_avaliadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_filiais_populares_avaliadas` AS select `r`.`id_restaurante` AS `id_restaurante`,`r`.`nome` AS `filial`,json_unquote(json_extract(`r`.`endereco`,'$.cidade')) AS `cidade`,count(distinct `ped`.`id_pedido`) AS `total_pedidos`,sum(`p`.`valor_pagamento`) AS `total_vendas` from ((`restaurante` `r` join `pedido` `ped` on((`ped`.`id_restaurante` = `r`.`id_restaurante`))) join `pagamento` `p` on((`p`.`id_pedido` = `ped`.`id_pedido`))) where (`p`.`status_pagamento` = 1) group by `r`.`id_restaurante`,`r`.`nome`,json_unquote(json_extract(`r`.`endereco`,'$.cidade')) order by `total_pedidos` desc,`total_vendas` desc limit 6 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_financeiro_mensal_adm`
--

/*!50001 DROP VIEW IF EXISTS `vw_financeiro_mensal_adm`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_financeiro_mensal_adm` AS select `r`.`id_restaurante` AS `id_restaurante`,`r`.`nome` AS `restaurante`,round(sum(`p`.`valor_pagamento`),2) AS `total_recebido_mes` from (`restaurante` `r` join `pagamento` `p` on((`r`.`id_restaurante` = `p`.`id_restaurante`))) where ((month(`p`.`data_pagamento`) = month(curdate())) and (year(`p`.`data_pagamento`) = year(curdate())) and (`p`.`status_pagamento` = 1)) group by `r`.`id_restaurante`,`r`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_informacoes_pessoais_adm`
--

/*!50001 DROP VIEW IF EXISTS `vw_informacoes_pessoais_adm`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_informacoes_pessoais_adm` AS select `a`.`id_adm` AS `id_adm`,`u`.`nome` AS `nome_administrador`,`u`.`email` AS `email`,`u`.`telefone` AS `telefone` from (`administrador` `a` join `usuario` `u` on((`a`.`email` = `u`.`email`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_mesas_disponibilidade`
--

/*!50001 DROP VIEW IF EXISTS `vw_mesas_disponibilidade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_mesas_disponibilidade` AS select `m`.`id_mesa` AS `id_mesa`,`m`.`numero` AS `numero`,`m`.`capacidade` AS `capacidade`,`r`.`id_restaurante` AS `id_restaurante`,`a`.`hora` AS `hora_ocupada`,`a`.`data` AS `data_ocupada` from ((`mesa` `m` left join `agendamento` `a` on(((`a`.`id_mesa` = `m`.`id_mesa`) and (`a`.`status` = 'confirmado')))) left join `restaurante` `r` on((`m`.`id_restaurante` = `r`.`id_restaurante`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_novos_cadastros`
--

/*!50001 DROP VIEW IF EXISTS `vw_novos_cadastros`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_novos_cadastros` AS select cast(`u`.`data_cadastro` as date) AS `data_cadastro`,count(`c`.`id_cliente`) AS `total_novos_clientes` from (`cliente` `c` join `usuario` `u` on((`c`.`cpf` = `u`.`cpf`))) group by cast(`u`.`data_cadastro` as date) order by `data_cadastro` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_pratos_mais_vendidos`
--

/*!50001 DROP VIEW IF EXISTS `vw_pratos_mais_vendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_pratos_mais_vendidos` AS select `p`.`nome` AS `nome_produto`,`r`.`nome` AS `nome_restaurante`,sum(`ip`.`quantidade`) AS `quantidade_vendida` from (((`item_pedido` `ip` join `produto` `p` on((`ip`.`id_produto` = `p`.`id_produto`))) join `pedido` `ped` on((`ip`.`id_pedido` = `ped`.`id_pedido`))) join `restaurante` `r` on((`ped`.`id_restaurante` = `r`.`id_restaurante`))) group by `p`.`nome`,`r`.`nome` order by `quantidade_vendida` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_reservas`
--

/*!50001 DROP VIEW IF EXISTS `vw_reservas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_reservas` AS select `r`.`id_restaurante` AS `id_restaurante`,`a`.`id_agendamento` AS `id_agendamento`,`u`.`nome` AS `cliente_nome`,`u`.`telefone` AS `cliente_telefone`,`a`.`data` AS `data_reserva`,`a`.`hora` AS `hora_reserva`,(case when (`a`.`status` = 'confirmado') then 'Gerenciar / Cancelar' when (`a`.`status` = 'cancelado') then 'Reserva Cancelada' else 'A√ß√£o Indispon√≠vel' end) AS `acao` from ((((`agendamento` `a` join `restaurante` `r` on((`a`.`id_restaurante` = `r`.`id_restaurante`))) join `cliente` `c` on((`a`.`id_cliente` = `c`.`id_cliente`))) join `usuario` `u` on((`u`.`cpf` = `c`.`cpf`))) join `mesa` `m` on((`a`.`id_mesa` = `m`.`id_mesa`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_reservas_semanais`
--

/*!50001 DROP VIEW IF EXISTS `vw_reservas_semanais`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_reservas_semanais` AS select yearweek(`a`.`data`,3) AS `semana_iso`,count(0) AS `total_reservas` from `agendamento` `a` group by yearweek(`a`.`data`,3) order by `semana_iso` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_total_vendas_diario`
--

/*!50001 DROP VIEW IF EXISTS `vw_total_vendas_diario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_total_vendas_diario` AS select cast(`p`.`data_pagamento` as date) AS `data_venda`,`r`.`id_restaurante` AS `id_restaurante`,`r`.`nome` AS `restaurante`,sum(`p`.`valor_pagamento`) AS `total_vendas` from (`pagamento` `p` join `restaurante` `r` on((`p`.`id_restaurante` = `r`.`id_restaurante`))) where (`p`.`status_pagamento` = '1') group by cast(`p`.`data_pagamento` as date),`r`.`id_restaurante`,`r`.`nome` order by `data_venda` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-05 22:50:28
