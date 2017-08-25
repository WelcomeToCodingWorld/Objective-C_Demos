//
//  User.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/4/20.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData

class User:  NSManagedObject,Decodable{
    @NSManaged public fileprivate(set) var name : String
    @NSManaged public fileprivate(set) var registDate : Date
    @NSManaged public fileprivate(set) var userId : String
}
