//
//  User.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/4/20.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String
    var gender : UInt
    var address : String
    var age : UInt
    var mobile : String
    var email : String
    
    
    init(fromDic dic : Dictionary<String, Any>){
        self.name = dic["userName"] as! String
        self.gender = dic["gender"] as! UInt
        self.address = dic["address"] as! String
        self.age = dic["age"] as! UInt
        self.mobile = dic["phone"] as! String
        self.email = dic["email"] as! String
    }
}
