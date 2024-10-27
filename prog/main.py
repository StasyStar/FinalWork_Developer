from final_work.prog.Counter import Counter
from final_work.prog.Nursery import Nursery


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


if __name__ == '__main__':
    main()
