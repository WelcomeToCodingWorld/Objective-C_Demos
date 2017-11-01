//
//  ViewController.swift
//  Test-OC-Swift
//
//  Created by zz on 31/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sureBtn = UIButton.button(title: "OK", textAttributes: [UIFont.systemFont(ofSize: 15),UIColor.darkText])
        sureBtn.layer.borderColor = UIColor.brown.cgColor
        sureBtn.layer.borderWidth = 1
        let cancelBtn = UIButton.button(title: "Cancel", textAttributes: [UIFont.systemFont(ofSize: 15),UIColor.darkText])
        cancelBtn.layer.borderColor = UIColor.brown.cgColor
        cancelBtn.layer.borderWidth = 1
        view.addSubview(sureBtn)
        view.addSubview(cancelBtn)
        
        sureBtn.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15)
            maker.width.equalTo(75)
            maker.height.equalTo(27)
            maker.top.equalTo(100)
        }
        
        cancelBtn.snp.makeConstraints { (maker) in
            maker.right.equalTo(view.snp.right).offset(-15)
            maker.width.equalTo(sureBtn)
            maker.height.equalTo(sureBtn)
            maker.centerY.equalTo(sureBtn)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

