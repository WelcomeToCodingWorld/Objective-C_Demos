//
//  DataSourceProvider.swift
//  AppDemo
//
//  Created by zz on 22/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import UIKit
//Associated type 'View' can only be used with a concrete type or generic parameter base
class DataSourceProvider<DataSource:DataSourceProtocol,CellFactory:ReusableViewFactory,SupplementaryViewFactory:ReusableViewFactory> where DataSource.Item == CellFactory.Item,CellFactory.Item == SupplementaryViewFactory.Item {
    var dataSource : DataSource
    let cellFactory : CellFactory
    let supplementaryViewFactory : SupplementaryViewFactory
    
    init(dataSource:DataSource,cellFactory:CellFactory,supplementaryViewFactory:SupplementaryViewFactory) {
        self.dataSource = dataSource
        self.cellFactory = cellFactory
        self.supplementaryViewFactory = supplementaryViewFactory
    }
    
    var bridgedDataSource : BridgedDataSource?
    var _tableEditingController : TableCellEditingController?
}

extension DataSourceProvider where CellFactory.View :UITableViewCell{
    var tableViewDataSource : UITableViewDataSource {
        if  bridgedDataSource == nil {
            bridgedDataSource = tableViewBridgedDataSource()
        }
        return bridgedDataSource!
    }
    
    var tableEditingController:TableCellEditingController? {
        get {
            return _tableEditingController
        }
        
        set{
            _tableEditingController = newValue
        }
    }
    
    func tableViewBridgedDataSource() -> BridgedDataSource {
        let bridgedDataSource = BridgedDataSource(numberOfSectionHandler: {[unowned self] () -> Int in
            return self.dataSource.numberOfSections()
        }) { [unowned self] (section) -> Int in
            return self.dataSource.numberOfItems(inSection: section)
        }
        
        bridgedDataSource.tableCellForRowAtIndexPath = {[unowned self](tableView,indexPath) in
            let item = self.dataSource.item(atIndexPath: indexPath)!
            return self.cellFactory.tableCell(forItem: item, tableView: tableView, indexPath: indexPath)
        }
        
        bridgedDataSource.tableTitleForHeaderInSection = {[unowned self] (section) in
            return self.dataSource.headerTitle(in: section)
        }
        
        bridgedDataSource.tableTitleForFooterInSection = {[unowned self] (section) in
            return self.dataSource.footerTitle(in: section)
        }
        
        bridgedDataSource.tableCellCanEdit = {[unowned self] (tableView,indexPath) in
            guard let controller = self.tableEditingController else { return false }
            return controller.canEditRow(tableView, indexPath)
        }
        
        bridgedDataSource.tableCommitEditingForRow = {[unowned self] (tableView,editingStyle,indexPath) in
            self.tableEditingController?.commitEditing(tableView, editingStyle, indexPath)
        }
        
        return bridgedDataSource
    }
}

extension DataSourceProvider where CellFactory.View: UICollectionViewCell, SupplementaryViewFactory.View: UICollectionReusableView {
    var collectionViewDataSource:UICollectionViewDataSource {
        if bridgedDataSource == nil {
            bridgedDataSource = collectionViewBridgedDataSource()
        }
        return bridgedDataSource!
    }
    
    func collectionViewBridgedDataSource() -> BridgedDataSource {
        let dataSource = BridgedDataSource(numberOfSectionHandler: {[unowned self] () -> Int in
            return self.dataSource.numberOfSections()
        }) {[unowned self] (section) -> Int in
            return self.dataSource.numberOfItems(inSection: section)
        }

        dataSource.collectionCellForItemAtIndexPath = {[unowned self] (collectionView,indexPath) in
            let item = self.dataSource.item(atIndexPath: indexPath)!
            return self.cellFactory.collectionCell(forItem: item, collectionView: collectionView, indexPath: indexPath)
        }
        
        dataSource.collectionSupplementaryViewAtIndexPath = {[unowned self] (collectionView, kind, indexPath) in
            var item : SupplementaryViewFactory.Item?
            if indexPath.section < self.dataSource.numberOfSections() {
                if indexPath.item < self.dataSource.numberOfItems(inSection: indexPath.section) {
                    item = self.dataSource.item(atIndexPath: indexPath)
                }
            }
            return self.cellFactory.supplementaryView(forItem: item, kind: kind, collectionView: collectionView, indexPath: indexPath)
        }
        return dataSource
    }
}
