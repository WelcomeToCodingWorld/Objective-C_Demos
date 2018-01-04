//
//  ReusableViewFactory.swift
//  AppDemo
//
//  Created by zz on 23/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import UIKit

enum ReusableViewType {
    case cell
    case supplementaryView(kind:String)
}

extension ReusableViewType:Equatable {
    static func ==(lhs: ReusableViewType, rhs: ReusableViewType) -> Bool {
        switch (lhs,rhs) {
        case (.cell,.cell):
            return true
        case (.supplementaryView(let kind1),.supplementaryView(let kind2)):
            return kind1 == kind2
        default:
            return false
        }
    }
}


// MARK:- Protocol
protocol ReusableViewFactory {
    associatedtype Item
    associatedtype View:ReusableView
    func reuseIdentifier(forItem:Item?,reusableViewType:ReusableViewType,indexPath:IndexPath) -> String
    @discardableResult
    func configure(view:View,withItem item:Item?,reusableViewType:ReusableViewType,reusableViewParent:View.ParentView,indexPath:IndexPath) -> View
}

extension ReusableViewFactory where View:UITableViewCell {
    func tableCell(forItem item:Item,tableView:UITableView,indexPath:IndexPath) -> View {
        let reuseId = reuseIdentifier(forItem: item, reusableViewType: .cell, indexPath: indexPath)
        let view = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! View
        return configure(view: view, withItem: item, reusableViewType: .cell, reusableViewParent: tableView, indexPath: indexPath)
    }
}

extension ReusableViewFactory where View:UICollectionViewCell {
    func collectionCell(forItem item:Item,collectionView:UICollectionView,indexPath:IndexPath)->View {
        let reuseId = reuseIdentifier(forItem: item, reusableViewType: .cell, indexPath: indexPath)
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! View
        return configure(view: view, withItem: item, reusableViewType: .cell, reusableViewParent: collectionView, indexPath: indexPath)
    }
}

extension ReusableViewFactory where View:UICollectionReusableView {
    func supplementaryView(forItem item:Item?,kind:String,collectionView:UICollectionView,indexPath:IndexPath) -> View {
        let reuseId = reuseIdentifier(forItem: item, reusableViewType: ReusableViewType.supplementaryView(kind: kind), indexPath: indexPath)
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseId, for: indexPath) as! View
        return configure(view: view, withItem: item, reusableViewType: ReusableViewType.supplementaryView(kind: kind), reusableViewParent: collectionView, indexPath: indexPath)
    }
}

// MARK:- Concrete
struct ViewFactory<Item,View:ReusableView> :ReusableViewFactory {
    typealias ViewConfigurator = (_ view:View,_ item:Item?,_ type:ReusableViewType,_ parent:View.ParentView,_ indexPath:IndexPath) -> View
    
    let reuseIdentifier : String
    let type : ReusableViewType
    let viewConfigurator : ViewConfigurator
    
    func reuseIdentifier(forItem: Item?, reusableViewType: ReusableViewType, indexPath: IndexPath) -> String {
        return reuseIdentifier
    }
    
    func configure(view: View, withItem item: Item?, reusableViewType: ReusableViewType, reusableViewParent: View.ParentView, indexPath: IndexPath) -> View {
        return viewConfigurator(view, item, reusableViewType, reusableViewParent, indexPath)
    }

    init(reuseIdentifier:String,type:ReusableViewType = .cell,viewConfigurator:@escaping ViewConfigurator) {
        self.reuseIdentifier = reuseIdentifier
        self.type = type
        self.viewConfigurator = viewConfigurator
    }
}
