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
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = 1
        locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
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
        printLog("locations: \(locations)")
    }

}
