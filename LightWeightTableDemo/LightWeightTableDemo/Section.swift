//
//  Section.swift
//  AppDemo
//
//  Created by zz on 23/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import Foundation

// MARK:- Protocol
protocol SectionInfo {
    associatedtype Item
    var items:[Item] {get set}
    var headerTitle:String? {get}
    var footerTitle:String? {get}
    var sectionIndex:String? {get}
}

extension SectionInfo {
    var sectionIndex:String? {
        return headerTitle
    }
}

// MARK:- Concrete
struct Section<Item>:SectionInfo {
    var items:[Item]
    let headerTitle: String?
    let footerTitle: String?
    
    init(items:[Item], headerTitle:String? = nil, footerTitle:String? = nil) {
        self.items = items
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
    
    init(items:Item..., headerTitle:String? = nil, footerTitle:String? = nil) {
        self.init(items: items, headerTitle: headerTitle, footerTitle: footerTitle)
    }
    
    subscript (index:Int) -> Item {
        get{
            return items[index]
        }
        
        set{
            items[index] = newValue
        }
    }
}
