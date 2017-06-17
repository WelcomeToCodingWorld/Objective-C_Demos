//
//  ViewController.swift
//  SystemAppCallDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var customView: MyCustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFields[0].placeholder = "0000"
        textFields[1].placeholder = "1111"
        textFields[2].placeholder = "2222"
        customView.backgroundColor = customView.textColor
//        var height = customView.iconHeight
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

