//
//  NetworkService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import Alamofire

final class NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(parameters: [String : String], completion: @escaping (Result<T, Error>) -> Void) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
        let appid = "d931fa462f74e60a23984d4b55410584"
        
        var params = ["appid" : appid, "lang" : "ru"]
        
        for param in parameters {
            params[param.key] = param.value
        }
        
        AF.request(baseUrl, method: .get, parameters: params).responseDecodable(of: T.self) { responce in
            switch responce.result {
            case .success(let responce):
                completion(.success(responce))
                print(responce)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - CurrentWeatherNetworkServiceProtocol
extension NetworkService: CurrentWeatherNetworkServiceProtocol {
    func fetchWeather(params: [String : String], completion: @escaping (Result<City, Error>) -> Void) {
        request(parameters: params, completion: completion)
    }
}
