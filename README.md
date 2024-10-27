# Итоговая контрольная работа к блоку Разработчик
## Информация о проекте
Необходимо организовать систему учета для питомника в котором живут
домашние и вьючные животные.

### Блок Linux
1. Используя команду cat в терминале операционной системы Linux, создать
два файла Домашние животные (заполнив файл собаками, кошками,
хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и
ослы), а затем объединить их. Просмотреть содержимое созданного файла.
Переименовать файл, дав ему новое имя (Друзья человека).
```commandline
cat > Домашние_животные
cat > Вьючные_животные
cat Домашние_животные Вьючные_животные > Друзья_человека
```
2. Создать директорию, переместить файл туда.
```commandline
mkdir final_work
mv Друзья_человека final_work/
```
3. Подключить дополнительный репозиторий MySQL. Установить любой пакет
из этого репозитория.
```commandline
sudo apt update
sudo apt install mysql-server
```
4. Установить и удалить deb-пакет с помощью dpkg.
```commandline
curl -O http://ports.ubuntu.com/pool/universe/c/changeme/changeme_1.2.3-3_all.deb
sudo dpkg -i changeme_1.2.3-3_all.deb
sudo dpkg -r changeme
```
5. Выложить историю команд в терминале ubuntu

Решение c выводом команд терминала представлено в файле Linux_final.txt

### Блок SQL
6. Нарисовать диаграмму, в которой есть класс родительский класс, домашние
животные и вьючные животные, в составы которых в случае домашних
животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные
войдут: Лошади, верблюды и ослы).
- Диаграммы представлены в файлах: diagram_manual.png и diagram_dbeaver.png.
SQL-скрипт с запросами для решения поставленных задач
7. В подключенном MySQL репозитории создать базу данных “Друзья
человека”
```
DROP DATABASE IF EXISTS Pet_Friends;
CREATE DATABASE Pet_Friends;
USE Pet_Friends;
```
8. Создать таблицы с иерархией из диаграммы в БД
```commandline
CREATE TABLE Dogs (
	dog_id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	command VARCHAR(100),
	date_of_birth DATE
);

CREATE TABLE Pet_Animals (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    dog_id INT,
    cat_id INT,
    humster_id INT,
    FOREIGN KEY (dog_id) REFERENCES Dogs(dog_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES Cats(cat_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (humster_id) REFERENCES Humsters(humster_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Man_Friends (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT,
    pack_id INT,
    FOREIGN KEY (pet_id) REFERENCES Pet_Animals(pet_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (pack_id) REFERENCES Pack_Animals(pack_id) ON UPDATE CASCADE ON DELETE CASCADE
);
```
9. Заполнить низкоуровневые таблицы именами(животных), командами
которые они выполняют и датами рождения
```commandline
INSERT INTO Dogs (name, command, date_of_birth) VALUES
	('Kenji', 'sit', '03.09.2016'),
	('Sharik', 'lay down', '31.12.2023');
```
10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу. 
```commandline
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
```
11. Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице
```commandline
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
```
12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
прошлую принадлежность к старым таблицам.
```commandline
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
```
## Блок код
13.Создать класс с Инкапсуляцией методов и наследованием по диаграмме.
```commandline
class Animal:
    def __init__(self, name, commands=None):
        self.__name = name
        self.__commands = commands if commands else []

    def get_info(self):
        return {
            'name': self.__name,
            'commands': self.__commands
        }

    def add_command(self, command):
        self.__commands.append(command)

    def get_commands(self):
        return self.__commands


class PetAnimal(Animal):
    def __init__(self, name):
        super().__init__(name)


class PackAnimal(Animal):
    def __init__(self, name):
        super().__init__(name)


class Dog(PetAnimal):
    def __init__(self, name):
        super().__init__(name)
```
14. Написать программу, имитирующую работу реестра домашних животных.
В программе должен быть реализован следующий функционал:
```commandline
class Nursery:
    def __init__(self):
        self.pets = []
```
- Завести новое животное 
- определять животное в правильный класс 
```commandline
    def add_pet(self, animal_type, name):
        if animal_type == 'Dog':
            pet = Dog(name)
        elif animal_type == 'Cat':
            pet = Cat(name)
        elif animal_type == 'Horse':
            pet = Horse(name)
        elif animal_type == 'Camel':
            pet = Camel(name)
        else:
            print("Unknown animal type!")
            return

        self.pets.append(pet)
        print(f"{animal_type} '{name}' added to the registry.")
```
- увидеть список команд, которое выполняет животное 
```commandline
    def show_pets(self):
        for pet in self.pets:
            info = pet.get_info()
            print(f"Name: {info['name']}, Commands: {', '.join(info['commands'])}")
```
- обучить животное новым командам 
```commandline
    def teach_command(self, name, command):
        for pet in self.pets:
            if pet.get_info()['name'] == name:
                pet.add_command(command)
                print(f"Command '{command}' added to {name}.")
                return
        print(f"No pet found with the name '{name}'.")
```
- Реализовать навигацию по меню
```commandline
def main():
    nursery1 = Nursery()

    while True:
        print('\n1. Add new animal to the nursery')
        print('2. Show all animals')
        print('3. Teach new command')
        print('0. Quit')
        choice = input("Choose option: ")

        if choice == '1':
            animal_type = input('Enter the animal type(Dog, Cat, Hamster, Horse, Camel, Donkey): ')
            name = input('Enter the name of animal: ')

            with Counter() as counter:
                nursery1.add_pet(animal_type.capitalize(), name)
                counter.add()

        elif choice == '2':
            nursery1.show_pets()

        elif choice == '3':
            name = input('Enter the name of animal you want to teach: ')
            command = input('Enter the new command: ')
            nursery1.teach_command(name, command)

        elif choice == '0':
            print('Thank you for using out app. Good bye!')
            break

        else:
            print('Choose one of the options')
```
15.Создайте класс Счетчик, у которого есть метод add(), увеличивающий̆
значение внутренней̆int переменной̆на 1 при нажатие “Завести новое
животное” Сделайте так, чтобы с объектом такого типа можно было работать в
блоке try-with-resources. Нужно бросить исключение, если работа с объектом
типа счетчик была не в ресурсном try и/или ресурс остался открыт. Значение
считать в ресурсе try, если при заведения животного заполнены все поля
```commandline
class Counter:
    def __init__(self):
        self.count = 0
        self.is_open = True

    def add(self):
        if not self.is_open:
            raise Exception("Counter is not open.")
        self.count += 1

    def close(self):
        self.is_open = False

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()
        if self.is_open:
            raise Exception("Counter was not used in a proper context.")
```