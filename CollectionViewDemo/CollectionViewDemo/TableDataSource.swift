//
//  TableDataSource.swift
//  CollectionViewDemo
//
//  Created by ari 李 on 07/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//


import UIKit
protocol TableDataSourceDelegate:class {
    associatedtype Object
    associatedtype Cell:UITableViewCell
    func configure(_ cell:Cell,with object:Object)
}

protocol DataConverter {
    associatedtype SectionObject:Hashable
}

class TableViewDataSource<Delegate:TableDataSourceDelegate,T:DataConverter>:NSObject,UITableViewDataSource {
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    typealias Key = T.SectionObject
    
    
    
    var data : T?{
        didSet{
            self.table.reloadData()
        }
    }
    
    var needSectionIndex = false
    var customSectionHeader = false
    var needSectionTitle = false
    var needCellEditable = false
    
    
    
    
    required init(table:UITableView,cellIdentifier:String,delegate:Delegate,data:T) {
        self.table = table
        self.cellIdentifier = cellIdentifier
        self.delegate = delegate
        self.data = data
        super.init()
        table.dataSource = self
        table.reloadData()
    }
    
    // MARK: Private
    fileprivate let table:UITableView
    fileprivate weak var delegate:Delegate!
    fileprivate let cellIdentifier:String
    
    fileprivate func objectAtIndexPath(_ indexPath:IndexPath) -> Object? {
        switch data {
        case is Array<Object>:
            let data = self.data as! Array<Object>
            return data[indexPath.row]
        case is Dictionary<String,Array<Any>>:
            let data = self.data as! Dictionary<String,Array<Any>>
            if let arr = data["value"] as? [[Object]]{
                return arr[indexPath.section][indexPath.row]
            }
            return nil
        default:
            return nil
        }
    }
    
    fileprivate var sectionTitlesArr:[String]?{
        if let data = self.data as? Dictionary<String,Array<Any>>{
            return data["key"] as? [String]
        }
        return nil
    }
    
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        switch data {
        case is Array<Object>:
            return 1
        case is Dictionary<String,Array<Any>>:
            return ((data as! Dictionary<String,Array<Any>>)["key"]?.count)!
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch data {
        case is Array<Object>:
            return (data as! Array<Object>).count
        case is Dictionary<String,Array<Any>>:
            let data = self.data as! Dictionary<String,Array<Any>>
            if let arr = data["value"] as? [[Object]]{
                return arr[section].count
            }
            return 0
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell
            else { fatalError("Unexpected cell type at \(indexPath)") }
        if let object = objectAtIndexPath(indexPath){
            delegate.configure(cell, with: object)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if customSectionHeader || !needSectionTitle {
            return nil
        }
        return sectionTitlesArr?[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if !needSectionIndex||self.data is Array<Object> {
            return nil
        }
        return sectionTitlesArr
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return needCellEditable
    }
}
