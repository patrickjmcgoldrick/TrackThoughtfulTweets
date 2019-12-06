//
//  AppDelegate.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 11/29/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import Swifter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    // MARK: URL Authorization for OAUTH
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        

        //let callbackUrl = URL(string: "TrackThoughtfulTweets://")!
        let callbackUrl = URL(string: "mcgoldrick://")!

        print ("Open URL: \(url)")
        
        Swifter.handleOpenURL(callbackUrl) //, callbackURL: callbackUrl)
        
        return true
    }
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

   

}

