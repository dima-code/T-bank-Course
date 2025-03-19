import Foundation

// Протокол предметов
protocol Item {
    var name: String { get }
    func used(by character: GameCharacter)
}

// Лечебное зелье
class HealthPotionItem: Item {
    let name: String = "Health Potion"
    
    func used(by character: GameCharacter) {
        print("\(character.name) drinks \(name) and restores health.")
        character.heal(amount: 20)
    }
}

// Яд (Magic Poison)
class MagicPoisonItem: Item {
    var name: String = "Magic Poison"

    func used(by character: GameCharacter) {
        print("\(character.name) used \(name) and took damage!")
        character.takeDamage(amount: 15)
    }
}

protocol Healable {
    func heal(amount: Int)
}

protocol Damagable {
    func takeDamage(amount: Int)
}

// Базовый класс: Персонаж
class GameCharacter: Healable, Damagable {
    var inventory: [Item] = [] // Инвентарь
    var name: String
    var health: Int
    var level: Int

    func addItem(_ item: Item) { // Добавление предмета в инвентарь
        inventory.append(item)
        print("\(item.name) added to inventory.")
    }
    
    func useItem(_ item: Item) {
        item.used(by: self)
    }

    func viewInventory() { // Просмотр инвентаря
        let itemNames = inventory.map { $0.name }
        print("Inventory: \(itemNames)")
    }
    
    func takeDamage(amount: Int) { // Получение урона
        guard isAlive else {
            print("\(name) is dead and cannot be active.")
            return
        }
        
        health -= amount
        if health < 0 { health = 0 }
        
        print("\(amount) damage taken. Health points left: \(health)")
    }
    
    func heal(amount: Int) { // Лечение
        guard isAlive else {
            print("\(name) is dead and cannot be active.")
            return
        }
        health += amount
        print("\(amount) health restored. Health points left: \(health)")
    }
    
    func levelUp() { // Повышение уровня
        guard isAlive else {
            print("\(name) is dead and cannot be active.")
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
    var isAlive: Bool {
        return health > 0
    }
    
    func printCharacterInfo() {
        print("Name: \(name), Level: \(level), Health: \(health)")
    }
}

// Персонаж: Воин
class Warrior: GameCharacter {
    var strength: Int
    var agility: Int
    
    // Атака воина
    func attack(target: GameCharacter) {
        guard isAlive else {
            print("\(name) is dead and cannot be active.")
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
    
    enum Spells: Int {
        case abraCadabra = 90
        case fireball = 80
        case lightning = 50
    }
    
    enum Items: CaseIterable {
        case healthPotion, magicPoison

        func availableItems() -> Item {
            switch self {
            case .healthPotion:
                return HealthPotionItem()
            case .magicPoison:
                return MagicPoisonItem()
            }
        }
    }

    func fly() {
        if let randomItem = Items.allCases.randomElement() {
            let newItem = randomItem.availableItems()
            addItem(newItem)
            print("\(name) flew and found a random item: \(newItem.name)!")
        } else {
            print("\(name) flew but found nothing.")
        }
    }
    
    func castSpell(spellName: Spells, target: GameCharacter) {
        guard isAlive else {
            print("\(name) is dead and cannot cast spells!")
            return
        }
        
        let damage = spellName.rawValue + level + magicPower
        target.takeDamage(amount: damage)
        print("\(name) casts \(spellName) on \(target.name) for \(damage) damage!")
    }
    
    init(name: String, health: Int, level: Int, flightSpeed: Int, magicPower: Int) {
        self.flightSpeed = flightSpeed
        self.magicPower = magicPower
        super.init(name: name, health: health, level: level)
    }
}

// Протокол для летающих персонажей
protocol Flyable {
    var flightSpeed: Int { get }
    func fly()
}

// Тестирование системы

// Создаем персонажей
var warrior = Warrior(name: "SpiderMan", health: 100, level: 450, strength: 708, agility: 40)
var mage = Mage(name: "Dr. Strange", health: 10000, level: 55, flightSpeed: 90, magicPower: 99)

// Создаем предметы
let magicPoison = MagicPoisonItem()
let healthPotion = HealthPotionItem()

// Добавляем предметы в инвентарь
warrior.addItem(magicPoison)
warrior.addItem(healthPotion)
mage.addItem(healthPotion)

// Выводим инвентарь
warrior.viewInventory()
mage.viewInventory()

// Маг летает и находит случайный предмет
mage.fly()
mage.viewInventory()

// Воин использует яд
warrior.useItem(magicPoison)

// Маг использует зелье
mage.useItem(healthPotion)

// Воин атакует мага
warrior.attack(target: mage)

// Маг кастует заклинание
mage.castSpell(spellName: .fireball, target: warrior)

// Проверяем информацию о персонажах
warrior.printCharacterInfo()
mage.printCharacterInfo()
