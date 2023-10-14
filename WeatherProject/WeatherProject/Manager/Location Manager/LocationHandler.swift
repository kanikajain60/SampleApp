//
//  LocationHandler.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D
typealias Location = CLLocation

protocol LocationProvidable {
    var desiredAccuracy: CLLocationAccuracy { get set }
    var locationManagerDelegate: LocationProviderDelegate? {get set}
    
    func requestAuthorization()
    func fetchLocation()
}

protocol LocationProviderDelegate {
    func locationProvider(_ provider: LocationProvidable, didChangeAuthorization status: CLAuthorizationStatus)
    func locationProvider(_ provider: LocationProvidable, didUpdateLocations location: Location?)
    func locationProvider(_ provider: LocationProvidable, didFailWithError error: LocationError)
}

extension CLLocationManager: LocationProvidable {
    var locationManagerDelegate: LocationProviderDelegate? {
        get {
            return self.delegate as? LocationProviderDelegate
        }
        set {
            self.delegate = newValue as? CLLocationManagerDelegate
        }
    }
    
    func requestAuthorization() {
        requestWhenInUseAuthorization()
    }
    
    func fetchLocation() {
        requestLocation()
        self.startUpdatingLocation()
    }
}


class LocationHandler: NSObject, LocationProvider {
    
    var provider: LocationProvidable
    private var locationCompletionHandler: LocationCompletionHandler?
    
    // MARK: - Initialisation
    
    init(provider: LocationProvidable = CLLocationManager()) {
        self.provider = provider
        super.init()
        self.provider.locationManagerDelegate = self
        self.provider.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    /// This function is used to get current location
    /// - Parameter completion: completion handler
    func getCurrentLocation(completion: @escaping (Location?, LocationError?) -> Void) {
        self.locationCompletionHandler = completion
        switch (provider as! CLLocationManager).authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            provider.fetchLocation()
            break
        default:
            provider.requestAuthorization()
        }
    }
}
// MARK: - Location Provider Delegate

extension LocationHandler: LocationProviderDelegate {
    func locationProvider(_ provider: LocationProvidable, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            provider.fetchLocation()
        default:
            locationProvider(provider, didFailWithError: LocationError.userNotAuthorized)
        }
    }
    
    func locationProvider(_ provider: LocationProvidable, didUpdateLocations location: Location?) {
        guard let userLocation = location else {
            locationCompletionHandler?(nil, .couldNotBeLocated)
            return
        }
        locationCompletionHandler?(userLocation, nil)
    }
    
    func locationProvider(_ provider: LocationProvidable, didFailWithError error: LocationError) {
        debugPrint(error)
        locationCompletionHandler?(nil, error)
    }
}

// MARK: - CLLocation Manager Delegate functions

extension LocationHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationProvider(provider, didChangeAuthorization: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        locationProvider(provider, didUpdateLocations: locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        locationProvider(provider, didFailWithError: LocationError.couldNotBeLocated)
    }
}
