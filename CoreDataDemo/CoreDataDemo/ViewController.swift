
//  ViewController.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,SegueHandler {
    
    var managedObjectContext : NSManagedObjectContext!
    
    
    // conform SegueHandler Protocol
    enum SegueIdentifier:String {
        case showMainVC = "showMainViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .showMainVC:
            guard let mainVC = segue.destination as? MainViewController else {
                fatalError("wrong view controller type")
            }
            mainVC.managedObjectContext = self.managedObjectContext
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

