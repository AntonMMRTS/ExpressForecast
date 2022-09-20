//
//  LocationService.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation
import CoreLocation

protocol LocationDelegate: AnyObject {
    func updateLocation(location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    var delegate: LocationDelegate!
    
    var manager: CLLocationManager?
    var location: CLLocation?
    var isLocation: Bool = false
    var isPermission = false
    
    override init() {
        super.init()
        
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        delegate.updateLocation(location: location)
    }
    
    func checkPermission() {
        manager?.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways , .authorizedWhenInUse:
            isPermission = true
        case .notDetermined , .denied , .restricted:
           break
        default:
            break
        }
    }
}
    

