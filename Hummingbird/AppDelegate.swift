//
//  AppDelegate.swift
//  Hummingbird
//
//  Created by Xiang Cai on 12/14/16.
//  Copyright © 2016 Xiang Cai. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Twitter.sharedInstance().start(withConsumerKey: "cpQw1QDKtqweStmCgiDENiV5Q", consumerSecret: "96cGFjEI0Y8Q0ZPVijIDbv9eqaFpna1DEg2FSqtXiLKAIheGE6")
        Fabric.with([Twitter.self])
        
        // Check for an existing Twitter or Digits session before presenting the sign in screen.
        if Twitter.sharedInstance().sessionStore.session() == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController: AnyObject! = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            window?.rootViewController = signInViewController as? UIViewController
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    @nonobjc func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if Twitter.sharedInstance().application(app, open:url as URL, options: options) {
            return true
        }
        
        // If you handle other (non Twitter Kit) URLs elsewhere in your app, return true. Otherwise
        return false
    }

}
