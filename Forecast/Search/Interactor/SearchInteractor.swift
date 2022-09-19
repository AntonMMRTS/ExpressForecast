//
//  SearchInteractor.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

class SearchInteractor: SearchInteractorProtocol {
    // MARK: - Dependency Injection
    private var currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol!
    
    weak var presenter: SearchPresenterInteractionProtocol!
    
    init(currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol) {
        self.currentWeatherNetworkService = currentWeatherNetworkService
    }
    
//    func fetchCurrentWeather(location: CLLocation) {
//        let param = [ "lat" : "\(location.coordinate.latitude)",
//                      "lon" : "\(location.coordinate.longitude)" ]
//
//        currentWeatherNetworkService.fetchCurrentWeather(params: param) { [weak self] result in
//            switch result {
//            case .success(let response):
//                self?.presenter.succeccedFetchCurrentWeather(response: response)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
