//
//  MainViewController.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UIViewController,SegueHandler {
    enum SegueIdentifier:String {
        case embedListVC = "embedListViewController"
        case embedMsgVC = "embedMsgViewController"
    }
    @IBOutlet var vcVSpaceConstraint: NSLayoutConstraint!
    var managedObjectContext : NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .embedListVC:
            guard let listVC = segue.destination as? ListViewController else {
                fatalError("wrong view controller type")
            }
            listVC.managedObjectContext = self.managedObjectContext
        case .embedMsgVC:
            guard let msgVC = segue.destination as? MsgViewController else {
                fatalError("wrong view controller type")
            }
            msgVC.managedObjectContext = self.managedObjectContext
        }
    }
 
    
    func zz_setBackgroundColor(color:UIColor) {
        
    }

}

extension MainViewController:UIScrollViewDelegate{
    
}
