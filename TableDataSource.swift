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
    func configure(_ cell:Cell,with object:Object ,indexPath:IndexPath)
}

class TableDataSource<Delegate:TableDataSourceDelegate,DataType>:NSObject,UITableViewDataSource {
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    var data : DataType?{
        didSet{
            self.table.reloadData()
        }
    }
    enum SectionOpenStyle {
        case none,single,multiple
    }
    var needSectionIndex = false
    var customSectionHeader = false
    var needSectionTitle = false
    var needCellEditable = false
    var needSectionToggle = false//是否需要区打开的处理
    var sectionOpenStatus : [Bool]?//区打开状态纪录数组
    var sectionOpenStyle:SectionOpenStyle = .none
    var currentOpenSection:Int = -1
    
    required init(table:UITableView,cellIdentifier:String,delegate:Delegate,data:DataType) {
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
            if let titles = data["key"] {
                guard let titles = titles as? [String] else {
                    fatalError("The sectionHeaderTitleType you provide is incorrect")
                }
                return titles
            }
        }
        return nil
    }
    
    func open(_ open:Bool, section:Int) {
        if sectionOpenStyle == .none {
            return
        }
        if open {//要打开区
            if currentOpenSection == section  {//要打开的区已经打开
                return
            }else {//打开该区
                if sectionOpenStyle == .single {
                    if currentOpenSection >= 0 {
                        sectionOpenStatus?[currentOpenSection] = false
                    }
                }
                currentOpenSection = section
            }
            
        }else {//要关闭区
            if let status = sectionOpenStatus?[section] {
                if false == status {//要关闭的区已经关闭
                    return
                }else {//关闭该区
                    sectionOpenStatus?[section] = false
                    currentOpenSection = -1
                }
            }
        }
        sectionOpenStatus?[section] = open
    }
    
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        switch data {
        case is Array<Object>:
            return 1
        case is Dictionary<String,Array<Any>>:
            if let sections = (data as! Dictionary<String,Array<Any>>)["key"] {
                if needSectionToggle {//初始化区打开状态数组
                    if sectionOpenStatus == nil {
                        sectionOpenStatus = Array(repeating: false, count: sections.count)
                    }
                }
                return sections.count
                }
            return 0
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
                if needSectionToggle {//处理区打开
                    if let open = sectionOpenStatus?[section] {
                        return open ? arr[section].count : 0
                    }
                }
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
            delegate.configure(cell, with: object,indexPath: indexPath)
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
