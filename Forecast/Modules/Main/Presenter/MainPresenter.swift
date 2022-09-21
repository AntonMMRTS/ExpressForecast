//
//  MainPresenter.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//


import Foundation

final class MainPresenter: MainPresenterProtocol {
    // MARK: - Dependency Injection
    weak var view: MainViewProtocol!
    private(set) var router: MainRouterProtocol!
    private(set) var interactor: MainInteractorProtocol!
    
    private(set) var cities: [City]  = [] {
        didSet {
            view.updateView()
        }
    }
    
    init(router: MainRouterProtocol,
         interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - MainPresenterProtocol
    func configureView() {
        configureData()
        view.configureView()
    }
    
    func pushSearchScreen() {
        router.pushSearchScreen(delegate: self)
    }
}

// MARK: - Private Methods
private extension MainPresenter {
    func configureData() {
        interactor.checkConection { isConection in
            if !isConection {
                DispatchQueue.main.async {
                    let title = "Отсутствует подключение к интернету"
                    self.router.presentAlert(title: title)
                }
            } else {
                self.interactor.getCurrentWeather()
            }
        }
        
        cities = interactor.fetchCitiesFromDatabase().reversed()
    }
}

// MARK: - SearchDelegate
extension MainPresenter: SearchDelegate {
    func addCity(city: City) {
        if let index = cities.firstIndex(where: { $0.name == city.name }) {
            interactor.deleteCityFromDatabase(city: cities[index])
            cities.remove(at: index)
        }
        cities.insert(city, at: 0)
    }
}

// MARK: - MainPresenterInteractionProtocol
extension MainPresenter: MainPresenterInteractionProtocol {
    func succeccedFetchCurrentWeather(response: City) {
        if let index = cities.firstIndex(where: { $0.name == response.name }) {
            interactor.deleteCityFromDatabase(city: cities[index])
            cities.remove(at: index)
        }
        cities.insert(response, at: 0)
        interactor.addCityToDatabase(city: response)
    }
    
    func failureRequest() {
        router.presentAlert(title: "Что то пошло не так")
    }
}

