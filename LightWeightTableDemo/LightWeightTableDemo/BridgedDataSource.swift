//
//  BridgedDataSource.swift
//  AppDemo
//
//  Created by zz on 22/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import UIKit

typealias NumberOfSectionHandler = () -> Int
typealias NumberOfItemsInSectionHandler = (Int) -> Int

typealias CollectionCellForItemAtIndexPathHanlder = (UICollectionView,IndexPath) -> UICollectionViewCell
typealias CollectonSupplementaryViewAtIndexPathHandler = (UICollectionView,String,IndexPath) -> UICollectionReusableView

typealias TableCellForRowAtIndexPathHandler = (UITableView,IndexPath) -> UITableViewCell
typealias TableTitleForHeaderInSectionHandler = (Int) -> String?
typealias TableTitleForFooterInSectionHandler = (Int) -> String?

typealias TableCellCanEditHandler = (UITableView,IndexPath) -> Bool
typealias TableCommitEditingHandler = (UITableView,UITableViewCellEditingStyle,IndexPath) -> Void


final class BridgedDataSource: NSObject {
    let numberOfSections : NumberOfSectionHandler
    let numberOfItemsInSection : NumberOfItemsInSectionHandler
    
    var collectionCellForItemAtIndexPath : CollectionCellForItemAtIndexPathHanlder?
    var collectionSupplementaryViewAtIndexPath : CollectonSupplementaryViewAtIndexPathHandler?
    
    var tableCellForRowAtIndexPath : TableCellForRowAtIndexPathHandler?
    var tableTitleForHeaderInSection : TableTitleForHeaderInSectionHandler?
    var tableTitleForFooterInSection : TableTitleForFooterInSectionHandler?
    
    var tableCellCanEdit : TableCellCanEditHandler?
    var tableCommitEditingForRow : TableCommitEditingHandler?
    
    init(numberOfSectionHandler:@escaping NumberOfSectionHandler, numberOfItemsInSectionHandler:@escaping NumberOfItemsInSectionHandler) {
        self.numberOfSections = numberOfSectionHandler
        self.numberOfItemsInSection = numberOfItemsInSectionHandler
    }
}

extension BridgedDataSource:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let closure = collectionCellForItemAtIndexPath else {
            fatalError("you didn't provide a collectionCellGeneratingClosure")
        }
        return closure(collectionView,indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let closure = collectionSupplementaryViewAtIndexPath else {
            fatalError("you didn't provide a collectionSupplementaryViewGeneratingClosure")
        }
        return closure(collectionView,kind, indexPath)
    }
}


extension BridgedDataSource:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItemsInSection(section)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableCellForRowAtIndexPath!(tableView,indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitleForHeaderInSection?(section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return tableTitleForFooterInSection?(section)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let closure = tableCellCanEdit {
            return closure(tableView,indexPath)
        }else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let closure = tableCommitEditingForRow {
            closure(tableView,editingStyle,indexPath)
        }
    }
}


