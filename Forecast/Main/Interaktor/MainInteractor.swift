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
    
    weak var presenter: MainPresenterInteractionProtocol!
    
    init(currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol,
         locationService: LocationServiceProtocol) {
        self.currentWeatherNetworkService = currentWeatherNetworkService
        self.locationService = locationService
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
        
        currentWeatherNetworkService.fetchCurrentWeather(params: param) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainInteractor: LocationDelegate {
    func updateLocation(location: CLLocation) {
        fetchCurrentWeather(location: location)
    }
}
