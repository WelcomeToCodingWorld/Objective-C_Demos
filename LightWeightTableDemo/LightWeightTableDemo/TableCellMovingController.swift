//
//  TableCellMovingController.swift
//  LightWeightTableDemo
//
//  Created by zz on 04/01/2018.
//  Copyright © 2018 com.lesta. All rights reserved.
//

import UIKit

protocol TableCellMovingController {
    typealias CanMoveRow = (UITableView,IndexPath) -> Bool
    typealias MoveRow = (UITableView,IndexPath,IndexPath) -> Void
    
    var canMoveRow:CanMoveRow {get}
    var moveRow:MoveRow {get}
}
