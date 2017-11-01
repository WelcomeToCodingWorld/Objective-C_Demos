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
        
        //test snapKit
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
        
        let container = UIView()
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 1
        view.addSubview(container)
        container.snp.makeConstraints { (maker) in
            maker.top.equalTo(sureBtn.snp.bottom).offset(20)
            maker.left.equalToSuperview().offset(15)
            maker.right.equalToSuperview().offset(-15)
            maker.height.equalTo(300)
        }
        
        
        //test layoutGuide
        let label1 = UILabel.label(text: "label1", textColor: UIColor.blue, textFont: UIFont.systemFont(ofSize: 15))
        label1.layer.borderWidth = 1
        label1.layer.borderColor = UIColor.brown.cgColor
        let label2 = UILabel.label(text: "label2", textColor: UIColor.blue, textFont: UIFont.systemFont(ofSize: 15))
        label2.layer.borderWidth = 1
        label2.layer.borderColor = UIColor.brown.cgColor
        let label3 = UILabel.label(text: "label3", textColor: UIColor.blue, textFont: UIFont.systemFont(ofSize: 15))
        label3.layer.borderWidth = 1
        label3.layer.borderColor = UIColor.brown.cgColor
        container.addSubview(label1)
        container.addSubview(label2)
        container.addSubview(label3)
        
        let space1 = UILayoutGuide()
        let space2 = UILayoutGuide()
        container.addLayoutGuide(space1)
        container.addLayoutGuide(space2)
        
        local {
            space1.snp.makeConstraints { (maker) in
                maker.height.equalToSuperview()
                maker.width.equalTo(20)
                maker.left.equalTo(container.snp.centerX).offset(-50)
                maker.centerY.equalTo(container.snp.centerY)
            }
            
            space2.snp.makeConstraints { (maker) in
                maker.height.equalTo(space1)
                maker.width.equalTo(space1)
                maker.left.equalTo(container.snp.centerX).offset(50)
                maker.centerY.equalTo(container.snp.centerY)
            }
            
            label1.snp.makeConstraints { (maker) in
                maker.height.equalTo(30)
                maker.width.equalTo(75)
                maker.top.equalToSuperview().offset(15)
                maker.right.equalTo(space1.snp.left)
            }
            
            label2.snp.makeConstraints { (maker) in
                maker.height.equalTo(30)
                maker.width.equalTo(75)
                maker.top.equalToSuperview().offset(15)
                maker.left.equalTo(space1.snp.right)
                maker.right.equalTo(space2.snp.left)
            }
            
            label3.snp.makeConstraints { (maker) in
                maker.height.equalTo(30)
                maker.width.equalTo(75)
                maker.top.equalToSuperview().offset(15)
                maker.left.equalTo(space2.snp.right)
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

