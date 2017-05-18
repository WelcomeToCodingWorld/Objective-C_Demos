//
//  Product.swift
//  SearchControllerDemo
//
//  Created by zz on 2017/5/6.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class Product: NSObject,NSCoding {
    let title : String
    let hardWareType : String
    let yearIntroduced : Int
    let introPrice : Double

    
    class var deviceTypeNames : [String]{
        return [Product.deviceTypeTitle,Product.desktopTypeTitle,portableTypeTitle];
    }
    
    class var  deviceTypeTitle : String{
        return NSLocalizedString("Device", comment: "Device type title")
    }
    
    class var desktopTypeTitle : String{
        return NSLocalizedString("Desktop", comment: "Desktop type title")
    }
    
    class var portableTypeTitle : String{
        return NSLocalizedString("Portable", comment: "Portable type title")
    }
    
    enum HardWare : String{
        case iPhone = "iPhone"
        case iPod = "iPod"
        case iPodTouch = "iPod Touch"
        case iPad = "iPad"
        case iPadMini = "iPad Mini"
        case iMac = "iMac"
        case MacPro = "Mac Pro"
        case MacBookAir = "Mac Book Air"
        case MacBookPro = "Mac Book Pro"
    }
    
    enum CoderKeys: String {
        case nameKey
        case typeKey
        case yearKey
        case priceKey
    }
    
    init(title:String,hardWareType:String,yearIntroduced:Int,introPrice:Double) {
        self.title = title
        self.hardWareType = hardWareType
        self.yearIntroduced = yearIntroduced
        self.introPrice = introPrice
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: Product.CoderKeys.nameKey.rawValue) as! String
        hardWareType = aDecoder.decodeObject(forKey: Product.CoderKeys.typeKey.rawValue) as! String
        yearIntroduced = aDecoder.decodeInteger(forKey: Product.CoderKeys.yearKey.rawValue)
        introPrice = aDecoder.decodeDouble(forKey: Product.CoderKeys.priceKey.rawValue)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Product.CoderKeys.nameKey.rawValue)
        aCoder.encode(hardWareType, forKey: Product.CoderKeys.typeKey.rawValue)
        aCoder.encode(yearIntroduced, forKey: Product.CoderKeys.yearKey.rawValue)
        aCoder.encode(introPrice, forKey: Product.CoderKeys.priceKey.rawValue)
    }
}
