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
    init(completionClosure: @escaping (NSPersistentContainer) -> ()) {
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            DispatchQueue.main.async {
                completionClosure(persistentContainer)
            }
        }        
    }
    
//    let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! Employee
}
