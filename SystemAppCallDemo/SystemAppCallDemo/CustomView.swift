//
//  CustomView.swift
//  SystemAppCallDemo
//
//  Created by zz on 2017/6/17.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import Foundation
import UIKit



@IBDesignable
class MyCustomView: UIView {
    @IBInspectable var textColor: UIColor!
    @IBInspectable var iconHeight: CGFloat = 0//It can't be optional
    // ...
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        if key == "iconHeight" {
//            print("The key \(key) is undefined!")
//        }else{
//            super.setValue(value, forUndefinedKey: key)
//        }
//    }
}

