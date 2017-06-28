//
//  SegueHandler.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

protocol SegueHandler {
    associatedtype SegueIdentifier:RawRepresentable
}

extension SegueHandler where Self:UIViewController,SegueIdentifier.RawValue == String{
    func segueIdentifier(for segue:UIStoryboardSegue)->SegueIdentifier {
        guard let identifier = segue.identifier,let segureIdentifier = SegueIdentifier(rawValue: identifier)
         else {
            fatalError("Unknow segue: \(segue)")
        }
        return segureIdentifier
    }
    
    func performSegue(withIdentifier identifier:SegueIdentifier
        ) {
        performSegue(withIdentifier: identifier.rawValue, sender: nil)
    }
}
