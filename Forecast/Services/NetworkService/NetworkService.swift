//
//  NetworkService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import Alamofire
import RealmSwift

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


class Weather: Object, Decodable {
    var weather = List<Description>()
    @objc dynamic var main: Main? = Main()
    @objc dynamic var name: String = ""
}

class Main: Object, Decodable {
    @objc dynamic var temp: Double = 0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
}

class Description: Object, Decodable {
    @objc dynamic var main: String = ""
    @objc dynamic var id: Int = 0
}

extension List : Decodable where Element : Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let element = try container.decode(Element.self)
            self.append(element)
        }
    } }
