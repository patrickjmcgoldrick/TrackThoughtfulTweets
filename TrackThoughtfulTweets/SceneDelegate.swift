//
//  SceneDelegate.swift
//  TrackThoughtfulTweets
//
//  Created by dirtbag on 11/29/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import Swifter

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        guard let context = URLContexts.first else { return }
        // ... Web
        print ("Scene method")
        let callbackUrl = URL(string: "mcgoldrick://")!
        Swifter.handleOpenURL(context.url) 
         
    }
}
