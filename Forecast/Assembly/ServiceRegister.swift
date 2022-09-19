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
        
        registerNetworkService(for: container)
        registerLocationService(for: container)
        registerModules(for: container)
    }
    
    private class func registerModules(for container: Container) {
        container.register(MainConfiguratorProtocol.self) { _ in
            return MainConfigurator(container: container)
        }
        container.register(SearchConfiguratorProtocol.self) { _ in
            return SearchConfigurator(container: container)
        }
    }
    
    private class func registerNetworkService(for container: Container) {
        let networkService = NetworkService()
        container.register(CurrentWeatherNetworkServiceProtocol.self) { _ in
            return networkService
        }.inObjectScope(.container)
    }
    
    private class func registerLocationService(for container: Container) {
        let locationService = LocationService()
        container.register(LocationServiceProtocol.self) { _ in
            return locationService
        }.inObjectScope(.container)
    }
}
