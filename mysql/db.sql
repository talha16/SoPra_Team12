-- ------------------------------------------------------------------------
-- Datenbank Zeiterfassung
-- ------------------------------------------------------------------------
DROP DATABASE IF EXISTS Zeiterfassung;
CREATE DATABASE IF NOT EXISTS Zeiterfassung DEFAULT CHARACTER SET utf8mb4;
CREATE SCHEMA IF NOT EXISTS `Zeiterfassung` DEFAULT CHARACTER SET utf8mb4;
USE `Zeiterfassung` ;

-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Person'
-- -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Person` (
  `person_id` INT NOT NULL ,
  `vorname` VARCHAR(45) NULL,
  `nachname` VARCHAR(45) NULL,
  `mail_adresse` VARCHAR(150) NULL,
  `benutzername` VARCHAR(150) NULL,
  `urlaubstage` INT NULL,
  `ueberstunden` INT NULL,
  `letzte_aenderung` DATETIME NULL,
  -- Damit nicht mehrmals der gleiche Benutzername verwendet werden kann
  UNIQUE (benutzername),
  PRIMARY KEY (`person_id`));
  

  
-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Projekt'
-- -----------------------------------------------------------------------  
  CREATE TABLE IF NOT EXISTS `Projekt` (
  `projekt_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  `projektname` VARCHAR(150) NULL,
  `auftraggeber` VARCHAR(150) NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`projekt_id`),
  FOREIGN KEY (`person_id`)
	REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
  
  -- -----------------------------------------------------------------------
-- Tabelle erstellen 'Aktivitaet'
-- -----------------------------------------------------------------------
  CREATE TABLE IF NOT EXISTS `Aktivitaet` (
  `aktivitaet_id` INT NOT NULL,
  `projekt_id` INT NOT NULL,
  `bezeichnung` VARCHAR(45) NOT NULL ,
  `dauer` DATETIME NULL,
  `kapazitaet` INT NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`aktivitaet_id`),
  FOREIGN KEY (`projekt_id`)
	REFERENCES `Projekt` (`projekt_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
  
-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Urlaub'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Urlaub` (
  `urlaub_id` INT NOT NULL ,
  `person_id` INT NOT NULL ,
  `start_datum` DATETIME NULL,
  `end_datum` DATETIME NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`urlaub_id`),
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Kommen'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Kommen` (
  `kommen_id` INT NOT NULL,
  `person_id` INT NOT NULL ,
  `start` DATETIME NULL,
  `ende` DATETIME NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`kommen_id`),
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Gehen'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Gehen` (
  `gehen_id` INT NOT NULL,
  `person_id` INT NOT NULL ,
  `start` DATETIME NULL,
  `ende` DATETIME NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`gehen_id`),
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Ereignisbuchung'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Ereignisbuchung` (
  `ereignisbuchung_id` INT NOT NULL,
  `gehen_id` INT NOT NULL,
  `kommen_id` INT NOT NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`ereignisbuchung_id`),
    FOREIGN KEY (`kommen_id`)
    REFERENCES `Kommen` (`kommen_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`gehen_id`)
    REFERENCES `Gehen` (`gehen_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

    
-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Pause'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Pause` (
  `pause_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  `start` DATETIME NULL,
  `ende` DATETIME NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`pause_id`),
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Zeitintervall'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Projektarbeit` (
  `projektarbeit_id` INT NOT NULL,
  `person_id` INT NOT NULL ,
  `start` DATETIME NULL,
  `ende` DATETIME NULL,
  `aktivitaet_id` INT NOT NULL,
  `letzte_aenderung` DATETIME NULL,
 PRIMARY KEY (`projektarbeit_id`),
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`aktivitaet_id`)
    REFERENCES `Aktivitaet` (`aktivitaet_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Zeitintervallbuchung'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Zeitintervallbuchung` (
  `zeit_id` INT NOT NULL ,
  `projekt_id` INT NOT NULL,
  `person_id` INT NOT NULL ,
  `aktivitaet_id` INT NOT NULL,
  `gearbeitete_zeit` INT NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`zeit_id`),
	FOREIGN KEY (`projekt_id`)
	REFERENCES `Projekt` (`projekt_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`aktivitaet_id`)
    REFERENCES `Aktivitaet` (`aktivitaet_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);  
    
-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Arbeitszeitkonto'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Arbeitszeitkonto` (
  `zeit_id` INT NOT NULL ,
   password VARBINARY(100) default null,
   PRIMARY KEY (`zeit_id`));
 
    
    
-- -----------------------------------------------------------------------
-- Tabelle erstellen 'Mitarbeiter_in_Projekt'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Mitarbeiter_in_Projekt` (
  `person_idd` INT NOT NULL ,
  `projekt_id` INT NOT NULL,
  `verkaufte_stunden` INT NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`person_idd`,`projekt_id`),
	FOREIGN KEY (`person_idd`)
	REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`projekt_id`)
    REFERENCES `Projekt` (`projekt_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);  
  
  
  
  
-- -----------------------------------------------------------------------
-- Tabelle erstellen 'verkaufte_stunden_in_aktivitaet'
-- -----------------------------------------------------------------------
   CREATE TABLE IF NOT EXISTS `Verkaufte_stunden_in_aktivitaet` (
  `aktivitaet_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  `gebuchte_stunden` INT NOT NULL,
  `letzte_aenderung` DATETIME NULL,
  PRIMARY KEY (`aktivitaet_id`,`person_id`),
	FOREIGN KEY (`aktivitaet_id`)
	REFERENCES `Aktivitaet` (`aktivitaet_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);  
  
  
  
  
-- ---------------------------------------------------------------------------------------------------------------------------
-- Person Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('1', 'Levi', 'Ackermann', 'levi.ackermann@gmail.com', 'beyblade', 30, 75, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('2', 'Eren', 'Jäger', 'eren.jäger@hotmail.de', 'idealist', 30, 3, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('3', 'Mikasa', 'Ackermann', 'mikasa123@hotmail.de', 'redScarf', 30, 99, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('4', 'Annie', 'Leonhart', 'annie.leonhart@gmx.de', 'hiiamannie', 30, 0, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('5', 'Armin', 'Arlert', 'armin.arlert@gmail.de', 'armin_the_strategist', 30, 10, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('6', 'Jean', 'Kirstein', 'jean@hotmail.de', 'jean_the_leader', 30, 55, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('7', 'Erwin', 'Smith', 'erwin.smith@hotmail.de', 'erwin_the_real_leader', 30, 70, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('8', 'Connie', 'Springer', 'connie@hotmail.de', 'loyal_connie', 0, 25, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('9', 'Sasha', 'Braus', 'braus.sasha@gmail.com', 'sasha_loves_meat', 0, 3, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('10', 'Frederick', 'Brooks', 'frederick.brooks@yahoo.com', 'Brooks', 30, 0, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('11', 'Martin', 'Schindler', 'martin.schindler@gmail.com', 'TheWall', 30, 0, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('12', 'Peter', 'Wright', 'peter.wright@gmail.com', 'Snakebite', 30, 0, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('13', 'Rob', 'Cross', 'rob.cross@gmail.com', 'Voltage', 30, 0, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('14', 'Jonny', 'Clayton', 'jonny.clayton@gmail.com', 'TheFerret', 30, 0, '2022-04-13 02:30:00');
INSERT INTO `Person` (person_id, vorname, nachname, mail_adresse, benutzername, urlaubstage, ueberstunden, letzte_aenderung)  
VALUES('15', 'Mensur', 'Suljovic', 'mensur.suljovic@gmail.com', 'TheGentle', 30, 0, '2022-04-13 02:30:00');

-- ------------------------------------------------------------------------------------------------------------pauseperson---------------
-- Projekt Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------pauseperson---------------
-- Projekt Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('1', '1',"Projekt X", 'Daimler','2022-04-19 02:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('2', '1',"Projekt Y", 'Porsche','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('3', '1',"Projekt Z", 'Bosch','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('4', '1',"Projekt W", 'Wilhelma','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('5', '2',"Projekt V", 'Milaneo','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('6', '2',"Projekt U", 'SAP','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('7', '2',"Projekt T", 'Märklin','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('8', '2',"Projekt S", 'Hochschule der Medien','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('9', '3',"Projekt R", 'Kleemann','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('10', '3',"Projekt Q", 'TeamViewer','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('11', '3',"Projekt P", 'EMAG','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('12', '4',"Projekt O", 'Burda','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('13', '4',"Projekt N", 'Stihl','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('14', '4',"Projekt M", 'Apple','2022-04-19 12:33:00');
INSERT INTO `Projekt` (projekt_id, person_id, projektname, auftraggeber, letzte_aenderung)  
VALUES('15', '4',"Projekt L", 'Windows','2022-04-19 12:33:00');



-- ---------------------------------------------------------------------------------------------------------------------------
-- Aktivität Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Aktivitaet` (aktivitaet_id, projekt_id, bezeichnung, dauer, kapazitaet, letzte_aenderung)  
VALUES('1', '1', 'Kriegshammertitan aufhalten', '2022-04-30 14:00:00','120', '2022-04-19 02:33:00');
INSERT INTO `Aktivitaet` (aktivitaet_id, projekt_id, bezeichnung, dauer, kapazitaet, letzte_aenderung)  
VALUES('2', '1', '3D-Manöver-Apparat aufladen', '2022-05-01 14:00:00','100', '2022-04-19 02:33:00');
INSERT INTO `Aktivitaet` (aktivitaet_id, projekt_id, bezeichnung, dauer, kapazitaet, letzte_aenderung)  
VALUES('3', '1', 'Auf Expedition gehen', '2022-05-01 14:00:00','100', '2022-04-19 02:33:00');
INSERT INTO `Aktivitaet` (aktivitaet_id, projekt_id, bezeichnung, dauer, kapazitaet, letzte_aenderung)  
VALUES('4', '2', 'Teile bestellen', '2022-05-01 14:00:00','50', '2022-04-19 02:33:00');
INSERT INTO `Aktivitaet` (aktivitaet_id, projekt_id, bezeichnung, dauer, kapazitaet, letzte_aenderung)  
VALUES('5', '2', 'Teile prüfen', '2022-05-01 14:00:00','150', '2022-04-19 02:33:00');
INSERT INTO `Aktivitaet` (aktivitaet_id, projekt_id, bezeichnung, dauer, kapazitaet, letzte_aenderung)  
VALUES('6', '2', 'beschädigte Teile reklamieren', '2022-05-01 14:00:00','70', '2022-04-19 02:33:00');


-- ---------------------------------------------------------------------------------------------------------------------------
-- Urlaub Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Urlaub` (urlaub_id, person_id, start_datum, end_datum, letzte_aenderung)
VALUES('1', '1', '2022-04-19', '2022-04-25', '2022-04-19 02:33:00');
INSERT INTO `Urlaub` (urlaub_id, person_id, start_datum, end_datum, letzte_aenderung)
VALUES('2', '2', '2022-05-19', '2022-06-25', '2022-04-19 02:33:00');
INSERT INTO `Urlaub` (urlaub_id, person_id, start_datum, end_datum, letzte_aenderung)
VALUES('3', '2', '2022-06-19', '2022-07-25', '2022-04-19 02:33:00');
INSERT INTO `Urlaub` (urlaub_id, person_id, start_datum, end_datum, letzte_aenderung)
VALUES('4', '1', '2022-07-19', '2022-08-25', '2022-04-19 02:33:00');


-- ---------------------------------------------------------------------------------------------------------------------------
-- Mitarbeiter_in_Projekt Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Mitarbeiter_in_Projekt` (person_idd, projekt_id, verkaufte_stunden, letzte_aenderung)  
VALUES('1', '1','150', '2022-04-19 02:33:00');
INSERT INTO `Mitarbeiter_in_Projekt` (person_idd, projekt_id, verkaufte_stunden, letzte_aenderung)  
VALUES('1', '3','180', '2022-04-19 02:33:00');
INSERT INTO `Mitarbeiter_in_Projekt` (person_idd, projekt_id, verkaufte_stunden, letzte_aenderung)  
VALUES('1', '2','180', '2022-04-19 02:33:00');
INSERT INTO `Mitarbeiter_in_Projekt` (person_idd, projekt_id, verkaufte_stunden, letzte_aenderung)  
VALUES('2', '1','180', '2022-04-19 02:33:00');

-- ---------------------------------------------------------------------------------------------------------------------------
-- Zeitintervallbuchung Entitäten erstellen
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id,  gearbeitete_zeit, letzte_aenderung)  
VALUES('1', '1', '1', '1',  1, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit, letzte_aenderung)  
VALUES('2', '1', '1', '3',  10, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id,  gearbeitete_zeit, letzte_aenderung)  
VALUES('3', '1', '1', '1',  100, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit, letzte_aenderung)  
VALUES('4', '1', '1', '1',  100, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id,  gearbeitete_zeit, letzte_aenderung)  
VALUES('5', '2', '1', '2', 100, '2022-04-13 05:30:00');




-- Eren jäger  PROJEKT 1 UND 2
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit, letzte_aenderung)  
VALUES('6', '2', '2', '2', 100, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit, letzte_aenderung)  
VALUES('7', '2', '2', '2', 100, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit, letzte_aenderung)  
VALUES('8', '1', '2', '3',  500, '2022-04-13 05:30:00');
INSERT INTO `Zeitintervallbuchung` (zeit_id, projekt_id, person_id, aktivitaet_id, gearbeitete_zeit, letzte_aenderung)  
VALUES('9', '1', '2', '3',  300, '2022-04-13 05:30:00');



-- --------------------------------------------------------------------------------------------------------------------------
-- verkaufte_stunden_in_aktivitaet Entitäten erstellen
-- --------------------------------------------------------------------------------------------------------------------------
INSERT INTO `Verkaufte_stunden_in_aktivitaet` (aktivitaet_id, person_id, gebuchte_stunden,letzte_aenderung)  
VALUES('1', '1','15', '2022-04-19 02:33:00');
INSERT INTO `Verkaufte_stunden_in_aktivitaet` (aktivitaet_id, person_id, gebuchte_stunden, letzte_aenderung)  
VALUES('2', '1','2500', '2022-04-19 02:33:00');
INSERT INTO `Verkaufte_stunden_in_aktivitaet` (aktivitaet_id, person_id, gebuchte_stunden, letzte_aenderung)  
VALUES('3', '1','10', '2022-04-19 02:33:00');
INSERT INTO `Verkaufte_stunden_in_aktivitaet` (aktivitaet_id, person_id, gebuchte_stunden, letzte_aenderung)  
VALUES('4', '1','250', '2022-04-19 02:33:00');
INSERT INTO `Verkaufte_stunden_in_aktivitaet` (aktivitaet_id, person_id, gebuchte_stunden, letzte_aenderung)  
VALUES('3', '2','2500', '2022-04-19 02:33:00');






-- Verschlüsseln von strings test 
INSERT INTO `Arbeitszeitkonto` (zeit_id, password)  
VALUES('100', aes_encrypt('selam','TEST'));



SELECT Aktivitaet.aktivitaet_id, bezeichnung, projektname FROM Aktivitaet
INNER JOIN Verkaufte_stunden_in_aktivitaet ON Aktivitaet.aktivitaet_id = Verkaufte_stunden_in_aktivitaet.aktivitaet_id 
INNER JOIN Projekt ON Aktivitaet.projekt_id = Projekt.projekt_id
WHERE Verkaufte_stunden_in_aktivitaet.person_id = 1 AND Aktivitaet.projekt_id = 1;

