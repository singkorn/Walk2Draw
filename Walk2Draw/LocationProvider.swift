//
//  LocationProvider.swift
//  Walk2Draw
//
//  Created by Singkorn Dhepyasuvan on 25/10/2563 BE.
//

import UIKit
import CoreLocation
import LogStore

class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    private let locationManager: CLLocationManager
    private let updateHandler: (CLLocation) -> Void
    private(set) var updating = false
    
    init(updateHandler: @escaping (CLLocation) -> Void) {
        locationManager = CLLocationManager()
        self.updateHandler = updateHandler
        
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = 1
        locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
        updating = true
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
        updating = false
        locationManager.allowsBackgroundLocationUpdates = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            printLog("success")
        case .denied:
            printLog("denied")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        updateHandler(location)
    }

}
