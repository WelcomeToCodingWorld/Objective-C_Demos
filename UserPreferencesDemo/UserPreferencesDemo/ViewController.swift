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
        let locale = NSLocale(localeIdentifier: "en_CN")
        
        if let countyCode = locale.countryCode,let currencyCode = locale.currencyCode {
            print("ContryCode is \(countyCode)\n CurrencyCode is \(currencyCode)")
        }
        print("LanguageCode is \(locale.languageCode)\n ")
        

        
//        print(NSLocale.availableLocaleIdentifiers)
        print(NSLocale.components(fromLocaleIdentifier: "zh-Hant_HK"))
        
        if let currency = locale.localizedString(forCurrencyCode: "HKD") , let district = locale.localizedString(forCountryCode: "HK") , let language = locale.localizedString(forLanguageCode: "zh-Hant") ,let script = locale.localizedString(forScriptCode: "Hant") , let calender = locale.localizedString(forCalendarIdentifier: "chinese"){
            print("currency is \(currency)\n district is \(district)\n language is  \(language)\n script is \(script)\n calendar is \(calender)")
        }
        
        print("\(NSLocale.preferredLanguages)")
        
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

