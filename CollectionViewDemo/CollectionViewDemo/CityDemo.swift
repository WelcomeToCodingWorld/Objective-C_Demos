//
//  City.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/7/24.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import CoreData

struct CityDemo:Decodable{
    var name : String
    var code : String
    var population : UInt64
    var isProvinceLevel : Bool    
}
