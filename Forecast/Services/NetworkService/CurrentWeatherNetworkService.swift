//
//  CurrentWeatherNetworkService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol CurrentWeatherNetworkServiceProtocol {
    func fetchCurrentWeather(params: [String : String], completion: @escaping (Result<Weather, Error>) -> Void)
}
