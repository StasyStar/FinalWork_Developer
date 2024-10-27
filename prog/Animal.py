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


class Cat(PetAnimal):
    def __init__(self, name):
        super().__init__(name)


class Hamster(PetAnimal):
    def __init__(self, name):
        super().__init__(name)


class Horse(PackAnimal):
    def __init__(self, name):
        super().__init__(name)


class Camel(PackAnimal):
    def __init__(self, name):
        super().__init__(name)


class Donkey(PackAnimal):
    def __init__(self, name):
        super().__init__(name)
