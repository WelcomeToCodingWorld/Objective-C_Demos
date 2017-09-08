//
//  ViewController.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/8/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageUrl = "/Users/arili/Desktop/screenshot-a.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let sourceTypes = CGImageSourceCopyTypeIdentifiers()
//        CFShow(sourceTypes)
//
//        let destinationTypes = CGImageDestinationCopyTypeIdentifiers()
//        CFShow(destinationTypes)
        guard image != nil else {
            print("image creat failed")
            return;
        }
        
    }
    
    var image : CGImage? {
        let url = URL(fileURLWithPath: imageUrl)
        let myImage : CGImage?
        let myImageSource : CGImageSource?
        var myOptions : CFDictionary?
        
        let key1:UnsafeMutablePointer<CFString> = UnsafeMutablePointer.allocate(capacity: 1)
        
        key1.initialize(to: kCGImageSourceShouldCache, count: 1)
        
        let key2:UnsafeMutablePointer<CFString> = UnsafeMutablePointer.allocate(capacity: 1)
        
        key2.initialize(to: kCGImageSourceShouldAllowFloat, count: 1)
        
        let value1:UnsafeMutablePointer<CFBoolean> = UnsafeMutablePointer.allocate(capacity: 1)
        
        value1.initialize(to: kCFBooleanTrue, count: 1)
        
        
        let value2:UnsafeMutablePointer<CFBoolean> = UnsafeMutablePointer.allocate(capacity: 1)
        
        value2.initialize(to: kCFBooleanTrue, count: 1)
        let myKeys = [key1,key2]
        let myValues = [value1,value2]
        
        let keyPointer:UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        keyPointer.initialize(to: myKeys, count: 1)
        
        let valuePointer : UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        
        keyPointer.initialize(to: myValues, count: 1)
        
        

        
        let callBackKeyPointer : UnsafeMutablePointer<CFDictionaryKeyCallBacks> = UnsafeMutablePointer.allocate(capacity: 1)
        callBackKeyPointer.initialize(to: kCFTypeDictionaryKeyCallBacks, count: 1)
        
        let callBackValuePointer : UnsafeMutablePointer<CFDictionaryValueCallBacks> = UnsafeMutablePointer.allocate(capacity: 1)
        callBackValuePointer.initialize(to: kCFTypeDictionaryValueCallBacks, count: 1)
        
        
        myOptions = CFDictionaryCreate(nil, keyPointer, valuePointer, 2, callBackKeyPointer, callBackValuePointer)
        
        myImageSource = CGImageSourceCreateWithURL(url as CFURL, myOptions)
        guard myImageSource != nil else {
            print("image source is null")
            return nil;
        }
        
        myImage = CGImageSourceCreateImageAtIndex(myImageSource!, 0, nil)
        
        guard myImage != nil else {
            print("image not create from image source")
            return nil;
        }
        
        key1.deinitialize()
        key1.deallocate(capacity: 1)
        key2.deinitialize()
        key2.deallocate(capacity: 1)
        value1.deinitialize()
        value1.deallocate(capacity: 1)
        value2.deinitialize()
        value2.deallocate(capacity: 1)
        keyPointer.deinitialize()
        keyPointer.deallocate(capacity: 1)
        valuePointer.deinitialize()
        valuePointer.deallocate(capacity: 1)
        callBackKeyPointer.deinitialize()
        callBackKeyPointer.deallocate(capacity: 1)
        callBackValuePointer.deinitialize()
        callBackValuePointer.deallocate(capacity: 1)
        
        return myImage!

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

