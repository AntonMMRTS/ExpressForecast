//
//  CurrentWeatherNetworkService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol CurrentWeatherNetworkServiceProtocol {
    func fetchWeather(params: [String : String], completion: @escaping (Result<City, Error>) -> Void)
}
