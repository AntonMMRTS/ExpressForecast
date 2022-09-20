//
//  ReachabilityService.swift
//  Forecast
//
//  Created by Антон Усов on 20.09.2022.
//

import Foundation
import Network

class ReachabilityService: ReachabilityServiceProtocol {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    func checkConection(completion: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                completion(true)
            } else {
                print("There's no internet connection.")
                completion(false)
            }
        }
        
        monitor.start(queue: queue)
    }
}
