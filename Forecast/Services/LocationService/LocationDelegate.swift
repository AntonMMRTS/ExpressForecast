//
//  LocationDelegate.swift
//  Forecast
//
//  Created by Антон Усов on 21.09.2022.
//

import Foundation
import CoreLocation

protocol LocationDelegate: AnyObject {
    func updateLocation(location: CLLocation)
}
