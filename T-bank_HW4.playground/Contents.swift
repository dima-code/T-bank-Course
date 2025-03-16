import UIKit


// Базовый класс: Персонаж
class GameCharacter {
    var inventory: [Items] = [] // Инвентарь
    var name: String
    var health: Int
    var level: Int
    enum Items: String{
        case magicSword
        case healthPotion
        case magicPoizon
    }
    
    func addItem(_ item: Items) { // Adding item to inventory
        inventory.append(item)
        print("\(item) added to inventory")
    }
    
    func viewInventory() { // View what's in inventory
        let itemNames = inventory.map { $0.rawValue }
        print("Inventory: \(itemNames)")
    }
    
    func takeDamage(amount: Int) { // Получение персонажем урона
        guard isAlive else { // Проверка игрока
            print("\(name) is dead and can not be active")
            return
        }
        
        health -= amount
        if health < 0 {
            health = 0
        }
        
        print("\(amount) damage taken. Health points left: \(health)")
        
    }
    
    func heal(amount: Int) { // Восполнение здоровья
        guard isAlive else { // Проверка игрока
            print("\(name) is dead and can not be active")
            return
        }
        health += amount
        print("\(amount) health restored. Health points left: \(health)")
    }
    
    func levelUp() { // Повышение уровня
        guard isAlive else { // Проверка игрока
            print("\(name) is dead and can not be active")
            return
        }
        level += 1
        print("Leveled up to level \(level)")
    }
    
    init(name: String, health: Int, level: Int) {
        self.name = name
        self.health = health
        self.level = level
    }
    
}


// Расширение для базового класса
extension GameCharacter {
    var isAlive : Bool {
        return health > 0
    }
    
    func printCharacterInfo() { // Информация о персонаже
        print("Name: \(name), Level: \(level), Health: \(health)")
    }
}


// Персонаж: Воин
class Warrior: GameCharacter {
    var strength: Int
    var agility: Int
    
    // Атака воина
    func attack(target: GameCharacter) {
        guard isAlive else { // Проверка игрока
            print("\(name) is dead and can not be active")
            return
        }
        
        let damage = strength + level
        target.takeDamage(amount: damage)
        print("\(name) is attacking \(target.name)")
    }
    
    init(name: String, health: Int, level: Int, strength: Int, agility: Int) {
        self.strength = strength
        self.agility = agility
        super.init(name: name, health: health, level: level)
    }
}

// Персонаж: Маг
class Mage: GameCharacter, Flyable {
    var flightSpeed: Int
    var magicPower: Int
    enum Spells {
        case abraCadabra
        case fireball
        case lightning
    }
    
    func fly() {
        print("Flying to take some supplies...Poizon is here!")
        inventory.append(.magicPoizon)
    }
    

    
    func castSpell(spellName: Spells, target: GameCharacter) {
        guard isAlive else { // Проверка игрока
            print("\(name) is dead and can not be active")
            return
        }
        
        let damage = magicPower + level
        target.takeDamage(amount: damage)
        
        print("\(name) is attacking \(target) with \(spellName)")
    }
    
    init(name: String, health: Int, level: Int, flightSpeed: Int, magicPower: Int) {
        self.flightSpeed = flightSpeed
        self.magicPower = magicPower
        super.init(name: name, health: health, level: level)
    }
    
}


// Летающий
protocol Flyable {
    var flightSpeed: Int {get}
    
    func fly()
}


// Создаем по 1 экземпяру
var warrior = Warrior(name: "SpiderMan", health: 100, level: 450, strength: 708, agility: 40)
var mage = Mage(name: "DR.Strange", health: 1000, level: 55, flightSpeed: 90, magicPower: 99)


// Повышаем уровни
warrior.levelUp()
mage.levelUp()

// Хиллим персонажей
mage.heal(amount: 10)
warrior.heal(amount: 11)

// Воин аттакует мага
warrior.attack(target: mage)

// Проверка неактивности
mage.heal(amount: 30)

// Воин забирает лут
warrior.addItem(.magicPoizon)
warrior.addItem(.healthPotion)
warrior.viewInventory()

// Вывод информации
mage.printCharacterInfo()
warrior.printCharacterInfo()
