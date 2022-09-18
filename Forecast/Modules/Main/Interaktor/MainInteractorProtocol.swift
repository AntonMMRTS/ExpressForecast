//
//  MainInteraktorProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterInteractionProtocol! { get }
    
    func getCurrentWeather()
    func fetchCitiesFromDatabase() -> [City]
    func addCityToDatabase(city: City)
    func deleteCityFromDatabase(city: City)
    func checkConection(completion: @escaping (Bool) -> Void)
}
