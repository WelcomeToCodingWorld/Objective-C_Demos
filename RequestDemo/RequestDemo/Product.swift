//
//  Product.swift
//  RequestDemo
//
//  Created by zz on 2017/4/18.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class Product: NSObject {
    var productName = ""
    var productId = ""
//    var price : UInt
    
    init(fromDic dic:Dictionary<String,AnyObject>){
        self.productName = dic["productName"] as! String
//        self.price = dic["price"] as! UInt
        self.productId = dic["productId"] as! String
    }
}
