//
//  MainRouter.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import UIKit
import Swinject

final class MainRouter: MainRouterProtocol {
    
    // MARK: - Dependency Injection
    private weak var container: Container!
    private weak var viewController: UIViewController!
    
    init(container: Container, viewController: UIViewController) {
        self.container = container
        self.viewController = viewController
    }
    
    // MARK: - MainRouterProtocol
    func pushSearchScreen(delegate: SearchDelegate) {
        guard let nc = viewController.navigationController,
              let searchConfigurator = container.resolve(SearchConfiguratorProtocol.self) else { return }
        
        let vc = SearchViewController()
        searchConfigurator.configure(viewController: vc, delegate: delegate)
        nc.pushViewController(vc, animated: true)
    }
    
    func presentAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil ,
                                      preferredStyle: .alert)
        let button = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        
        alert.addAction(button)
        viewController.present(alert, animated: true)
    }
}
