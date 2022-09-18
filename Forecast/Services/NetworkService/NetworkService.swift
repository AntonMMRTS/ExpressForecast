//
//  NetworkService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func request<T: Decodable>(completion: @escaping (Result<T, NetworkError>) -> Void) {
//        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=London&appid=d931fa462f74e60a23984d4b55410584")!
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=d931fa462f74e60a23984d4b55410584")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let albums = try JSONDecoder().decode(T.self, from: data)
                completion(.success(albums))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

extension NetworkService: CurrentWeatherNetworkServiceProtocol {
    func fetchCurrentWeather(completion: @escaping (Result<Weather, NetworkError>) -> Void) {
        request(completion: completion)
    }
}


struct Weather: Decodable {
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}
