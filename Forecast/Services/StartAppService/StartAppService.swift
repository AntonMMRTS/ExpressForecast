//
//  StartAppService.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import UIKit
import Swinject

class StartAppService: StartAppServiceProtocol {
    // MARK: - Dependency Injection
    private let container: Container!
    
    init(container: Container) {
        self.container = container
    }
    
    func start(scene: UIWindowScene) -> UIWindow? {
        let window = UIWindow(windowScene: scene)
        
        guard let mainConfigurator = container.resolve(MainConfiguratorProtocol.self) else { return nil }
        let mainVC = MainViewController()
        mainConfigurator.configure(viewController: mainVC)
        let nacVC = UINavigationController(rootViewController: mainVC)
        window.rootViewController = nacVC
        window.makeKeyAndVisible()
        return window
    }
}
