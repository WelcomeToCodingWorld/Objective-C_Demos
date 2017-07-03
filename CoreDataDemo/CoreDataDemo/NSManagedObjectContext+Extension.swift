//
//  NSManagedObjectContext+Extension.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    func insertObject<A:NSManagedObject>()->A where A:Managed{
        guard let object = NSEntityDescription.insertNewObject(forEntityName: A.entityName, into: self) as? A else{
            fatalError("wrong object type")
        }
        return object
    }
    
    func saveOrRollback()->Bool {
        do{
            try save()
            return true
        }catch{
            rollback()
            return false
        }
    }
    
    func performChange(block: @escaping ()->()) {
        perform(block)
        _  = self.saveOrRollback()
    }
}
