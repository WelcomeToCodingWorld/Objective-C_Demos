//
//  ViewController.swift
//  UILabel
//
//  Created by ari 李 on 11/01/2018.
//  Copyright © 2018 ari 李. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sizeFitTest()
        
    }
    
    private func sizeFitTest() {
        let label  = UILabel()
        label.text = "sizeFitTestsizeFitTestsizeFitTestsizeFitTestsizeFitTestsizeFitTest"
        view.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15)
            maker.right.equalToSuperview().inset(15)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        let size = label.sizeThatFits(CGSize(width: 200, height: CGFloat(MAXFLOAT)))
        printLog(size)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

