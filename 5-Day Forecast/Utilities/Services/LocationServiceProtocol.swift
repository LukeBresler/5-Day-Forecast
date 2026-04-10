//
//  LocationServiceProtocol.swift
//  5-Day Forecast
//
//  Created by Luke Bresler on 2026/04/10.
//


import Foundation
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    var delegate: LocationServiceDelegate? { get set }
    func requestLocation()
    func requestLocationPermission()
}

protocol LocationServiceDelegate: AnyObject {
    func locationService(_ service: LocationServiceProtocol, didUpdateLocation location: CLLocation)
    func locationService(_ service: LocationServiceProtocol, didFailWith error: Error)
}

class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    weak var delegate: LocationServiceDelegate?
    private let locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        delegate?.locationService(self, didUpdateLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationService(self, didFailWith: error)
    }
}
