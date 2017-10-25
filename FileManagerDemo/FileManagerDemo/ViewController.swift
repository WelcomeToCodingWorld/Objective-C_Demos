//
//  ViewController.swift
//  FileManagerDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Bundle
        printLog("Bundle:\(Bundle.main.bundlePath)")
        
        // Do any additional setup after loading the view, typically from a nib.
        let fileMgr = FileManager.init()
        fileMgr.delegate = self
        
        let homeUrl = NSHomeDirectory()
        printLog("homeUrl:\(homeUrl)")
        
        
        //printerDescriptionDirectory ,userDirectory return nil
        //inputMethodsDirectory,applicationSupportDirectory reside in Library directory
        //demoApplicationDirectory,adminApplicationDirectory reside in Applications directory
        let testUrl = fileMgr.urls(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: .userDomainMask).first
        printLog("testUrl:\(testUrl as Optional)")
        
        
        
        local {
            var tempUrl : URL?
            if #available(iOS 10.0, *) {
                tempUrl = fileMgr.temporaryDirectory
            } else {
                // Fallback on earlier versions
                tempUrl = fileMgr.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
            }
            printLog("tempUrl:\(tempUrl as Optional)")
        }
        
        do {
            let libraryUrl = try fileMgr.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            printLog("libraryUrl:\(libraryUrl)")
        }catch {
            printLog(error)
        }
        
        
        do {
            let doucmentUrl = try fileMgr.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            printLog("doucmentUrl:\(doucmentUrl)")
        }catch {
            printLog(error)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:FileManagerDelegate {
    func fileManager(_ fileManager: FileManager, shouldCopyItemAt srcURL: URL, to dstURL: URL) -> Bool {
        return true
    }

    func fileManager(_ fileManager: FileManager, shouldCopyItemAtPath srcPath: String, toPath dstPath: String) -> Bool {
        return true
    }
    
    
}

