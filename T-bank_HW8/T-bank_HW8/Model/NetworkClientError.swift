//
//  NetworkClientError.swift
//  T-bank_HW8
//
//  Created by Dmitrii Eselidze on 15.04.2025.
//

import Foundation

enum NetworkClientError: Error {
/// Неверный URL
    case invalidURL
/// Ошибка сериализации данных
    case encodingError(Error)
/// Ошибка сети, обычно из "NSURLErrorDomain
    case networkError(Error)
/// Ошибка HTTP (status code 4xx, 5xx)
    case httpError(Int)
/// Ошибка декодирования
    case decodingError(Error)
}
