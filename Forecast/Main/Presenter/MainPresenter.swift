//
//  MainPresenter.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol!
    private(set) var router: MainRouterProtocol!
    private(set) var interactor: MainInteractorProtocol!
    
    private(set) var cities: [Weather]  = []
    
    init(router: MainRouterProtocol,
         interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func configureView() {
//        interactor.fetchCurrentWeather()
        view.configureView()
    }
    
    func pushSearchScreen() {
        router.pushSearchScreen()
    }
}

extension MainPresenter: MainPresenterInteractionProtocol {
    func succeccedFetchCurrentWeather(response: Weather) {
        self.cities.append(response)
        view.updateView()
    }
    
    func failureRequest() {
        router.presentAlert()
    }
}
