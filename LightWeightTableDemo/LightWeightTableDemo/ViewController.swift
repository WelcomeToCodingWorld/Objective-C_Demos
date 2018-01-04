//
//  ViewController.swift
//  LightWeightTableDemo
//
//  Created by zz on 04/01/2018.
//  Copyright © 2018 com.lesta. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    //  When declared without lazy:  Instance member 'table' cannot be used on type 'ViewController'
    // Yeah,it may because a stored property cann't depend on another.
    lazy var tableDataSource:TableViewDataSource<DataSource<Section<Mobile>>,ViewController> = {
        let section0 = Section(items: Mobile(owner: "Lee",no:"15233333"),Mobile(owner: "Chen", no:"17856666"))
        let dataSource = DataSource(sections: [section0])
        return TableViewDataSource(table: table, delegate: self, dataSource: dataSource, reuseIdentifier: "Cell")
    }()
    
    lazy var dsProvider:TableViewDataSourceProvider<DataSource<Section<Mobile>>,ViewFactory<Mobile,UITableViewCell>> = {
        let section0 = Section(items: Mobile(owner: "Lee",no:"15233333"),Mobile(owner: "Chen", no:"17856666"))
        let dataSource = DataSource(sections: [section0])
        
        
        typealias TableCellFactory = ViewFactory<Mobile,UITableViewCell>
        typealias TableDataSourceProvider = DataSourceProvider<DataSource<Section<Mobile>>,TableCellFactory,TableCellFactory>
        
        
        let factory = TableCellFactory(reuseIdentifier: "Cell") { (cell, mobile, type, table, indexPath) -> UITableViewCell in
            return cell
        }
        return TableViewDataSourceProvider(table: table, cellFactory: factory, dataSource: dataSource, reuseIdentifier: "Cell")
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for test
        // but here, it warns nothing
        let dsProvider:TableViewDataSourceProvider<DataSource<Section<Mobile>>,ViewFactory<Mobile,UITableViewCell>> = {
            let section0 = Section(items: Mobile(owner: "Lee",no:"15233333"),Mobile(owner: "Chen", no:"17856666"))
            let dataSource = DataSource(sections: [section0])
            
            
            typealias TableCellFactory = ViewFactory<Mobile,UITableViewCell>
            typealias TableDataSourceProvider = DataSourceProvider<DataSource<Section<Mobile>>,TableCellFactory,TableCellFactory>
            
            
            let factory = TableCellFactory(reuseIdentifier: "Cell") { (cell, mobile, type, table, indexPath) -> UITableViewCell in
                return cell
            }
            return TableViewDataSourceProvider(table: table, cellFactory: factory, dataSource: dataSource, reuseIdentifier: "Cell")
            
        }()
        
        dsProvider.tableEditingController = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let section0 = Section(items: Mobile(owner: "Lee",no:"15233333"),Mobile(owner: "Chen", no:"17856666"))
        let dataSource = DataSource(sections: [section0])
        
        
        typealias TableCellFactory = ViewFactory<Mobile,UITableViewCell>
        typealias TableDataSourceProvider = DataSourceProvider<DataSource<Section<Mobile>>,TableCellFactory,TableCellFactory>
        
        
        let factory = TableCellFactory(reuseIdentifier: "Cell") { (cell, mobile, type, table, indexPath) -> UITableViewCell in
            return cell
        }

        let dataSourceProvider = TableDataSourceProvider(dataSource: dataSource, cellFactory: factory, supplementaryViewFactory: factory)
        dataSourceProvider.tableEditingController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

struct Mobile {
    var owner:String
    var no:String
}

extension ViewController:TableDataSourceDelegate {
    func configure(_ cell: UITableViewCell, with item: Mobile, indexPath: IndexPath) {
        cell.textLabel?.text = item.owner
        cell.detailTextLabel?.text = item.no
    }
}

extension ViewController:TableCellEditingController {
    var commitEditing: TableCellEditingController.CommitEditingHandler {
        return {(table,editingStyle,indexPath) in
            
        }
    }
    
    var canEditRow: TableCellEditingController.CanEditRowConfigurator  {
        return {(table,indexPath) in
            return true
        }
    }
}
