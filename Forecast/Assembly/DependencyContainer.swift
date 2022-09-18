//
//  DependencyContainer.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import Swinject

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private var dependencyContainer: Container
    
    private init() {
        dependencyContainer = Swinject.Container()
        
        ServiceRegister.register(for: dependencyContainer)
    }
    
    func getService<Service>(_ serviceType: Service.Type) -> Service {
        return dependencyContainer.resolve(serviceType)!
    }
}
