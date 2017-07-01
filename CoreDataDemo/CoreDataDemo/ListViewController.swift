//
//  ListViewController.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {

    var managedObjectContext:NSManagedObjectContext!
    let cellID = "BusinessCard"
    fileprivate var dataSource:TableViewDataSource<ListViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        let request = Person.sortedFetchRequest
        request.fetchBatchSize = 20
        request.returnsObjectsAsFaults = false
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        dataSource = TableViewDataSource(tableView: tableView, cellIdentifier: cellID, fetchResultController: frc, delegate: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController:TableViewDataSourceDelegate{
    func configure(_ cell: BusinessCardTableViewCell , with object: Person) {
        cell.config(with: object)
    }
}

