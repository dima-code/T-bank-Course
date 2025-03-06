import UIKit

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
