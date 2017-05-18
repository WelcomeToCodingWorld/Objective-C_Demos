//
//  BaseTableViewController.swift
//  SearchControllerDemo
//
//  Created by zz on 2017/5/6.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    static let nibName = "TableCell"
    static let tableViewCellID = "CellID"
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: BaseTableViewController.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: BaseTableViewController.tableViewCellID)
    }
    
    
    func configCell(_ cell : UITableViewCell, forProduct product : Product) {
        cell.textLabel?.text = product.title
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.formatterBehavior = .default
        
        let priceString = numberFormatter.string(from: NSNumber(value:product.introPrice))
        cell.detailTextLabel?.text = "\(priceString!)|\(product.yearIntroduced)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
