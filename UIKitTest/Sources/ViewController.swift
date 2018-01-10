//
//  ViewController.swift
//  UIKitTest
//
//  Created by zz on 10/01/2018.
//  Copyright © 2018 com.lesta. All rights reserved.
//

import UIKit
class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTest()
    }
    
    
    fileprivate func buttonTest() {
        let button = UIButton.button(title: "Button", textAttributes: [UIFont.systemFont(ofSize: 14),UIColor.darkText])
        button.setBackgroundImage(UIImage(named: "bitshiftSignedMinusFour_2x"), for: .normal)
        button.imageView?.image = UIImage.image(withColor: UIColor.red, size: CGSize(width: 30, height: 30))
        button.imageView?.isExclusiveTouch = true
        button.setImage(UIImage.image(withColor: UIColor.cyan, size: CGSize(width: 20, height: 20)), for: .normal)
        button.setTitle("HeyYahMiHeyYahMiHeyYahMiHeyYahMiHeyYahMiHeyYahMiHeyYahMiHeyYahMiHeyYahMiHeyYahMi", for: .normal)
        button.titleLabel?.numberOfLines = 3
        
        
        button.contentMode = .top
        view.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15)
            maker.right.equalToSuperview().inset(15)
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.height.equalTo(50)
        }
        button.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        let edge:CGFloat = 5
        let imageWidth:CGFloat = 20
        let hSpacing:CGFloat = 4
        let maxLabWidth = frame.width - 2*edge - imageWidth - hSpacing
        if let titleLabel = titleLabel {
            let labelWidth = min(titleLabel.frame.width, maxLabWidth)
            titleEdgeInsets = UIEdgeInsetsMake(0, imageWidth + hSpacing, 0, 0)
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, labelWidth + hSpacing)
        }
    }
}

