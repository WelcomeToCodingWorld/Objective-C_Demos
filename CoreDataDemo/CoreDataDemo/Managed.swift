//
//  Managed.swift
//  CoreDataDemo
//
//  Created by zz on 2017/7/1.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData

protocol Managed:class,NSFetchRequestResult {
    static var entityName:String {get}
    static var defaultSortDescriptors:[NSSortDescriptor]{get}
}

extension Managed{
    static var defaultSortDescriptors:[NSSortDescriptor]{
        return []
    }
    
    static var sortedFetchRequest:NSFetchRequest<Self>{
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

extension Managed where Self:NSManagedObject{
    static var entityName:String{
        return entity().name!
    }
}
