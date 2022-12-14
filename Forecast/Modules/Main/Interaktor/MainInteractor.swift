//
//  MainInteractor.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import CoreLocation

final class MainInteractor: MainInteractorProtocol {
    // MARK: - Dependency Injection
    private var currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol!
    private var locationService: LocationServiceProtocol!
    private var databaseService: DatabaseServiceProtocol!
    private var reachabilityService: ReachabilityServiceProtocol!
    
    weak var presenter: MainPresenterInteractionProtocol!
    
    init(currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol,
         locationService: LocationServiceProtocol,
         databaseService: DatabaseServiceProtocol!,
         reachabilityService: ReachabilityServiceProtocol) {
        self.currentWeatherNetworkService = currentWeatherNetworkService
        self.locationService = locationService
        self.databaseService = databaseService
        self.reachabilityService = reachabilityService
    }
    
    // MARK: - MainInteractorProtocol Methods
    func getCurrentWeather() {
        guard locationService.status != .notDetermined else {
            locationService.checkPermission()
            return
        }
        guard locationService.status == .authorizedAlways
                || locationService.status == .authorizedWhenInUse else { return }
        
        guard let location = locationService.location else { return }
        fetchCurrentWeather(location: location)
    }
    
    func fetchCurrentWeather(location: CLLocation) {
        let param = [ "lat" : "\(location.coordinate.latitude)",
                      "lon" : "\(location.coordinate.longitude)" ]
        
        currentWeatherNetworkService.fetchWeather(params: param) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.succeccedFetchCurrentWeather(response: response)
            case .failure(let error):
                self?.presenter.failureRequest()
            }
        }
    }
    
    func fetchCitiesFromDatabase() -> [City] {
        databaseService.fetchCities()
    }
    
    func addCityToDatabase(city: City) {
        databaseService.addNewCity(city: city)
    }
    
    func deleteCityFromDatabase(city: City) {
        databaseService.deleteCity(city: city)
    }
    
    func checkConection(completion: @escaping (Bool) -> Void) {
        reachabilityService.checkConection(completion: completion)
    }
}

// MARK: - LocationDelegate
extension MainInteractor: LocationDelegate {
    func updateLocation(location: CLLocation) {
        fetchCurrentWeather(location: location)
    }
}
