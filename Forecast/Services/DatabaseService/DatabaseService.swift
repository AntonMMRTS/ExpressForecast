//
//  DatabaseService.swift
//  Forecast
//
//  Created by Антон Усов on 20.09.2022.
//

import Foundation
import RealmSwift

final class DatabaseService: DatabaseServiceProtocol {
    
    fileprivate lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func addNewCity(city: City) {
        let newCity = City()
        
        newCity.name = city.name
        newCity.main = city.main
        newCity.weather = city.weather
        
        try! realm.write {
            realm.add(newCity)
        }
    }
    
    func fetchCities() -> [City] {
        let models = realm.objects(City.self)
        return Array(models)
    }
    
    func deleteCity(city: City) {
        try? realm.write {
            realm.delete(city)
        }
    }
}
