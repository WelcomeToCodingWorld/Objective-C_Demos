//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by zz on 2017/3/22.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.getCurrentPushSettings()
        self.getNotHandledNotifications()
        self.authorizeAPNS()
        self.configureNotificationCategory()
        self.schedualLocalNotification()
        return true
    }
    
    func getCurrentPushSettings() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (notificationSettings) in
            print("\(notificationSettings)")
        }

    }
    
    func registerApns() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func authorizeAPNS() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
            if granted {
                self.registerApns()
            }
        }
    }
    
    func configureNotificationCategory() {
        let generalCategory = UNNotificationCategory(identifier: "GENERAL",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        
        // Create the custom actions for the TIMER_EXPIRED category.
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                title: "Snooze",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let stopAction = UNNotificationAction(identifier: "STOP_ACTION",
                                              title: "Stop",
                                              options: .foreground)
        
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
                                                     actions: [snoozeAction, stopAction],
                                                     intentIdentifiers: [],
                                                     options: UNNotificationCategoryOptions(rawValue: 0))
        
        // Register the notification categories.
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([generalCategory, expiredCategory])
    }
    
    func schedualLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
        content.body  = NSString.localizedUserNotificationString(forKey: "Rise and shine!It's morning time!", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "TIMER_EXPIRED"
        
        //configure the trigger for a 7am wakeup
        var dateInfo = DateComponents()
        dateInfo.hour = 17
        dateInfo.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error:Error?) in
            if let err = error {
                print(err.localizedDescription)
            }
        }
        
    }
    
    func getNotHandledNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getDeliveredNotifications { (notHandledNotifications) in
            print("\(notHandledNotifications)")
        }
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
    
    //MARK: register apns
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let device_ns = NSData.init(data: deviceToken)
        
        let token:String = device_ns.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>" )).replacingOccurrences(of: " ", with: "")
        
        print(token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("\(error)")
    }
}

