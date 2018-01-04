//
//  DataSource.swift
//  AppDemo
//
//  Created by zz on 22/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import UIKit

// MARK:- Protocol
protocol DataSourceProtocol {
    associatedtype Item
    func numberOfItems(inSection section:Int) -> Int
    func numberOfSections() -> Int
    func items(in section:Int) -> [Item]?
    func item(atRow row:Int, inSection secton: Int) -> Item?
    func headerTitle(in section:Int) -> String?
    func footerTitle(in section:Int) -> String?
}


extension DataSourceProtocol {
    func item(atIndexPath indexPath:IndexPath) -> Item? {
        return item(atRow: indexPath.row, inSection: indexPath.section)
    }
}

// MARK:- Concrete
struct DataSource<S:SectionInfo>:DataSourceProtocol {
    typealias Item = S.Item
    
    var sections:[S]
    func numberOfItems(inSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func items(in section: Int) -> [S.Item]? {
        return sections[section].items
    }
    
    func item(atRow row: Int, inSection secton: Int) -> S.Item? {
        return sections[secton].items[row]
    }
    
    func headerTitle(in section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    func footerTitle(in section: Int) -> String? {
        return sections[section].footerTitle
    }
    
    
    mutating func insert(item:S.Item, at indexPath:IndexPath) {
        insert(item: item, atRow: indexPath.row, inSection: indexPath.section)
    }
    
    mutating func append(item:S.Item, in section:Int) {
        guard let items = items(in: section) else { return }
        insert(item: item, atRow: items.endIndex, inSection: section)
    }
    
    @discardableResult
    mutating func remove(at indexPath:IndexPath) -> S.Item? {
        return remove(atRow: indexPath.row, inSection: indexPath.section)
    }
    
    
    mutating func insert(item:S.Item, atRow row:Int, inSection section:Int) {
        guard section < numberOfSections(),row < numberOfItems(inSection: section) else {
            return
        }
        sections[section].items.insert(item, at: row)
    }
    
    @discardableResult
    mutating func remove(atRow row:Int, inSection section:Int) -> S.Item? {
        guard item(atRow: row, inSection: section) != nil else { return nil }
        return sections[section].items.remove(at: row)
    }
    
    subscript (index:Int) -> S {
        get {
            return sections[index]
        }
        
        set {
            sections[index] = newValue
        }
    }
    
}
