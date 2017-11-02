//
//  ViewController.swift
//  MethodSwizzlingTest
//
//  Created by zz on 02/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testLabel = UILabel()
        print(type(of: testLabel))
        testLabel.text = "Hello"
        view.addSubview(testLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UILabel {
    @objc func al_setText(_ :String) {
        print("newMethod called")
    }
}

