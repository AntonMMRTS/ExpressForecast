//
//  DatabaseServiceProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 20.09.2022.
//

import Foundation

protocol DatabaseServiceProtocol {
    
    func addNewCity(city: Weather)
    
    func updateCityStart()
    
    func updateCityEnd()
    
    func fetchCities() -> [Weather]
    
    func deleteCity(city: Weather)
    
    func deleteAll()
}
