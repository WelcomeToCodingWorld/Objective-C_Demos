//
//  DataController.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/15.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData
import UIKit

class DataController : NSObject {
    var managedObjectContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    var persistentContainer:NSPersistentContainer
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }        
    }
    
//    let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
}
