//
//  ViewController.swift
//  GeoTriggerTest
//
//  Created by Beethoven on 23/01/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    let locationManager = CLLocationManager()
    var notificationCenter: UNUserNotificationCenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the singleton object
        self.notificationCenter = UNUserNotificationCenter.current()
        // register as it's delegate
        notificationCenter?.delegate = self
    }
    
    @IBAction func callToAction(_ sender: Any) {
        // check authorization status
        enableLocationServices()
    }
    
    //MARK:- notification manager
    func getNotificationPermission(){
        // define what do you need permission to use
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        // request permission
        notificationCenter?.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Permission not granted")
            }
        }
    }
    
    //MARK:- location manager
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            escalateLocationServiceAuthorization()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            enableMyAlwaysFeatures()
            break
        default:
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
    
    func enableMyAlwaysFeatures(){
        // coordinate of SLI
        // Latitude = -43.535822, Longitude = 172.639964
        
        //
        print("location is always shared!")
        // Your coordinates go here (lat, lon)
        let sliSystemsCoordinate = CLLocationCoordinate2DMake(-43.535822, 172.639964)
        
        /* Create a region centered on desired location,
         choose a radius for the region (in meters)
         choose a unique identifier for that region */
        let sliSystemsRegion = CLCircularRegion(center: sliSystemsCoordinate,
                                              radius: 100,
                                              identifier: "sliSystemsRegion")
        
        
        sliSystemsRegion.notifyOnEntry = true
        sliSystemsRegion.notifyOnExit = false
        
        locationManager.startMonitoring(for: sliSystemsRegion)
        
        // ask for notification permission
        getNotificationPermission()
    }
}

