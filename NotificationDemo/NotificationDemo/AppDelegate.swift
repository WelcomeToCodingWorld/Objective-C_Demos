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
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getCurrentPushSettings()
        getNotHandledNotifications()
        UNUserNotificationCenter.current().delegate = self
        authorizeAPNS()
        configureNotificationCategory()
        schedualLocalNotification()
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
        center.requestAuthorization(options: [.alert, .sound]) {[weak self] (granted, error) in
            // Enable or disable features based on authorization.
            if granted {
                self?.registerApns()
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
        
        
        //This action is delivered only if the notification’s category object was configured with the customDismissAction option. To trigger this action, the user must explicitly dismiss the notification interface. For example, the user must tap the Dismiss button or swipe down on the notification interface in watchOS to trigger this action.
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
                                                     actions: [snoozeAction, stopAction],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        
        // Register the notification categories.
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([generalCategory, expiredCategory])
    }
    
    func schedualLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
        content.body  = NSString.localizedUserNotificationString(forKey: "Rise and shine!It's morning time!", arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "GENERAL"
        
        //configure the trigger for a 7am wakeup
        var dateInfo = DateComponents()
        dateInfo.hour = 14
        dateInfo.minute = 44
        
        
        // Swift
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 120,
                                                        repeats: true)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: timeIntervalTrigger)
        
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
        
        let pushMeToken = device_ns.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>" ))
        print(pushMeToken)
        
        
        let phpToken:String = pushMeToken.replacingOccurrences(of: " ", with: "")
        print(phpToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("\(error)")
    }
    
    
    /*UIAppDelegate for notification*/
    //When a remote notification arrives, the system handles user interactions normally when the app is in the background
    //You can use these methods to examine the payload and perform any related tasks. For example, upon receiving a silent remote notification, you might start downloading new content for your app. 
    //Failure to execute the completion handler block at the end of your implementation will cause your app to be terminated.
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        print(userInfo)
//    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print(notification.alertBody!)
    }
    
    //Failure to execute the completion handler block at the end of your implementation will cause your app to be terminated.
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        print(identifier!)
        completionHandler()
    }
    
    //For apps that want to initiate background downloads, the system calls this function when the time is right for you to start those downloads.
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    
    /*UNUserNotificationCenterDelegate*/
    //called when the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Update the app interface directly.
        print("A silent notification received!")
        // Play a sound.
        completionHandler(UNNotificationPresentationOptions.sound);
    }
    
    //Failure to execute the completion handler block at the end of your implementation will cause your app to be terminated.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == UNNotificationDismissActionIdentifier {
            // The user dismissed the notification without taking action
            print("The user dismissed the notification without taking action")
        }else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            // The user launched the app
            print("The user launched the app")
        }else{
            if response.notification.request.content.categoryIdentifier == "TIMER_EXPIRED" {
                // Handle the actions for the expired timer.
                if response.actionIdentifier == "SNOOZE_ACTION" {
                    // Invalidate the old timer and create a new one. . .
                    print("The user tap the snooze button!")
                } else if response.actionIdentifier == "STOP_ACTION" {
                    // Invalidate the timer. . .
                    print("The user tap the stop button!")
                }
            }
        }
        completionHandler()
    }
    
    
    /*Why can‘t UNUserNotificationCenterDelegate be this class*/
    class CustomNotificationCenterDelegate: NSObject,UNUserNotificationCenterDelegate {
        //called when the app is in foreground
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // Update the app interface directly.
            print("A silent notification received!")
            // Play a sound.
            completionHandler(UNNotificationPresentationOptions.sound);
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            if response.actionIdentifier == UNNotificationDismissActionIdentifier {
                // The user dismissed the notification without taking action
                print("The user dismissed the notification without taking action")
            }
            else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                // The user launched the app
                print("The user launched the app")
            }else{
                if response.notification.request.content.categoryIdentifier == "TIMER_EXPIRED" {
                    // Handle the actions for the expired timer.
                    if response.actionIdentifier == "SNOOZE_ACTION" {
                        // Invalidate the old timer and create a new one. . .
                        print("The user tap the snooze button!")
                    }
                    else if response.actionIdentifier == "STOP_ACTION" {
                        // Invalidate the timer. . .
                        print("The user tap the stop button!")
                    }
                }
            }
        }

    }
}

