//
//  AppDelegate.swift
//  Stars Homes
//
//  Created by Henry Goodwin on 5/01/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UISearchBar.appearance().barTintColor = UIColor.Green()
        
        UISearchBar.appearance().tintColor = UIColor.whiteColor()
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.Green()
        UINavigationBar.appearance().barTintColor = UIColor.Green()
        return true
    }
    
    
}

extension UIColor {
    static func Green() -> UIColor {
        return UIColor(red: 67.0/255.0, green: 205.0/255.0, blue: 135.0/255.0, alpha: 1.0)
    }
    
    static func Blue() -> UIColor {
        return UIColor(red: 54.0/255.0, green:171.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    }
}