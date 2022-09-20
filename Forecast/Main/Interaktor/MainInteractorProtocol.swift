//
//  MainInteraktorProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterInteractionProtocol! { get }
    
    func fetchCurrentWeather()
    func fetchCitiesFromDatabase() -> [Weather]
    func addCityToDatabase(city: Weather)
    func deleteCityFromDatabase(city: Weather)
}
