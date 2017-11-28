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
        let testUrl = fileMgr.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        printLog("testUrl:\(testUrl as Optional)")
        
        
        
        local {
            if #available(iOS 10.0, *) {
                let tempUrl = fileMgr.temporaryDirectory
                printLog("tempUrl:\(tempUrl as Optional)")
            } else {
                // Fallback on earlier versions
                let tempUrl = NSTemporaryDirectory()
                printLog("tempUrl:\(tempUrl)")
            }
        }
        
        local {
            let cacheUrl = fileMgr.urls(for: .cachesDirectory, in: .userDomainMask).first
            printLog("cacheUrl:\(cacheUrl as Optional)")
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
        
        delay(2) {
            printLog("This will be print 2 seconds later")
        }
        
        let task = delay(5) {
            printLog("If not cancel,this gonna be print 5 seconds later")
        }
        
        cancel(task)
        
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

