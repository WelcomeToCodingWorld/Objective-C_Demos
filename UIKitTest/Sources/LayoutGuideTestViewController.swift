//
//  ViewController.swift
//  DrawPictureDemo
//
//  Created by zz on 2017/3/22.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var bottomView: UIView!
    @IBOutlet var bottomImageView: UIImageView!
    
    let guide1 = UILayoutGuide()
    let guide2 = UILayoutGuide()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observe device oritation chenage
        NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        imageView.backgroundColor = UIColor.cyan
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleBottomMargin]
        imageView.image = UIImage(named: "1")
        bottomImageView.image = UIImage(named:"2")
        bottomImageView.layer.borderColor = UIColor.brown.cgColor
        bottomImageView.layer.borderWidth = 1
        bottomImageView.removeFromSuperview()
        
        
        bottomView.addLayoutGuide(guide1)
        bottomView.addLayoutGuide(guide2)
        
        guide1.snp.makeConstraints { (maker) in
            maker.left.equalTo(bottomView).offset(bottomView.frame.width/3)
            maker.width.equalTo(1)
            maker.top.equalTo(bottomView)
            maker.bottom.equalTo(bottomView)
        }
        
        guide2.snp.makeConstraints { (maker) in
            maker.width.equalTo(1)
            maker.top.equalTo(bottomView)
            maker.bottom.equalTo(bottomView)
            maker.right.equalTo(bottomView).offset(-(bottomView.frame.width/3))
        }
        
        let imageView1 = UIImageView()
        let imageView2 = UIImageView()
        let imageView3 = UIImageView()
        
        imageView1.layer.borderColor = UIColor.brown.cgColor
        imageView1.layer.borderWidth = 1
        imageView1.image = UIImage(named:"1")
        
        imageView2.image = UIImage(named:"2")
        imageView2.layer.borderColor = UIColor.brown.cgColor
        imageView2.layer.borderWidth = 1
        
        imageView3.image = UIImage(named:"3")
        imageView3.layer.borderColor = UIColor.brown.cgColor
        imageView3.layer.borderWidth = 1
        
        bottomView.addSubview(imageView1)
        bottomView.addSubview(imageView2)
        bottomView.addSubview(imageView3)
        
        imageView1.snp.makeConstraints { (maker) in
            maker.left.equalTo(bottomView).offset(15)
            maker.right.equalTo(guide1.snp.left).offset(-15)
            maker.top.equalTo(bottomView).offset(15)
            maker.bottom.equalTo(bottomView).offset(-15)
        }
        
        imageView2.snp.makeConstraints { (maker) in
            maker.left.equalTo(guide1.snp.right).offset(15)
            maker.right.equalTo(guide2.snp.left).offset(-15)
            maker.top.equalToSuperview().offset(15)
            maker.bottom.equalToSuperview().offset(-15)
        }
        
        imageView3.snp.makeConstraints { (maker) in
            maker.left.equalTo(guide2.snp.right).offset(15)
            maker.right.equalToSuperview().offset(-15)
            maker.top.equalToSuperview().offset(15)
            maker.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    @objc private func rotate() {
        
        
        guide1.snp.updateConstraints { (maker) in
            maker.left.equalTo(bottomView).offset(bottomView.frame.width/3)
        }
        
        guide2.snp.updateConstraints { (maker) in
            maker.right.equalTo(bottomView).offset(-(bottomView.frame.width/3))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

