//
//  NetworkServiceProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(params: [String : String], completion: @escaping (Result<T, Error>) -> Void)
}
