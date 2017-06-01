
//  Test.swift
//  NotificationDemo
//
//  Created by zz on 2017/5/25.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class Test: NSObject {
    var kk:[String:Any] = [:]
    enum DataType : String{
        case Int
        case Text
        case float
        case double
    }
    
    
    static func getModel(attributes:Array<Dictionary<String , Any>>, resultClass: Swift.AnyClass?) {
        for dict in attributes {//每个字段的元信息字典
            let type = dict["type"] as! DataType
            switch type {
            case .Int:
                print("int")
            default:
                print("default")
            }
        }
    }
    
    
    
//    class SomeClass {
//        let someProperty: SomeType = {
//            // create a default value for someProperty inside this closure
//            // someValue must be of the same type as SomeType
//            return someValue
//        }()
//    }
    
    //Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
    //If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.

    
    enum TemperatureUnit: Character {
        case kelvin = "K", celsius = "C", fahrenheit = "F"
    }
    
    static func instantiateTest(){
//        if className.isSubclass(of: NSObject() as! AnyClass){
//            
//        }
//        let keyedValues = ["key1":"value1","key2":"value2","key3":"value3","key4":"value4"]
//        let z = T.setValuesForKeys(keyedValues)
//        print(z)
        
        
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
    }
    
    class DataImporter {
        /*
         DataImporter is a class to import data from an external file.
         The class is assumed to take a non-trivial amount of time to initialize.
         */
        var filename = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }
    
    class DataManager {
        lazy var importer = DataImporter()
        var data = [String]()
        // the DataManager class would provide data management functionality here
    }
    
    
}
