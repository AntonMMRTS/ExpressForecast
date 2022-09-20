//
//  SearchPresenter.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol!
    weak var delegate: SearchDelegate?
    private(set) var router: SearchRouterProtocol!
    private(set) var interactor: SearchInteractorProtocol!
    
    private var inputTimer: Timer?
    
    private(set) var cities: [Weather]  = [] {
        didSet {
            view.updateView()
        }
    }
    
    init(router: SearchRouterProtocol,
         interactor: SearchInteractorProtocol,
         delegate: SearchDelegate) {
        self.router = router
        self.interactor = interactor
        self.delegate = delegate
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
    
    func addCityToDatabase(city: Weather) {
        delegate?.addCity(city: city)
        interactor.addCityToDatabase(city: city)
    }
    
    func searchTextFieldDidChange(text: String) {
        inputTimer?.invalidate()
        
        guard text.count > 2 else {
            inputTimer?.invalidate()
            return }
            inputTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self] _ in
                self?.interactor.searchCity(text: text)
            })
    }
}

extension SearchPresenter: SearchPresenterInteractionProtocol {
    func succeccedFetchCurrentWeather(response: Weather) {
        self.cities.append(response)
    }
    
    func failureRequest() {
        router.presentAlert()
    }
}
