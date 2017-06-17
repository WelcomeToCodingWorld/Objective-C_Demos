//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,NSFetchedResultsControllerDelegate {
    var persistentContainer : NSPersistentContainer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let dataController = DataController { container in
            self.persistentContainer = container
        }
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: self.persistentContainer.viewContext)
        
        //save
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        //fetch and filter
        let moc = self.persistentContainer.viewContext
        let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        let firstName = "Trevor"
        employeesFetch.predicate = NSPredicate(format: "firstName == %@", firstName)
        do {
            let fetchedEmployees = try moc.fetch(employeesFetch) as! [Employee]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        
        
        //connecting model to views
        var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
        func initializeFetchedResultsController() {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            let departmentSort = NSSortDescriptor(key: "department.name", ascending: true)
            let lastNameSort = NSSortDescriptor(key: "lastName", ascending: true)
            request.sortDescriptors = [departmentSort, lastNameSort]
            
            let moc = self.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            
            do {
                try fetchedResultsController.performFetch()
            } catch {
                fatalError("Failed to initialize FetchedResultsController: \(error)")
            }
        }
        
        //NSFetchedResultsControllerDelegate
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

