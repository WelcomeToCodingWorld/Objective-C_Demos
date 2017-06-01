//
//  User.swift
//  NotificationDemo
//
//  Created by zz on 2017/5/25.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String = ""
    var age : uint = 0
//    init(dic:Dictionary<String, Any>) {
//        super.init()
//        setValuesForKeys(dic)
//    }
    override func setNilValueForKey(_ key: String) {
        super .setNilValueForKey(key)
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        super.setValuesForKeys(keyedValues)
    }
}
