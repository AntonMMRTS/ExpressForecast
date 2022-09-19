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
    
//    func pushSearchScreen() {
//        
//    }
}
