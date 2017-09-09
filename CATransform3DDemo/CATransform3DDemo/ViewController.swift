//
//  ViewController.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/8/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    https://forums.developer.apple.com/thread/68897
    var imageUrl : URL?
    
    @IBOutlet var imageView: UIImageView!
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
        imageView.image = UIImage.init(cgImage: image!)
    }
    
    
    var image : CGImage? {
        if let bundle = Bundle.init(url: Bundle.main.url(forResource: "image", withExtension: "bundle")!){
            imageUrl = bundle.url(forResource: "test", withExtension: "png")
            guard imageUrl != nil else{
                fatalError("the url is failed to create")
            }
            
        }else{
            fatalError("the bundle is not found")
        }
        let myImage : CGImage?
        let myImageSource : CGImageSource?
        var myOptions : CFDictionary?
        
        let valuePtr = UnsafeMutablePointer<CGSize>.allocate(capacity: 1)
        valuePtr.initialize(to: CGSize(width: 100, height: 100))
        
        
        let thumbnailSize = CFNumberCreate(kCFAllocatorDefault, CFNumberType.intType, valuePtr);

        let testKeys = [kCGImageSourceShouldCache,kCGImageSourceShouldAllowFloat]
        let testValues = [kCFBooleanTrue,kCFBooleanTrue]
        
        let thumbNailKeys = [kCGImageSourceCreateThumbnailWithTransform as CFTypeRef,kCGImageSourceCreateThumbnailFromImageIfAbsent as CFTypeRef,kCGImageSourceThumbnailMaxPixelSize as CFTypeRef]
        let thumbNailValues = [kCFBooleanTrue as CFTypeRef,kCFBooleanTrue as CFTypeRef,thumbnailSize as CFTypeRef]
        
        
        
        
        let keyPointer:UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        keyPointer.initialize(to: testKeys, count: 1)
        
        let valuePointer : UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        
        keyPointer.initialize(to: testValues, count: 1)
        
        
        
        let thumbNailKeyPointer:UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        keyPointer.initialize(to: thumbNailKeys, count: 1)
        
        let thumbNailValuePointer :  UnsafeMutablePointer<UnsafeRawPointer?> = UnsafeMutablePointer.allocate(capacity: 1)
        keyPointer.initialize(to: thumbNailValues, count: 1)
        
        
        
        let callBackKeyPointer : UnsafeMutablePointer<CFDictionaryKeyCallBacks> = UnsafeMutablePointer.allocate(capacity: 1)
        callBackKeyPointer.initialize(to: kCFTypeDictionaryKeyCallBacks, count: 1)
        
        let callBackValuePointer : UnsafeMutablePointer<CFDictionaryValueCallBacks> = UnsafeMutablePointer.allocate(capacity: 1)
        callBackValuePointer.initialize(to: kCFTypeDictionaryValueCallBacks, count: 1)
        
        guard thumbNailKeyPointer.pointee != nil,thumbNailValuePointer.pointee != nil else {
            print("the keyPointer or valuePointer is released")
            return nil
        }
        
//        myOptions = CFDictionaryCreate(kCFAllocatorDefault, keyPointer, valuePointer, 2, nil, nil)
        
        //for thumbNail
        myOptions = CFDictionaryCreate(kCFAllocatorDefault, thumbNailKeyPointer, thumbNailValuePointer, 3, nil, nil)
        guard myOptions != nil else {
            print("the myOption was failed to create")
            return nil
        }
        
        myImageSource = CGImageSourceCreateWithURL(imageUrl! as CFURL, myOptions)
        guard myImageSource != nil else {
            print("The image source is nil")
            return nil;
        }
        
        myImage = CGImageSourceCreateImageAtIndex(myImageSource!, 0, nil)
        
        guard myImage != nil else {
            print("Failed to create image from image source!")
            return nil;
        }
        
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

