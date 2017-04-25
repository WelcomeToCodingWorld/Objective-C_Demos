//
//  User.swift
//  RequestDemo
//
//  Created by zz on 2017/3/15.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String
    var sex : Bool
    var age : UInt
    var mobile :String?
    
    override init() {
        self.name = ""
        self.sex = false
        self.age = 0
        self.mobile = ""
    }
    
    init(fromDic dic:Dictionary<String,AnyObject>){
        self.name = dic["name"] as! String
        self.sex = dic["sex"] as! Bool
        self.age = dic["age"] as! UInt
        self.mobile = dic["mobile"] as? String
    }
}


var hello:String?//global var need a initialization or getter/setter


struct IndeexPath {
    var row:Int
    var section:Int
}

func hello(userName:String,msg:String) -> String {
    var greetNick:String
    greetNick = "Mr"//Used before being initialized
    return greetNick + userName + msg
}
