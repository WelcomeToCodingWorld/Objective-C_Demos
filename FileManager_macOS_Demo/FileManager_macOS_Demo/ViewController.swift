//
//  ViewController.swift
//  FileManager_macOS_Demo
//
//  Created by zz on 21/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let fileMgr = FileManager.init()
        do {
            let url = try fileMgr.url(for: FileManager.SearchPathDirectory.developerDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            print(url)
        }catch {
            print(error.localizedDescription)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}



enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}



