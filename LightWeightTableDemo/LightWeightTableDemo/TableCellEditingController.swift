//
//  TableCellEditingController.swift
//  AppDemo
//
//  Created by zz on 28/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//


import UIKit
protocol TableCellEditingController {
    typealias CanEditRowConfigurator = (_ tableView:UITableView, _ indexPath:IndexPath) -> Bool
    typealias CommitEditingHandler = (_ tableView:UITableView, _ editingStyle:UITableViewCellEditingStyle, _ indexPath:IndexPath) -> Void
    
    var canEditRow:CanEditRowConfigurator {get}
    var commitEditing:CommitEditingHandler {get}
}
