//
//  LabColor.swift
//  KVODemo
//
//  Created by zz on 2017/6/14.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import Foundation
import UIKit

let D65TristimulusValues:[Double] = [95.047, 100.0, 108.883];

func inverseF(_ t: Double)-> Double{
    return ((t > 6.0/29.0) ?t*t*t : 3.0*(6.0/29.0)*(6.0/29.0)*(t-4.0/29.0))
}

class LabColor : NSObject {
    @objc var lComponent : Double = 75 + Double(arc4random_uniform(200)) * 0.1 - 10.0
    @objc var aComponent : Double = 20 + Double(arc4random_uniform(200)) * 0.1 - 10.0
    @objc var bComponent : Double = 30 + Double(arc4random_uniform(200)) * 0.1 - 10.0
    
    var redComponent : Double{
        return D65TristimulusValues[0] * inverseF(1.0/116.0 * (self.lComponent + 16))
    }
    var greenComponent : Double{
        return D65TristimulusValues[1] * inverseF(1.0/116.0 * (self.lComponent + 16.0) + 1.0/500.0 * self.aComponent)
    }
    var blueComponent : Double{
        return D65TristimulusValues[2] * inverseF(1.0/116.0 * (self.lComponent + 16) - 1.0/200.0*self.bComponent);
    }
    
    @objc var color : UIColor{
        return UIColor.init(colorLiteralRed: Float(self.redComponent*0.01), green: Float(self.greenComponent*0.01), blue: Float(self.blueComponent*0.01), alpha: 1.0)
    }
    
    class func keyPathsForValuesAffectingColor() -> Set<String>{
        return Set(arrayLiteral: "redComponent","greenComponent","blueComponent")
    }
    
    class func keyPathsForValuesAffectingRedComponent() -> Set<String>{
        return Set(arrayLiteral: "lComponent")
    }
    
    class func keyPathsForValuesAffectingGreenComponent() -> Set<String>{
        return Set(arrayLiteral: "lComponent","aComponent")
    }
    
    class func keyPathsForValuesAffectingBlueComponent() -> Set<String>{
        return Set(arrayLiteral: "lComponent","bComponent")
    }
    
    
//    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String>{
//        if key == "color"{
//            return Set(arrayLiteral: "redComponent","greenComponent","blueComponent")
//        }else if key == "redComponent"{
//            return Set(arrayLiteral: "lComponent")
//        }else if key == "greenComponent"{
//            return Set(arrayLiteral: "lComponent","aComponent")
//        }else if key == "blueComponent"{
//            return Set(arrayLiteral: "lComponent","bComponent")
//        }else{
//            return super.keyPathsForValuesAffectingValue(forKey: key)
//        }
//    }
}
