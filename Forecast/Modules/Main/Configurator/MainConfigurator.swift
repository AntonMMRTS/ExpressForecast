//
//  MainConfigurator.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import Swinject

class MainConfigurator: MainConfiguratorProtocol {
    private weak var container: Container!
    
    init(container: Container) {
        self.container = container
    }
    
    func configure(viewController: MainViewController) {
        let currentWeatherNetworkService = container.resolve(CurrentWeatherNetworkServiceProtocol.self)!
        var locationService = container.resolve(LocationServiceProtocol.self)!
        let databaseService = container.resolve(DatabaseServiceProtocol.self)!
        let reachabilityService = container.resolve(ReachabilityServiceProtocol.self)!
        
        let router = MainRouter(container: container, viewController: viewController)
        let interactor = MainInteractor(currentWeatherNetworkService: currentWeatherNetworkService,
                                        locationService: locationService,
                                        databaseService: databaseService,
                                        reachabilityService: reachabilityService)
        let presenter = MainPresenter(router: router, interactor: interactor)
        
        locationService.delegate = interactor
        presenter.view = viewController
        interactor.presenter = presenter
        viewController.presenter = presenter
    }
}
