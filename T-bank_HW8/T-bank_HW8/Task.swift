//
//  Task.swift
//  T-bank_HW8
//
//  Created by Dmitrii Eselidze on 16.04.2025.
//
//

///Описание
///1. Получить список изображений с API:
///https://fakestoreapi.com/products
/// Этот API возвращает массив объектов в формате JSON, каждый объект содержит:
///
//{
//  "id": 1,
//  "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
//  "price": 109.95,
//  "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
//  "category": "men's clothing",
//  "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//  "rating": {
//    "rate": 3.9,
//    "count": 120
//  }
//}
//title — название товара
//image — прямая ссылка на картинку
//Эти данные необходимо распарсить с помощью Decodable
///
///2. Показать полноэкранный спиннер (ActivityIndicator), пока загружается JSON.
///
///3. После получения списка:
    ///начать загружать все изображения
    ///каждое изображение — через URLSession + URLSessionDataDelegate
    ///отображать общий прогресс загрузки всех изображений
///
///4. Отображение списка в UITableView :
    ///миниатюра изображения + название товара
    ///можно использовать UITableViewCell с contentConfiguration
///
///5. Наверху таблицы — текст или прогресс-бар:
    ///Загружено X из Y или Прогресс: 63%
///
///Как считать прогресс
    ///Все изображения считаются одинакового размера
    ///Прогресс можно считать как:
        ///общий прогресс = сумма всех прогрессов / общее количество изображений
///
///Обязательные требования
    ///Архитектура MVP
    ///URLSession + URLSessionDataDelegate
    ///UITableView
    ///Decodable для парсинга JSON
    ///Обязательный ActivityIndicator на загрузке списка
