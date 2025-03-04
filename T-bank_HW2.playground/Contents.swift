import UIKit

// *****Задача 1*****

/*
var uniqueWords: Set<String> = [] // Множество уникальных слов
let string1: String = "apple aPPle appLe Apple" // Входная строка

var separatedWords = string1.split(separator: " ") // Делим на слова

for word in separatedWords {
    if !uniqueWords.contains(word.lowercased()) { // Проверка
        uniqueWords.insert(word.lowercased())
//        print(word)
    }
}

print(uniqueWords.count)

*/





// *****Задача 2*****

/*
let string2: String = "(())" // Входная строка
var openingBrackets: Int = 0 // Количество открывающих скобой
var closingBrackets: Int = 0 // Количество закрывающих скобок
var correct: Bool = true

for letter in string2 {
    if letter == "(" {
        openingBrackets += 1
    } else if letter == ")" {
        closingBrackets += 1
    }

    if closingBrackets > openingBrackets {
            correct = false
        break
    }
}

if openingBrackets != closingBrackets{
    correct = false
}

if correct{
    print("Корректная")
} else{
    print("Некорректная")
}

*/


// *****Задача 3*****

/*
 let array3 = ["a", "bb", "b", "cccc"] // Входные данные
 
 var lenghts: Set<Int> = []
 
 for word in array3 { // Находим все длины
 lenghts.insert(word.count)
 }
 
 
 for length in lenghts{ // Выводим элементы каждой из длин
 var resArray: Array<String> = []
 
 for word in array3{
 if word.count == length{
 resArray.append(word)
 }
 
 }
 print("\(length) - \(resArray)")
 }
 
 */

// *****Задача 4*****

/*
// Заменил тип на Double
let dict4: [String:Double?] = ["A": 4, "B": 5, "C": 4] // Входные данные

var studentsSucceed: Double = 0
var pointsSum: Double = 0

for (_, value) in dict4 {
    if let mark = value {
        studentsSucceed += 1
        pointsSum += mark
        
    }
}

if studentsSucceed == 0{
    print("Никто не сдал")
} else{
    print(pointsSum/studentsSucceed)
}
 
*/


// *****Задача 5*****
/*
let array5: [operations] = [.plus(1, 2), .square(2), .minus(100, 50), .division(123, 44), .squareRoot(4)] // Входные данные

enum operations{
    case plus(Int, Int)
    case minus(Int, Int)
    case square(Int)
    case division(Double, Double)
    case squareRoot(Double)
    
    var result: String{ // Перенес логику внуть enum
        switch self{
            case .plus(let a,let b):
                return "Сумма - \(a + b)"
            case .minus(let a,let b):
                return ("Разность - \(a - b)")
            case .square(let a):
                return ("Квадрат - \(a*a)")
            case .division(let a,let b):
                return ("Деление - \(a/b)")
            case .squareRoot(let a):
                return ("Квадратный корень - \(pow(a, 0.5))")
        }
    }
    
}

for operation in array5{
    print(operation.result)
}
*/
