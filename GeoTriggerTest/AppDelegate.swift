//
//  AppDelegate.swift
//  GeoTriggerTest
//
//  Created by Beethoven on 23/01/19.
//  Copyright © 2019 Jiayi Liu. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?
    var notificationCenter : UNUserNotificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let sliSystemsCoordinate = CLLocationCoordinate2DMake(-43.535822, 172.639964)
        let sliSystemsRegion = CLCircularRegion(center: sliSystemsCoordinate,
                                                radius: 300,
                                                identifier: "sliSystemsRegion")
//        handleEvent(forRegion: sliSystemsRegion)
    }

}
extension AppDelegate : CLLocationManagerDelegate {
    
    func locationManager(_ manager : CLLocationManager, didEnterRegion region : CLRegion) {
        
        print("enters region : \(region.identifier)")
        
        // send the notification for region
        handleEvent(forRegion: region)
    }
    
    func handleEvent(forRegion region:CLRegion){
        // name the region
        let regionIdentifier = region.identifier.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        // create notification
        let content = UNMutableNotificationContent()
        content.title = "You have arrived"
        content.body = "Region : \(regionIdentifier)"
        content.sound = UNNotificationSound.default
        
        // after user enters, how long to trigger the notification
        let timeInSeconds : TimeInterval = 10
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInSeconds,
                                                        repeats: false)
        
        // send notification request
        let request = UNNotificationRequest(identifier: "user_enters_\(regionIdentifier)",
                                            content: content,
                                            trigger: trigger)
        
        // trying to add the notification request to notification center
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(regionIdentifier)")
            }
        })
    }
}

