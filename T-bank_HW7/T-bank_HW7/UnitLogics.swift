// База с карточками товаров

protocol Addable {
    var brandName: String { get }
    var itemName: String { get }
    var imageName: String { get }
    var price: String { get }
    var oldPrice: String? { get }
    var itemId: Int { get }
}


struct Item: Addable {
    var brandName: String
    var itemName: String
    var imageName: String
    var price: String
    var oldPrice: String?
    var itemId: Int
}

var itemList: [Item] = [
    Item(brandName: "New Balance",
         itemName: "New Balance 1906R",
         imageName: "NB",
         price: "22 990",
         itemId: 0),
    
    Item(brandName: "Adidas",
         itemName: "Adidas Forum Low Classic",
         imageName: "AD",
         price: "11 200",
         itemId: 1),
    
    Item(brandName: "Nike",
         itemName: "Nike Dunk Low Retro Grey Fog",
         imageName: "NK",
         price: "14 990",
         itemId: 2),
    
    Item(brandName: "Puma",
         itemName: "PUMA 180 GREEN",
         imageName: "PM",
         price: "5 490",
         itemId: 3),
    
    Item(brandName: "Asics",
         itemName: "Asics Gel-Kayano 14",
         imageName: "AS",
         price: "20 990",
         itemId: 4)
]

