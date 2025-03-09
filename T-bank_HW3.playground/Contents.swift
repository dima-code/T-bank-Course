import UIKit


// Условие задачи
/*
 #Создадим систему, которая позволит нам хранить информацию о книгах и выполнять действия с ними.


 1) Создайте структуру книги, которая позволит хранить в себе: Название, Автора, Цену, Жанр (сделайте количество жанров ограниченным используя перечисление).


 2) Создайте класс библиотеки. В нем мы будем хранить книги.

 Добавьте методы:
     1. Добавление книги.
     2. Фильтрация по жанру.
     3. Фильтрация по имени.


 3) Создайте класс пользователя. У него будет имя, скидка в магазине и корзина с книгами.

 Добавьте методы:
     1. Добавление книг в корзину.
     2. Подсчет общей стоимости книг в корзине с учетом скидки пользователя.
     3. Вывод корзины в отсортированном порядке (сделайте различные варианты сортировки по алфавиту/по цене, используя один метод).
 
 */

struct Book {
    let title: String
    let author: String
    let price: Double
    let genre: Genres
    
    enum Genres{
        case fantasty
        case science
        case horror
        case adventure
        case action
        case history
        case fiction
        case novel
        case poems
        case any
    }
}



class Library{
    
    var сatalog: [Book] = []
    
    func addBook(bookToAdd: Book) {
        сatalog.append(bookToAdd)
    }

    func filterBooks(by: Book.Genres = .any, byName: String? = nil) -> [Book]{ // Фильтр по жанру и названию
        if let name = byName{
            return (сatalog.filter{$0.title.lowercased().contains(name.lowercased())})

        } else{
            return (сatalog.filter{$0.genre == by})
        }
    }
}

class User{
    var name: String
    var discount: Double
    var cart: [Book] = []
    enum sorting{
        case price
        case alphabet
    }
    
    func addToCart(bookToAdd: [Book]){
        cart += bookToAdd
    }
    
    func totalPrice()-> Double{
        var sum: Double = 0
        for book in cart{
            sum += book.price
        }
        return sum * ((100 - discount) / 100)
    }
    
    func sortedListOfBooks(by: sorting) -> [Book]{
        let sortedList: [Book]
        switch by {
        case .alphabet:
            sortedList = cart.sorted{ $0.title < $1.title }
        case .price:
            sortedList = cart.sorted{ $0.price < $1.price}
        }
        return sortedList
    }
    
    init(name: String, discount: Double) {
        self.name = name
        self.discount = discount
    }
}



// Блок с проверкой


let library = Library()
library.addBook(
    bookToAdd: Book(
        title: "Гарри Поттер и философский камень",
        author: "Дж.К. Роулинг",
        price: 1000,
        genre: .fiction
    )
)

library.addBook(
    bookToAdd: Book(
        title: "Война и мир",
        author: "Лев Толстой",
        price: 850,
        genre: .novel
    )
)
library.addBook(
    bookToAdd: Book(
        title: "Стихотворение",
        author: "Владимир Маяковский",
        price: 540,
        genre: .poems
    )
)

let user = User(name: "Алиса", discount: 1.5)
let novelBooks = library.filterBooks(by: .novel)
user.addToCart(bookToAdd: novelBooks)
let booksWithName = library.filterBooks(byName: "Гарри")
user.addToCart(bookToAdd: booksWithName)

print("Итоговая корзина: \(user.sortedListOfBooks(by: .price))")
print("Цена корзины: \(user.totalPrice())")
