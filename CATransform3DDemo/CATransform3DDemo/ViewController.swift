//
//  ViewController.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/8/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sourceTypes = CGImageSourceCopyTypeIdentifiers()
        CFShow(sourceTypes)
        
        let destinationTypes = CGImageDestinationCopyTypeIdentifiers()
        CFShow(destinationTypes)
        
    }
    
    lazy var image = {
        let url = URL(fileURLWithPath: "")
        let myImage : CGImage?
        let myImageSource : CGImageSource?
        var myOptions : CFDictionary?
        var myKeys = [UnsafeMutablePointer<CFString>]()
        var myValues = [UnsafeMutablePointer<CFBoolean>]()
        let cacheOptionPointer = UnsafeMutablePointer<CFString>.allocate(capacity: CFStringGetLength(kCGImageSourceShouldCache))
        cacheOptionPointer.initialize(to: kCGImageSourceShouldCache)
        
        let floatOptionPointer = UnsafeMutablePointer<CFString>.allocate(capacity: CFStringGetLength(kCGImageSourceShouldAllowFloat))
        floatOptionPointer.initialize(to: kCGImageSourceShouldAllowFloat)
        
        
        let boolOptionPointer = UnsafeMutablePointer<CFBoolean>.allocate(capacity: 1)
        boolOptionPointer.initialize(to: kCFBooleanTrue)
        
        
        myKeys.append(cacheOptionPointer)
        myValues.append(boolOptionPointer)
        myKeys.append(floatOptionPointer)
        myValues.append(boolOptionPointer)
        
        let keysPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: myKeys.count)
        
        let valuesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: myValues.count)
        
        
//        Cannot convert value of type 'CFDictionaryKeyCallBacks' to expected argument type 'UnsafePointer<CFDictionaryKeyCallBacks>!'
//        let mutablekeyCallBackPointer = UnsafeMutablePointer<CFDictionaryKeyCallBacks>.allocate(capacity: 4).initialize(to: kCFTypeDictionaryKeyCallBacks)
        
//        let keyCallBack = UnsafePointer<CFDictionaryKeyCallBacks>.init(mutablekeyCallBackPointer)
        
        
//        myOptions = CFDictionaryCreate(nil, keysPointer, valuesPointer, 2, mutablekeyCallBackPointer, kCFTypeDictionaryValueCallBacks)
        
        
        
//        Cannot convert value of type 'UnsafeMutablePointer<CFString>' to expected argument type 'UnsafeMutablePointer<CFString?>'
        
        
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

