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
    
    func searchCity(text: String) {
        let param = [ "q" : text ]

        currentWeatherNetworkService.fetchWeather(params: param) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.succeccedFetchCurrentWeather(response: response)
            case .failure(let error):
                self?.presenter.failureRequest()
            }
        }
    }
}
