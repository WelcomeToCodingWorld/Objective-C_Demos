//
//  AppDelegate.swift
//  MethodSwizzlingTest
//
//  Created by zz on 02/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
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


}


protocol SelfAware: class {
    static func awake()
    static func swizzleMethod(originalSelector:Selector,swizzledSelector:Selector)
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate(capacity: typeCount)
    }
}


extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
        
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}

extension SelfAware where Self: UIView {
    static func swizzleMethod(originalSelector:Selector,swizzledSelector:Selector) {
        var anyClass : AnyClass
        print(self)
        print(self is UILabel.Type)
        if self is UILabel.Type {
            anyClass = UILabel.self
        }else {
            anyClass = UIView.self
        }
        
        let originalMethod = class_getInstanceMethod(anyClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(anyClass, swizzledSelector)
        
        var didAddMethod = false
        if let swizzledMethod = swizzledMethod {
            didAddMethod = class_addMethod(anyClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        }

        if didAddMethod {
            if let originMethod = originalMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod))
            }
        }else {
            if let originMethod = originalMethod,let swizzledMethod = swizzledMethod {
                method_exchangeImplementations(originMethod, swizzledMethod)
            }else {
                print("self:\(self)--Method:[\(originalMethod as Optional),\(swizzledMethod as Optional)]")
            }
        }
    }
}

extension UIView:SelfAware {
    static func awake() {
        var originSelector:Selector
        var swizzledSelector:Selector
        if self is UILabel.Type {
            originSelector = #selector(setter: UILabel.self.text)
            swizzledSelector = #selector(UILabel.self.al_setText(_:))
            swizzleMethod(originalSelector: originSelector, swizzledSelector: swizzledSelector)
        }
    }
}



