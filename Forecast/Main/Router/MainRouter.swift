//
//  MainRouter.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import UIKit
import Swinject

class MainRouter: MainRouterProtocol {
    
    // MARK: - Dependency Injection
    private weak var container: Container!
    private weak var viewController: UIViewController!
    
    init(container: Container, viewController: UIViewController) {
        self.container = container
        self.viewController = viewController
    }
    
    func pushSearchScreen() {
        guard let nc = viewController.navigationController,
              let searchConfigurator = container.resolve(SearchConfiguratorProtocol.self) else { return }
        
        let vc = SearchViewController()
        searchConfigurator.configure(viewController: vc)
        nc.pushViewController(vc, animated: true)
    }
}
