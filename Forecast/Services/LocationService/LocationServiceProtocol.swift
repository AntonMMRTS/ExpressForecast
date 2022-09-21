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
    var delegate: LocationDelegate! { get set }
    var status: CLAuthorizationStatus? { get }
    
    func checkPermission()
}
