class Person {
    let name: String
    var ownedCar: Car?
    
    init(name: String) {
        self.name = name
    }
    deinit{
        print("Person instance is free")
    }
}

class Car {
    weak var owner: Person? // Используем weak ссылку при объявлении свойства owner класса Car
    

    deinit{
        print("Car instance is free")
    }
}

var person1: Person?
var car1: Car?

person1 = Person(name: "Anatoly")
car1 = Car()

person1?.ownedCar = car1
car1?.owner = person1


// Присваиваем экземплярам nil чтобы освободить из памяти
// Иначе deinit не сработает, количество ссылок будет смотреть черезC FGetRetainCount
person1 = nil
car1 = nil


//print(CFGetRetainCount(person1))
//print(CFGetRetainCount(car1))
