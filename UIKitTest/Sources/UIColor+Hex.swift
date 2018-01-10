//
//  UIColor+Hex.swift
//  AppDemo
//
//  Created by zz on 29/11/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import UIKit

extension UIColor {
    static func color(hexValue:Int)->UIColor {
        guard hexValue >= 0x000000 && hexValue <= 0xFFFFFF else {
            fatalError("the \(hexValue) hexValue you provide is invalid")
        }
        return UIColor.init(red: CGFloat((hexValue >> 16 & 0xFF))/255.0, green: CGFloat((hexValue >> 8 & 0xFF))/255.0, blue: CGFloat((hexValue & 0xFF))/255.0, alpha: 1.0)
    }
    
    static func color(hexString:String) -> UIColor {
        var hex = hexString.trimmingCharacters(in: CharacterSet.init(charactersIn: " "))
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            guard (hex.count == 5 || hex.count == 8) else{
                fatalError("The hexString\(hexString) you provide is not a hexadecimal convertible value")
            }
            
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.endIndex])
            if hex.count == 5 {
                hex = hex.map({ (character) in
                    return String([character,character])
                }).joined()
            }
            
        }else if hex.hasPrefix("#") {
            guard (hex.count == 4 || hex.count == 7) else{
                fatalError("The hexString\(hexString) you provide is not a hexadecimal convertible value")
            }
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)..<hex.endIndex])
        }else {
            guard (hex.count == 3 || hex.count == 6) else{
                fatalError("The hexString\(hexString) you provide is not a hexadecimal convertible value")
            }
            if hex.count == 3 {
                hex = hex.map({ (character) in
                    return String([character,character])
                }).joined()
            }
        }
        
        guard let  intValue = Int(hex,radix:16) else {
            fatalError("the \(hex) you provide is invalid")
        }
        printLog(intValue)
        return color(hexValue: intValue)
    }
}

