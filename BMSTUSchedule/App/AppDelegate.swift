//
//  AppDelegate.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 14/10/2016.
//  Copyright © 2016 BMSTU Team. All rights reserved.
//

import UIKit
import UserNotifications

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var manager: AppManager {
        return AppManager.shared
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        manager.configureServices()
        manager.configureUI()

        switch manager.authorizationState {
        case .unauthorized:
            
            // FIXME: Fix this
            guard let authController = AppRouter.ModuleStoryboard.authorization.controller else {
                break
            }
            window?.rootViewController = authController
            
        default:
            break
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
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        // Handle 3D-touch shortcuts
        completionHandler(AppManager.shared.handleQuickAction(shortcutItem: shortcutItem))
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        // Handle Siri intents
        let result = AppManager.shared.handleIntent(userActivity: userActivity)
        
        return result
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Handle remote notification
        AppManager.shared.notificationsService.handle(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
