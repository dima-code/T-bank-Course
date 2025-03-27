import Foundation

class Person {
    let name: String
    var ownedCar: Car?
    
    init(name: String, car: Car? = nil) {
        self.name = name
        self.ownedCar = car
    }
    
    deinit{
        print("Person instance is free")
    }
}

class Car {
    weak var owner: Person? // Используем weak ссылку при объявлении свойства owner класса Car
    
    init(owner: Person? = nil) {
        self.owner = owner
    }
    
    deinit{
        print("Car instance is free")
    }
}

// Реализация с сильной ссылкой
/*

 class Person {
     let name: String
     var ownedCar: Car?
     
     init(name: String, car: Car? = nil) {
         self.name = name
         self.ownedCar = car
     }
     
     deinit{
         print("Person instance is free")
     }
 }

 class Car {
     var owner: Person? // Сильная ссылка, не дает освободить связь из памяти
     
     init(owner: Person? = nil) {
         self.owner = owner
     }
     
     deinit{
         print("Car instance is free")
     }
 }
 */
var person1: Person?
var car1: Car?

person1 = Person(name: "Anatoly")
car1 = Car()

person1?.ownedCar = car1
car1?.owner = person1

print(CFGetRetainCount(person1))
print(CFGetRetainCount(car1))

// Присваиваем экземплярам nil чтобы освободить из памяти
// Иначе deinit не сработает, количество ссылок надо будет смотреть через CFGetRetainCount
// Для проверки с сильными ссылками убираем weak из Car
person1 = nil
car1 = nil


//print(CFGetRetainCount(person1))
//print(CFGetRetainCount(car1))
