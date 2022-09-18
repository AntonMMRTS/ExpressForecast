//
//  SearchPresenter.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    // MARK: - Dependency Injection
    weak var view: SearchViewProtocol!
    weak var delegate: SearchDelegate?
    private(set) var router: SearchRouterProtocol!
    private(set) var interactor: SearchInteractorProtocol!
    
    private(set) var cities: [City]  = [] {
        didSet {
            view.updateView()
        }
    }
    private var inputTimer: Timer?
    
    init(router: SearchRouterProtocol,
         interactor: SearchInteractorProtocol,
         delegate: SearchDelegate) {
        self.router = router
        self.interactor = interactor
        self.delegate = delegate
    }
    
    // MARK: - SearchPresenterProtocol
    func configureView() {
        view.configureView()
    }
    
    func backToMainScreen() {
        router.backToMainScreen()
    }
    
    func searchCity(text: String) {
        interactor.searchCity(text: text)
    }
    
    func addCityToDatabase(city: City) {
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

// MARK: - SearchPresenterInteractionProtocol
extension SearchPresenter: SearchPresenterInteractionProtocol {
    func succeccedFetchCurrentWeather(response: City) {
        self.cities.append(response)
    }
    
    func failureRequest() {
        router.presentAlert()
    }
}
