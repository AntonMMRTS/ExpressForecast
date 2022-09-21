//
//  DatabaseServiceProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 20.09.2022.
//

import Foundation

protocol DatabaseServiceProtocol {
    func addNewCity(city: City)
    func fetchCities() -> [City]
    func deleteCity(city: City)
}
