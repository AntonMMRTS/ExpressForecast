//
//  LocationService.swift
//  Forecast
//
//  Created by Антон Усов on 19.09.2022.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    var delegate: LocationDelegate!
    
    var status: CLAuthorizationStatus?
    var location: CLLocation?
    
    private var manager: CLLocationManager?
    
    override init() {
        super.init()
        
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.startMonitoringSignificantLocationChanges()
        status = manager?.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.manager?.stopMonitoringSignificantLocationChanges()
        delegate.updateLocation(location: location)
    }
    
    func checkPermission() {
        manager?.requestWhenInUseAuthorization()
    }
}
    
