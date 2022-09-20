//
//  SearchConfigurator.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation
import Swinject

class SearchConfigurator: SearchConfiguratorProtocol {
    private weak var container: Container!
    
    init(container: Container) {
        self.container = container
    }
    
    func configure(viewController: SearchViewController) {
        let currentWeatherNetworkService = container.resolve(CurrentWeatherNetworkServiceProtocol.self)!
        let databaseService = container.resolve(DatabaseServiceProtocol.self)!
        
        let router = SearchRouter(container: container, viewController: viewController)
        let interactor = SearchInteractor(currentWeatherNetworkService: currentWeatherNetworkService,
                                          databaseService: databaseService)
        let presenter = SearchPresenter(router: router, interactor: interactor)
        
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
    }
}
