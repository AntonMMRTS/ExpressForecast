//
//  SearchInteractor.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

final class SearchInteractor: SearchInteractorProtocol {
    // MARK: - Dependency Injection
    private var currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol!
    private var databaseService: DatabaseServiceProtocol!
    
    weak var presenter: SearchPresenterInteractionProtocol!
    
    init(currentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol,
         databaseService: DatabaseServiceProtocol!) {
        self.currentWeatherNetworkService = currentWeatherNetworkService
        self.databaseService = databaseService
    }
    
    func searchCity(text: String) {
        let param = [ "q" : text ]

        currentWeatherNetworkService.fetchWeather(params: param) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.succeccedFetchCurrentWeather(response: response)
            case .failure:
                self?.presenter.failureRequest()
            }
        }
    }
    
    // MARK: - SearchInteractorProtocol
    func addCityToDatabase(city: City) {
        databaseService.addNewCity(city: city)
    }
}

