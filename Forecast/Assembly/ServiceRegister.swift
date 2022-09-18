//
//  ServiceRegister.swift
//  Forecast
//
//  Created by Антон Усов on 18.09.2022.
//

import Foundation
import Swinject

class ServiceRegister {
    class func register(for container: Container) {

        container.register(StartAppServiceProtocol.self) { _ in

            return StartAppService(container: container)
        }

        registerMainModule(for: container)
    }
    
    private class func registerMainModule(for container: Container) {
        container.register(MainConfiguratorProtocol.self) { _ in
            return MainConfigurator(container: container)
        }
    }
}
