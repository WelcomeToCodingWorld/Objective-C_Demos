//
//  Util.swift
//  ViewControllerLifeCycle
//
//  Created by zz on 28/12/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import Foundation
func printLog<T>(_ message:T,file:String = #file,method:String = #function,line:Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}
