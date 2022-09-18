//
//  NetworkServiceProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(completion: @escaping (Result<T, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}
