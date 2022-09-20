//
//  DatabaseService.swift
//  Forecast
//
//  Created by Антон Усов on 20.09.2022.
//

import Foundation
import RealmSwift

class DatabaseService: DatabaseServiceProtocol {
    
    fileprivate lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func addNewCity(city: Weather) {
        let newCity = Weather()
        
        newCity.name = city.name
        newCity.main = city.main
        newCity.weather = city.weather
        
        try! realm.write {
            realm.add(newCity)
        }
    }
    
    func updateCityStart() {
        realm.beginWrite()
    }
    
    func updateCityEnd() {
        try? realm.commitWrite()
    }
    
    func fetchCities() -> [Weather] {
        let models = realm.objects(Weather.self)
        return Array(models)
    }
    
    func deleteCity(city: Weather) {
        try? realm.write {
            realm.delete(city)
        }
    }
    
    func deleteAll() {
        realm.deleteAll()
    }
}
