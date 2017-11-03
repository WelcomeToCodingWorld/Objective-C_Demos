//
//  ViewController.swift
//  Runtime-SwiftTest
//
//  Created by zz on 03/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let label = UILabel()
//        if label.autoLayoutModels == nil {
//            label.autoLayoutModels = [UIView]()
//        }

//        let view = UIView()
//        if view.autoLayoutModels == nil {
//            view.autoLayoutModels = [UIView]()
//        }

        /*What the hell between the following two operations?*/

        // MARK: Directly append element here
//        label.autoLayoutModels?.append(UILabel())
//        label.autoLayoutModels?.append(UILabel())
//        printLog(label.autoLayoutModels)
//        printLog(objc_getAssociatedObject(self, "autoLayoutModels.key"))//nil. This may because the runtime

        // MARK: append by call an instance method
        view.al_layout()
        view.al_layout()
        printLog(view.autoLayoutModels)
        
        
        //Test Person Class
//        let person = Person()
//        if person.friends == nil {
//            person.friends = [Person.Friend]()
//        }
//        person.makeFriend()
//        person.makeFriend()
//        person.makeFriend()
//        printLog(person.friends)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIView {
    var autoLayoutModels : [UIView]? {
        get {
            return objc_getAssociatedObject(self, "autoLayoutModels.key") as? [UIView]
        }

        set{
            printLog("newValue:\(newValue as Optional)")
            objc_setAssociatedObject(self, "autoLayoutModels.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func al_layout() {
        // MARK: Actually this makes different.
        //Don't know why.
        //When a call began,it's computed property autoLayoutModels has been nil again.
        //May be,this cannot be did in the  internal of the declaration
        if autoLayoutModels == nil {
            printLog("yah,it is nil")
            autoLayoutModels = [UIView]()
        }else {
            printLog("It's not nil")
        }
        
        autoLayoutModels?.append(UILabel())
        printLog(autoLayoutModels)
    }
}

extension UIView {
    
}

class Person:NSObject {
    struct Friend {
        var name:String
        var age:UInt
    }
    
    
    var friends : [Friend]? {
        get {
            return objc_getAssociatedObject(self, "autoLayoutModels.key") as? [Friend]
        }

        set{
            objc_setAssociatedObject(self, "autoLayoutModels.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func makeFriend() {
        friends?.append(Friend(name: "xiaoLv", age: 10))
        //God. Just a print here damn make the result so different.
//        printLog("friends")
    }
    
    var newFriends:[Friend]?
    
    public func makeNewFriend() {
        newFriends?.append(Friend(name: "xiaoTian", age: 16))
    }
}


// MARK: Oh,My God. It's weird.  When I and a computed property in an extension. It's behaviour is different from the
//extension Person {
//    var friends : [Friend]? {
//        get {
//            return objc_getAssociatedObject(self, "autoLayoutModels.key") as? [Friend]
//        }
//
//        set{
//            objc_setAssociatedObject(self, "autoLayoutModels.key", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    public func makeFriend() {
//        friends?.append(Friend(name: "xiaolv", age: 10))
//    }
//}

