//
//  SearchPresenter.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol!
    private(set) var router: SearchRouterProtocol!
    private(set) var interactor: SearchInteractorProtocol!
    
    private(set) var cities: [Weather]  = [] {
        didSet {
            view.updateView()
        }
    }
    
    init(router: SearchRouterProtocol,
         interactor: SearchInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func configureView() {
        view.configureView()
    }
    
    func backToMainScreen() {
        router.backToMainScreen()
    }
    
    func searchCity(text: String) {
        interactor.searchCity(text: text)
    }
}

extension SearchPresenter: SearchPresenterInteractionProtocol {
    func succeccedFetchCurrentWeather(response: Weather) {
        self.cities.append(response)
//        view.updateView()
    }
    
    func failureRequest() {
        router.presentAlert()
    }
}
