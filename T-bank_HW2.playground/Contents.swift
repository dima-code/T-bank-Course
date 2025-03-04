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
    } else{
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
 
let dict4: [String:Int?] = ["A": 4, "B": 4, "C": 4] // Входные данные

var studentsSucceed: Int = 0
var pointsSum: Int = 0

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
enum operations{
    case plus(Int, Int)
    case minus(Int, Int)
    case square(Int)
    case division(Double, Double)
    case squareRoot(Double)
}

let array5 = [operations.plus(1, 2), operations.square(2), operations.minus(100, 50), operations.division(123, 44), operations.squareRoot(4)] // Входные данные

for operation in array5{
    switch operation{
    case .plus(let a,let b):
        print("Сумма - \(a + b)")
    case .minus(let a,let b):
        print("Разность - \(a - b)")
    case .square(let a):
        print("Квадрат - \(a*a)")
    case .division(let a,let b):
        print("Деление - \(a/b)")
    case .squareRoot(let a):
        print("Квадратный корень - \(pow(a, 0.5))")
    }
}
*/
