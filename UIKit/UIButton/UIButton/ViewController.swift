//
//  ViewController.swift
//  UIButton
//
//  Created by zz on 11/01/2018.
//  Copyright © 2018 com.lesta. All rights reserved.
//

import UIKit
import SnapKit
fileprivate let EDGE:CGFloat = 15
fileprivate let BUTTON_WIDTH = SCREEN_WIDTH/4
class ViewController: UIViewController {

    fileprivate var btns = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTest()
    }
    
    private func layoutTest() {
        let edge:CGFloat = 5
        let imageWidth:CGFloat = 12
        let hSpacing:CGFloat = 4
        let maxLabWidth = BUTTON_WIDTH - 2*edge - imageWidth - hSpacing
        var lastView:UIView = view
        for idx in 0..<2 {
            let headerBtn = UIButton.button(title: "layout", textAttributes: [UIFont.systemFont(ofSize: 14)])
            btns.append(headerBtn)
            headerBtn.addObserver(self, forKeyPath: #keyPath(UIButton.titleLabel.text), options: [.new,.old], context: nil)
            headerBtn.addTarget(self, action: #selector(textChanged(sender:)), for: .valueChanged)
            headerBtn.backgroundColor = UIColor.black
            headerBtn.titleLabel?.backgroundColor = UIColor.brown
            headerBtn.setImage(UIImage.image(withColor: UIColor.cyan, size: CGSize(width: imageWidth, height: imageWidth)), for: .normal)
            
            headerBtn.insetContent(withInset: edge)
            headerBtn.centerContent(withSpace: hSpacing)
            view.addSubview(headerBtn)
            headerBtn.snp.makeConstraints { (maker) in
                if idx == 0 {
                    maker.left.equalToSuperview().offset(EDGE)
                }else {
                    maker.left.equalTo(lastView.snp.right).offset(EDGE)
                }
                maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
                maker.width.equalTo(BUTTON_WIDTH)
                maker.height.equalTo(44)
            }
            
//            headerBtn.insetContent(withMaxWidth: BUTTON_WIDTH)
            let size = headerBtn.titleLabel?.sizeThatFits(CGSize(width: maxLabWidth, height: CGFloat(MAXFLOAT)))
            if let size = size {
                headerBtn.swapContent(withSpace: hSpacing, labelWidth: min(size.width, maxLabWidth), imageWidth: imageWidth)
            }
            lastView = headerBtn
        }
        
        btns[0].setTitle("textChangedextChangedextChanged", for: .normal)
    }

    
    @objc private func textChanged(sender:UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let button = object as? UIButton {
            if keyPath == #keyPath(UIButton.titleLabel.text) {
                button.insetContent(withMaxWidth: BUTTON_WIDTH)
            }
        }
    }
    
    deinit {
        for (_,button) in btns.enumerated() {
            self.removeObserver(button, forKeyPath: #keyPath(UIButton.titleLabel.text))
        }
        
    }

}

extension UIButton {
    func centerContent(withSpace space:CGFloat) {
        imageEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, 0)
        titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space/2)
    }
    
    func insetContent(withInset inset:CGFloat) {
        contentEdgeInsets.left = inset
        contentEdgeInsets.right = inset
    }
    
    func swapContent(withSpace space:CGFloat,labelWidth:CGFloat? = nil,imageWidth:CGFloat? = nil) {
        layoutIfNeeded()
        let labelWidth = labelWidth ?? titleLabel?.frame.size.width ?? 0
        let imageWidth = imageWidth ?? currentImage?.size.width ?? 0
        centerContent(withSpace: space)
        imageEdgeInsets.right  -= space + labelWidth
        imageEdgeInsets.left += space + labelWidth
        titleEdgeInsets.left -= space + imageWidth
        titleEdgeInsets.right += space + imageWidth
    }
    
    func insetContent(withMaxWidth maxWidth:CGFloat) {
        if let titleLabel = titleLabel {
            let size = titleLabel.sizeThatFits(CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)))
            if size.width < maxWidth {
                let diff = maxWidth - size.width
                insetContent(withInset: diff/2 + contentEdgeInsets.left)
            }else {
                insetContent(withInset: EDGE)
                sizeToFit()
//                titleLabel.frame.size.width = maxWidth
                
            }
        }
    }
}

