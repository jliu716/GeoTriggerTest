//
//  ViewController.swift
//  GeoTriggerTest
//
//  Created by Beethoven on 23/01/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    @IBAction func callToAction(_ sender: Any) {
        // check authorization status
        enableLocationServices()
    }
    
    //MARK:- location manager
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            escalateLocationServiceAuthorization()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            enableMyAlwaysFeatures()
            break
        }
    }
    
    func escalateLocationServiceAuthorization() {
        // Escalate only when the authorization is set to when-in-use
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("please enable always share location!")
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func disableMyLocationBasedFeatures(){
        
    }
    
    func enableMyWhenInUseFeatures(){
        
    }
    
    func enableMyAlwaysFeatures(){
        // coordinate of SLI
        // Latitude = -43.535822, Longitude = 172.639964
        
        //
        print("location is always shared!")
    }
}

