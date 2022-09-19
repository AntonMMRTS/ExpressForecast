//
//  SearchRouter.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import UIKit
import Swinject

class SearchRouter: SearchRouterProtocol {
    
    // MARK: - Dependency Injection
    private weak var container: Container!
    private weak var viewController: UIViewController!
    
    init(container: Container, viewController: UIViewController) {
        self.container = container
        self.viewController = viewController
    }
    
    func backToMainScreen() {
        guard let nc = viewController.navigationController else { return }
        nc.popViewController(animated: true)
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Что то пошло не так",
                                      message: nil
                                      ,
                                      preferredStyle: .alert)
        let button = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        
        alert.addAction(button)
        viewController.present(alert, animated: true)
    }
}
