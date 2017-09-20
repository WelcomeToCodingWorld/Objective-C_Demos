//
//  Person.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData

public class Person: NSManagedObject {
    @NSManaged  private(set) var dateOfBirth:Date
    @NSManaged  private(set) var name:String
    
    static func insert(into context:NSManagedObjectContext,name:String,dateOfBirth:Date) -> Person{
        let person:Person =  context.insertObject()
        person.dateOfBirth = dateOfBirth
        person.name = name
        return person
    }
}

extension Person:Managed{
    static var defaultSortDescriptors:[NSSortDescriptor]{
        return [NSSortDescriptor(key: #keyPath(Person.dateOfBirth), ascending: false)]
    }
}
