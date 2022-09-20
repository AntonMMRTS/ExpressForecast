//
//  MainInteractor.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import CoreLocation

class MainInteractor: MainInteractorProtocol {
    // MARK: - Dependency Injection
    private var currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol!
    private var locationService: LocationServiceProtocol!
    private var databaseService: DatabaseServiceProtocol!
    
    weak var presenter: MainPresenterInteractionProtocol!
    
    init(currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol,
         locationService: LocationServiceProtocol,
         databaseService: DatabaseServiceProtocol!) {
        self.currentWeatherNetworkService = currentWeatherNetworkService
        self.locationService = locationService
        self.databaseService = databaseService
    }
    
    
    func fetchCurrentWeather() {
        guard locationService.isPermission else {
            locationService.checkPermission()
            return
        }
        
        guard let location = locationService.location else {
            return
        }
        
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
    
    func fetchCitiesFromDatabase() -> [Weather] {
        databaseService.fetchCities()
    }
}

extension MainInteractor: LocationDelegate {
    func updateLocation(location: CLLocation) {
        fetchCurrentWeather(location: location)
    }
}
