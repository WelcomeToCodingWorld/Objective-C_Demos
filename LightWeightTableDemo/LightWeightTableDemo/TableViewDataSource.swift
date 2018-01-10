//
//  TableViewDataSource.swift
//  LightWeightTableDemo
//
//  Created by zz on 04/01/2018.
//  Copyright © 2018 com.lesta. All rights reserved.
//

import UIKit


protocol TableDataSourceDelegate:class {
    associatedtype Item
    associatedtype Cell:UITableViewCell
    func configure(_ cell:Cell,with item:Item ,indexPath:IndexPath)
}

protocol Toggle {
    var selected:Bool {get set}
}

extension Toggle {
    var selected:Bool {
        get {
            return false
        }
        set {
            
        }
    }
}



class TableViewDataSource<DataSource:DataSourceProtocol,Delegate:TableDataSourceDelegate>: NSObject,UITableViewDataSource where DataSource.Item == Delegate.Item {
    
    enum SectionOpenStyle {
        case none,single,multiple
    }
    
    //section handler support
    var needSectionToggle = false
    var sectionOpenStyle:SectionOpenStyle = .none
    var sectionOpenStatus : [Bool]?
    var currentOpenSection:Int = -1
    
    // section index support
    var needSectionIndex = false

    var dataSource : DataSource
    var delegate: Delegate
    weak var tableView:UITableView!
    var tableEditingController:TableCellEditingController?
    var reuseIdentifier:String
    init(table:UITableView,delegate:Delegate,dataSource:DataSource,reuseIdentifier:String) {
        self.tableView = table
        self.delegate = delegate
        self.dataSource = dataSource
        self.reuseIdentifier = reuseIdentifier
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if needSectionToggle {
            if let open = sectionOpenStatus?[section] {
                return open ? dataSource.numberOfItems(inSection: section) : 0
            }
        }
        return dataSource.numberOfItems(inSection: section)
    }
    
    // MARK:- SectionToggleSupport
    func open(_ open:Bool, section:Int) {
        if sectionOpenStyle == .none {
            return
        }
        if open {//ask to open
            if currentOpenSection == section  {//already open
                return
            }else {//open
                if sectionOpenStyle == .single {
                    if currentOpenSection >= 0 {
                        sectionOpenStatus?[currentOpenSection] = false
                    }
                }
                currentOpenSection = section
            }
            
        }else {//ask to close
            if let status = sectionOpenStatus?[section] {
                if false == status {//already close
                    return
                }else {//close
                    sectionOpenStatus?[section] = false
                    currentOpenSection = -1
                }
            }
        }
        sectionOpenStatus?[section] = open
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Delegate.Cell else {  fatalError("can not dequeue a cell") }
        let item = dataSource.item(atIndexPath: indexPath)!
        delegate.configure(cell, with:item , indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.headerTitle(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.footerTitle(in: section)
    }
    
    // MARK:- TableEdit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let editController = tableEditingController {
            return editController.canEditRow(tableView, indexPath)
        }else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableEditingController?.commitEditing(tableView, editingStyle, indexPath)
    }
    
    // MARK:- SectionIndex
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSource.indices
    }
}

// MARK:-  adding constraint: CellFactory.View == UITableViewCell,cause warning as follows:

//1.Redundant superclass constraint 'CellFactory.View.ParentView' : 'UIView'
//2.Redundant superclass constraint 'CellFactory.View.ParentView.ReusableViewType' : 'UIView'
//3.Redundant superclass constraint 'CellFactory.View' : 'UIView'

//1. Same-type constraint 'CellFactory.View.ParentView' == 'UITableViewCell.ParentView' (aka 'UITableView') implied here
//2. Same-type constraint 'CellFactory.View.ParentView.ReusableViewType' == 'UITableView.ReusableViewType' (aka 'UITableViewCell') implied here
//3. Same-type constraint 'CellFactory.View' == 'UITableViewCell' written here
class TableViewDataSourceProvider<DataSource:DataSourceProtocol,CellFactory:ReusableViewFactory>: NSObject,UITableViewDataSource where DataSource.Item == CellFactory.Item,CellFactory.View == UITableViewCell {
    var dataSource : DataSource
    var cellFactory: CellFactory
    weak var tableView:UITableView!
    var tableEditingController: TableCellEditingController?
    var tableMovingController: TableCellMovingController?
    init(table:UITableView,cellFactory:CellFactory,dataSource:DataSource,reuseIdentifier:String) {
        self.tableView = table
        self.cellFactory = cellFactory
        self.dataSource = dataSource
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfItems(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource.item(atIndexPath: indexPath)!
        return cellFactory.tableCell(forItem: item, tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.headerTitle(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.footerTitle(in: section)
    }
    
    // MARK:- EditingSupport
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let editController = tableEditingController {
            return editController.canEditRow(tableView, indexPath)
        }else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableEditingController?.commitEditing(tableView, editingStyle, indexPath)
    }
    
    // MARK:- MovingSupport
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if let moveController = tableMovingController  {
            return moveController.canMoveRow(tableView, indexPath)
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableMovingController?.moveRow(tableView, sourceIndexPath, destinationIndexPath)
    }
}



class TableViewDataSourceProviderr<DataSource:DataSourceProtocol,CellFactory:ReusableViewFactory>: NSObject,UITableViewDataSource where DataSource.Item == CellFactory.Item {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK:- Redundant superclass constraint test
protocol S where Self:UIView {
    associatedtype Parent:P
}

protocol P where Self:UIView {
    associatedtype View:S
}

extension UIButton:P {
    typealias View = UILabel
}

extension UILabel:S {
    typealias Parent = UIButton
}

class D<T:P> where T.View == UILabel{
    
}

