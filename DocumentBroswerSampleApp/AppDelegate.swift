//
//  AppDelegate.swift
//  DocumentBroswerSampleApp
//
//  Created by Enrico Rosignoli on 1/29/20.
//  Copyright © 2020 AimTech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


// https://forums.developer.apple.com/thread/118932
    /*
     
     <key>UIFileSharingEnabled</key>
     <true/>
     <key>LSSupportsOpeningDocumentsInPlace</key>
     <true/>
     <key>UISupportsDocumentBrowser</key>
     <true/>

     */

    
    // https://developer.apple.com/documentation/uikit/view_controllers/adding_a_document_browser_to_your_app
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(documentsDir())
        
        if let url = launchOptions?[.url] as? URL {
            // TODO: handle URL from here
            openWriteAndCloseLog(msg: "1 " + url.absoluteString, withTimestamp: true)
        }
        return true
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // TODO: handle URL from here
        openWriteAndCloseLog(msg: "2 " + url.absoluteString, withTimestamp: true)
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

