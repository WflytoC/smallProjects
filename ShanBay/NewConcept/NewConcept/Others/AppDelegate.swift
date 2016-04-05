//
//  AppDelegate.swift
//  NewConcept
//
//  Created by wcshinestar on 3/29/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.window!.backgroundColor = UIColor.whiteColor()
        
        let nv = UINavigationController(rootViewController: NCListController())
        
        self.window!.rootViewController = nv
        
        self.window!.makeKeyAndVisible()
        
        NCHandleData.loadDataFromFile()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

