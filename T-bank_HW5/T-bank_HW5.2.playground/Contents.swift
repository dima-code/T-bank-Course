class  Animal {
    func speak() {}
}


class  Dog: Animal {
    override func speak() {
        print("Woof!")
    }
}

class Cat: Animal {
    override func speak() {
        print("Meow!")
    }
}

var cat1 = Cat()
var dog1 = Dog()
var dog2 = Dog()


var animals : [Animal] = []

animals.append(cat1)
animals.append(dog1)
animals.append(dog2)

for animal in animals {
    animal.speak()
    
}





