//
//  ViewController.swift
//  Runtime-SwiftTest
//
//  Created by zz on 03/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//



/*
 关注点：
 一、判断放在同级方法中与放在外部的区别
 即：
 if label.autoLayoutModels == nil {
     label.autoLayoutModels = [UIView]()
 }
 放在1）处和2）处的区别
 
 
 通过实验：
 放在1）处时，2）处判不判断已经无所谓，情况符合预期：两个Label都加到了数组中
 
 而只放在2）处时，调用addObject的两次方法，两次运行居然互不影响，第一次数组中加进去了Label,而在第二次运行开始时，数组居然又是nil了
 
 总结：
 1)以上试验纯属偶然：我自己创建了一个name为view的UIView,这和controller的view一样了，可能让编译器造成误会了，所以出现上面奇怪的情况，这也证明了命名的重要性
 2)上面的情况在用UIView试验的时候的确是偶然，但是可笑的是用UIView和UILabel试验结果却不同
 
 3)好吧，真的不知道怎么说了，不管我用UIView还是UILabel试验，每次运行之前，我进行Clean操作，每次运行的结果居然不同，My God。只能感叹OC的运行时在Swift上真的难以预料，很是任性
 4)好，我的操作失误，以此条结论为准：如果在2）处判断进行了判断，每次Clean并运行会出现各种不同的结果，而只在1）结果一致且符合预期
 两处都判断会出现下面所示的一种随机结果：
 ViewController.swift[95],autoLayoutModels:newValue:Optional([])
 ViewController.swift[110],al_layout():It's not nil
 ViewController.swift[95],autoLayoutModels:newValue:nil
 ViewController.swift[107],al_layout():yah,it is nil
 ViewController.swift[95],autoLayoutModels:newValue:Optional([])
 ViewController.swift[95],autoLayoutModels:newValue:Optional([<UILabel: 0x7f9ee4d0afb0; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x600000285e10>>])
 ViewController.swift[65],viewDidLoad():Optional([<UILabel: 0x7f9ee4d0afb0; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x600000285e10>>])
 
 See that:It's not nil then :: newValue:nil ,damn ,who did this!
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel()
        if label.autoLayoutModels == nil {
            label.autoLayoutModels = [UIView]()
        }

        let view = UIView()
//        //1)
//        if view.autoLayoutModels == nil {
//            view.autoLayoutModels = [UIView]()
//        }

        /*What the hell between the following two operations?*/

        // MARK: Directly append element here
//        label.autoLayoutModels?.append(UILabel())
//        label.autoLayoutModels?.append(UILabel())
//        printLog(label.autoLayoutModels)
//        printLog(objc_getAssociatedObject(label, "autoLayoutModels.key"))//nil. This may because the runtime

        // MARK: append by call an instance method
        label.al_layout()
        label.al_layout()
        printLog(label.autoLayoutModels)
        
        
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
        //2)
        if autoLayoutModels == nil {
            printLog("yah,it is nil")
            autoLayoutModels = [UIView]()
        }else {
            printLog("It's not nil")
        }
        
        autoLayoutModels?.append(UILabel())
//        printLog(autoLayoutModels)
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

