//
//  ViewController.swift
//  UserPreferencesDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let locale = NSLocale.current
        let code = locale.languageCode!
        print(code)
        let language = locale.localizedString(forLanguageCode: code)!
        
        print("\(language)")
        
        let center = NotificationCenter.default
        center.addObserver(forName:NSLocale.currentLocaleDidChangeNotification, object: nil, queue: OperationQueue.main) { (notification:Notification) in
            print(notification.userInfo!)
        }
    }
    
    
    
    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self, name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

