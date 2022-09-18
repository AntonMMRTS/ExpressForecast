//
//  ReachabilityServiceProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 20.09.2022.
//

import Foundation

protocol ReachabilityServiceProtocol {
    func checkConection(completion: @escaping (Bool) -> Void)
}
