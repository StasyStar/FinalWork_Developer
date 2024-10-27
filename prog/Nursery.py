from final_work.prog.Animal import Dog, Cat, Horse, Camel


class Nursery:
    def __init__(self):
        self.pets = []

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

    def show_pets(self):
        for pet in self.pets:
            info = pet.get_info()
            print(f"Name: {info['name']}, Commands: {', '.join(info['commands'])}")

    def teach_command(self, name, command):
        for pet in self.pets:
            if pet.get_info()['name'] == name:
                pet.add_command(command)
                print(f"Command '{command}' added to {name}.")
                return
        print(f"No pet found with the name '{name}'.")