//
//  AppDelegate.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit
import Firebase
import  GoogleMaps
import GooglePlaces
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyB6NyAmJJz7Za4YPD0pBBiCuiw8-yT4nFk")//Free primary app key (email :hudhud.firebase)
        GMSPlacesClient.provideAPIKey("AIzaSyB6NyAmJJz7Za4YPD0pBBiCuiw8")//each service need an api key (email : q.abed@????.com )
        
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

