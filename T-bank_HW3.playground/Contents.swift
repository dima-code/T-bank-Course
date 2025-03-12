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
    
    enum Genres: String {
        case fantasty
        case science
        case horror
        case adventure
        case action
        case history
        case fiction
        case novel
        case poems
        case other
    }
}



class Library {
    
    var сatalog = [Book]()
    
    func addBook(_ book: Book) {
        сatalog.append(book)
    }

    func filterBooks(byGenre genre: Book.Genres = .other, byName name: String? = nil) -> [Book] { // Фильтр по жанру и названию
        if let name = name {
            return сatalog.filter{$0.title.lowercased().contains(name.lowercased())} // Фильтр по названию
            
        } else {
            return сatalog.filter{$0.genre == genre} // Фильтр по жанру
        }
    }
}

class User {
    var name: String
    var discount: Double
    var cart: [Book] = []
    enum Sorting {
        case price
        case alphabet
    }
    
    func addToCart(_ book: [Book]) {
        cart += book
    }
    
    func totalPrice()-> Double {
        var sum: Double = 0
        for book in cart{
            sum += book.price
        }
        return sum * ((100 - discount) / 100)
    }
    
    func sortedListOfBooks(sortBy: Sorting) -> [Book] {
        let sortedList: [Book]
        switch sortBy {
            case .alphabet:
                sortedList = cart.sorted{$0.title < $1.title}
            case .price:
                sortedList = cart.sorted{$0.price < $1.price}
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
    Book(
        title: "Гарри Поттер и философский камень",
        author: "Дж.К. Роулинг",
        price: 1000,
        genre: .fiction
    )
)

library.addBook(
    Book(
        title: "Война и мир",
        author: "Лев Толстой",
        price: 850,
        genre: .novel
    )
)
library.addBook(
    Book(
        title: "Стихотворение",
        author: "Владимир Маяковский",
        price: 540,
        genre: .poems
    )
)

let user = User(name: "Алиса", discount: 1.5)
let novelBooks = library.filterBooks(byGenre: .novel)
user.addToCart(novelBooks)
let booksWithName = library.filterBooks(byName: "Гарри")
user.addToCart(booksWithName)

print("Итоговая корзина: \(user.sortedListOfBooks(sortBy: .price))")
print("Цена корзины: \(user.totalPrice())")
