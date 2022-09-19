//
//  LocationServiceProtocol.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    var location: CLLocation? { get }
    var isPermission: Bool { get }
    var delegate: LocationDelegate! { get set }
    
    func checkPermission()
}
