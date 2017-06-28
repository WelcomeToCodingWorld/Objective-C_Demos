//
//  Person.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData

class Person: NSManagedObject {
    @NSManaged  fileprivate(set) var dateOfBirth:Date
    @NSManaged  fileprivate(set) var name:String
    
    static func insert(into context:NSManagedObjectContext) -> Person{
        let person:Person =  context.insertObject()
        person.dateOfBirth = Date(timeIntervalSinceNow: 12*30*24*3600*25)
        person.name = "Lee"
        return person
    }
}
