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
        
        let myKeys = [kCGImageSourceShouldCache,kCGImageSourceShouldAllowFloat]
        let myValues = [kCFBooleanTrue,kCFBooleanTrue]
        
        var keyPointer:UnsafeRawPointer? = nil
        var valuePointer:UnsafeRawPointer? = nil
//        keyPointer = kCGImageSourceShouldCache
        
        
        
        
//        UnsafeMutablePointer<UnsafeRawPointer?>!   --- UnsafePointer<CFDictionaryKeyCallBacks>!
//        UnsafePointer<CFDictionaryValueCallBacks>!)
//        Cannot convert value of type '[CFString]' to expected argument type '[UnsafeRawPointer?]'
//        myOptions = CFDictionaryCreate(nil, &myKeys, &myValues, 2, kCGImageSourceShouldCache, kCFTypeDictionaryValueCallBacks)
        
        
        
        
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

