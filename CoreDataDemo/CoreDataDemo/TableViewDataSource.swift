//
//  TableViewDataSource.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData

protocol TableViewDataSourceDelegate:class {
    associatedtype Object : NSFetchRequestResult
    associatedtype Cell : UITableViewCell
    func configure(_ cell:Cell ,with object:Object)
}

class TableViewDataSource<Delegate:TableViewDataSourceDelegate>:NSObject,UITableViewDataSource,NSFetchedResultsControllerDelegate {
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    
    
    required init(tableView:UITableView ,cellIdentifier:String,fetchResultController:NSFetchedResultsController<Object>,delegate:Delegate) {
        self.tableView = tableView
        self.cellIdentifier = cellIdentifier
        self.fetchResultController = fetchResultController
        self.delegate = delegate
        super.init()
        fetchResultController.delegate = self
        tableView.dataSource = self
        try! fetchResultController.performFetch()
        tableView.reloadData()
    }
    
    func objectAtIndexPath(_ indexPath:IndexPath)->Object {
        return fetchResultController.object(at: indexPath)
    }
    
    var selectedObject:Object?{
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }
        return objectAtIndexPath(indexPath)
    }
    
    // MARK: Private
    fileprivate let tableView:UITableView
    fileprivate let fetchResultController:NSFetchedResultsController<Object>
    fileprivate let cellIdentifier:String
    fileprivate weak var delegate:Delegate!
    
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchResultController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = fetchResultController.object(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell else {
            fatalError("Unexpected cell type at \(indexPath)")
        }
        delegate.configure(cell, with: object)
        return cell
    }
    
    // MARK:- NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else {
                fatalError("new index Path should not be nil")
            }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else {
                fatalError("index path should not be  nil")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else {
                fatalError("index path should not be nil")
            }
            guard let cell = tableView.cellForRow(at: indexPath) as? Cell else{
                return
            }
            let object = objectAtIndexPath(indexPath)
            delegate.configure(cell, with: object)
            
        case .move:
            guard let indexPath = newIndexPath else {
                fatalError("index path should not be  nil")
            }
            guard let newIndexPath = newIndexPath else {
                fatalError("new index path should not be nil")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}



