//
//  Data.swift
//  CoreDataDemo
//
//  Created by zz on 22/09/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import CoreData
public class City: NSManagedObject{
    @NSManaged private(set) var name:String
    @NSManaged private(set) var code:String
    @NSManaged private(set) var districts:Set<District>
    
}


