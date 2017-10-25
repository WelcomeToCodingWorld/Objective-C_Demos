//
//  Util.swift
//  FileManagerDemo
//
//  Created by zz on 25/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import Foundation
func printLog<T>(_ message:T,file:String = #file,method:String = #function,line:Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}


func local(_ closure:()->()) {
    closure()
}
