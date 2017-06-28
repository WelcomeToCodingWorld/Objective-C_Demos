//
//  CoreDataStack.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData
func createDataModelContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "DataModel")
    container.loadPersistentStores { _, error in
        guard error == nil else { fatalError("Failed to load store: \(String(describing: error))") }
        DispatchQueue.main.async { completion(container) }
    }
}

