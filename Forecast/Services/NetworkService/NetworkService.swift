//
//  NetworkService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(params: [String : String], completion: @escaping (Result<T, Error>) -> Void) {
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
        let appid = "d931fa462f74e60a23984d4b55410584"
        
        var param = ["appid" : appid, "lang" : "ru"]
        
        for i in params {
            param[i.key] = i.value
        }
        
        AF.request(baseUrl, method: .get, parameters: param).responseDecodable(of: T.self) { responce in
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

extension NetworkService: CurrentWeatherNetworkServiceProtocol {
    func fetchWeather(params: [String : String], completion: @escaping (Result<Weather, Error>) -> Void) {
        request(params: params, completion: completion)
    }
}


struct Weather: Decodable {
    let weather: [Description]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Description: Decodable {
    let main: String
    let id: Int
}
