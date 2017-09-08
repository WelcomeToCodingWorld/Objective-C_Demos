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
        
        var key1:UnsafeMutablePointer<CFString> = UnsafeMutablePointer.allocate(capacity: 1)
        
        key1.initialize(to: kCGImageSourceShouldCache, count: 1)
        
        var key2:UnsafeMutablePointer<CFString> = UnsafeMutablePointer.allocate(capacity: 1)
        
        key2.initialize(to: kCGImageSourceShouldAllowFloat, count: 1)
        
        let value1:UnsafeMutablePointer<CFBoolean> = UnsafeMutablePointer.allocate(capacity: 1)
        
        value1.initialize(to: kCFBooleanTrue, count: 1)
        
        
        let value2:UnsafeMutablePointer<CFBoolean> = UnsafeMutablePointer.allocate(capacity: 1)
        
        value2.initialize(to: kCFBooleanTrue, count: 1)
        var myKeys = [key1,key2]
        let myValues = [value1,value2]
        
        var keyPointer:UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        keyPointer.initialize(to: myKeys, count: 1)
        
        var valuePointer : UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        
        keyPointer.initialize(to: myValues, count: 1)
        
        

        
        var callBackKeyPointer : UnsafeMutablePointer<CFDictionaryKeyCallBacks> = UnsafeMutablePointer.allocate(capacity: 1)
        callBackKeyPointer.initialize(to: kCFTypeDictionaryKeyCallBacks, count: 1)
        
        var callBackValuePointer : UnsafeMutablePointer<CFDictionaryValueCallBacks> = UnsafeMutablePointer.allocate(capacity: 1)
        callBackValuePointer.initialize(to: kCFTypeDictionaryValueCallBacks, count: 1)
        
        
        myOptions = CFDictionaryCreate(nil, keyPointer, valuePointer, 2, callBackKeyPointer, callBackValuePointer)

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

