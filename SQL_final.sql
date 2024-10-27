-- 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”

DROP DATABASE IF EXISTS Pet_Friends;
CREATE DATABASE Pet_Friends;
USE Pet_Friends;

-- 8. Создать таблицы с иерархией из диаграммы в БД

CREATE TABLE Dogs (
	dog_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

-- 9. Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения

INSERT INTO Dogs (name, command, date_of_birth) VALUES
	('Kenji', 'sit', '03.09.2016'),
	('Sharik', 'lay down', '31.12.2023');

CREATE TABLE Cats (
	cat_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

INSERT INTO Cats (name, command, date_of_birth) VALUES
	('Varya', 'meow', '20.12.2020'),
	('Vaska', 'shh', '07.11.2022');

CREATE TABLE Humsters (
	humster_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

INSERT INTO Humsters (name, command, date_of_birth) VALUES
	('Homa', 'eat', '11.12.2023'),
	('Grizlyk', 'sleep', '11.12.2022');

CREATE TABLE Horses (
	horse_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

INSERT INTO Horses (name, command, date_of_birth) VALUES
	('Gera', 'run', '01.02.2023'),
	('Buffin', 'jump', '31.10.2020');

CREATE TABLE Camels (
	camel_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

INSERT INTO Camels (name, command, date_of_birth) VALUES
	('Samuel', 'chew', '15.07.2015'),
	('Ikar', 'spit', '05.06.2021');
	
CREATE TABLE Donkeys (
	donkey_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

INSERT INTO Donkeys (name, command, date_of_birth) VALUES
	('Mark', 'neigh', '20.12.2016'),
	('Sofia', 'stand', '27.05.2021');

CREATE TABLE Pet_Animals (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    dog_id INT,
    cat_id INT,
    humster_id INT,
    FOREIGN KEY (dog_id) REFERENCES Dogs(dog_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES Cats(cat_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (humster_id) REFERENCES Humsters(humster_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Pack_Animals (
    pack_id INT AUTO_INCREMENT PRIMARY KEY,
    horse_id INT,
    camel_id INT,
    donkey_id INT,
    FOREIGN KEY (horse_id) REFERENCES Horses(horse_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (camel_id) REFERENCES Camels(camel_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (donkey_id) REFERENCES Donkeys(donkey_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Man_Friends (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT,
    pack_id INT,
    FOREIGN KEY (pet_id) REFERENCES Pet_Animals(pet_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (pack_id) REFERENCES Pack_Animals(pack_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

DELETE FROM Camels;
CREATE TABLE Ungulates (
	ungulates_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

INSERT INTO Ungulates (name, command, date_of_birth)
SELECT name, command, date_of_birth FROM Horses;

INSERT INTO Ungulates (name, command, date_of_birth)
SELECT name, command, date_of_birth FROM Donkeys;

-- 11.Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице

CREATE TABLE Young_Animals AS
SELECT 
    name,
    command,
    date_of_birth,
    TIMESTAMPDIFF(MONTH, date_of_birth, CURDATE()) AS age_in_months
FROM (
    SELECT name, command, date_of_birth FROM Dogs
    UNION ALL
    SELECT name, command, date_of_birth FROM Cats
    UNION ALL
    SELECT name, command, date_of_birth FROM Humsters
    UNION ALL
    SELECT name, command, date_of_birth FROM Horses
    UNION ALL
    SELECT name, command, date_of_birth FROM Donkeys
) AS All_Animals
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 1 AND 3;

-- 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

CREATE TABLE All_Animals (
    id_all INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    command VARCHAR(100),
    date_of_birth DATE,
    animal_type VARCHAR(50)
);

INSERT INTO All_Animals (name, command, date_of_birth, animal_type)
SELECT name, command, date_of_birth, 'Dog' AS animal_type FROM Dogs
UNION ALL
SELECT name, command, date_of_birth, 'Cat' AS animal_type FROM Cats
UNION ALL
SELECT name, command, date_of_birth, 'Humster' AS animal_type FROM Humsters
UNION ALL
SELECT name, command, date_of_birth, 'Horse' AS animal_type FROM Horses
UNION ALL
SELECT name, command, date_of_birth, 'Donkey' AS animal_type FROM Donkeys;



