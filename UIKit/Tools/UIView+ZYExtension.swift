//
//  UIView+ZYExtension.swift
//  UniteRoute
//
//  Created by zz on 25/12/2017.
//  Copyright © 2017 Lesta. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

internal let kEdge:CGFloat = 15
internal let SCREEN_BOUNDS = UIScreen.main.bounds
internal let SCREEN_WIDTH = SCREEN_BOUNDS.width
internal let SCREEN_HEIGHT = SCREEN_BOUNDS.height


extension UIView {
    /// NOTE: 添加水平分割线
    @discardableResult
    func addSeperateLine(below:Bool, to parentView:UIView? = nil, vMargin:CGFloat ,lMargin:CGFloat,rMargin:CGFloat,height:CGFloat,color:UIColor?) -> UIView{
        let line = UIView()
        if let color = color {
            line.backgroundColor = color;
        }else {
            line.backgroundColor = UIColor.color(hexString: "dcdcdc")
        }
        
        let parentView:UIView! = parentView ?? self.superview
        
        parentView.addSubview(line)
        
        line.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(lMargin)
            maker.right.equalToSuperview().offset(-rMargin)
            maker.height.equalTo(height)
        }
        
        if (below) {
            if self == parentView {
                line.snp.makeConstraints({ (maker) in
                    maker.bottom.equalToSuperview().offset(-vMargin)
                })
            }else  {
                line.snp.makeConstraints({ (maker) in
                    maker.top.equalTo(self.snp.bottom).offset(vMargin)
                })
            }
        }else{
            if self == parentView {
                line.snp.makeConstraints({ (maker) in
                    maker.top.equalToSuperview().offset(vMargin)
                })
            }else {
                line.snp.makeConstraints({ (maker) in
                    maker.bottom.equalTo(self.snp.top).offset(-vMargin)
                })
            }
        }
        return line;
    }
    
    /// NOTE: 添加垂直分割线
    @discardableResult
    func addSeperatorLine(right:Bool, to parentView:UIView? = nil, hMargin:CGFloat, tMargin:CGFloat?, bMargin:CGFloat?, width:CGFloat, height:CGFloat?, color:UIColor?)->UIView {
        let line = UIView()
        if let color = color {
            line.backgroundColor = color;
        }else {
            line.backgroundColor = UIColor.color(hexString: "dcdcdc")
        }
        
        let parentView:UIView! = parentView ?? self.superview
        parentView.addSubview(line)
        
        
        if let tMargin = tMargin,let bMargin = bMargin {
            line.snp.makeConstraints({ (maker) in
                maker.bottom.equalToSuperview().offset(-bMargin)
                maker.width.equalTo(width)
                maker.top.equalToSuperview().offset(tMargin)
            })
        }else if let height = height {
            line.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.width.equalTo(width)
                maker.height.equalTo(height)
            })
        }
        
        if (right) {
            if self == parentView {
                line.snp.makeConstraints({ (maker) in
                    maker.right.equalToSuperview().offset(-hMargin)
                })
            }else {
                line.snp.makeConstraints({ (maker) in
                    maker.left.equalTo(self.snp.right).offset(hMargin)
                })
            }
            
        }else{
            if self == parentView {
                line.snp.makeConstraints({ (maker) in
                    maker.left.equalToSuperview().offset(hMargin)
                })
            }else {
                line.snp.makeConstraints({ (maker) in
                    maker.right.equalTo(self.snp.left).offset(-hMargin)
                })
            }
        }
        
        return line;
    }
    
    /// NOTE: 左边textField 右边可选的button
    class func view(placeHolder:String?,tfTextAttribute:[Any]?,delegate:UITextFieldDelegate?,text:String? = nil ,keyboardType:UIKeyboardType? = nil,buttonTitle:String? = nil,btnTextAttribute:[Any]? = nil,target:actionable? = nil) -> (view:UIView,tf:UITextField,btn:UIButton?) {
        let view = UIView()
        let textField = UITextField()
        
        if let placeHolder = placeHolder {
            textField.placeholder = placeHolder
        }
        
        if let textAttribute = tfTextAttribute {
            for item  in textAttribute {
                switch item {
                case is UIFont:
                    textField.font = item as? UIFont
                case is UIColor:
                    textField.textColor = item as? UIColor
                default:
                    break
                }
            }
        }
        
        if let kbType = keyboardType {
            textField.keyboardType = kbType
        }
        
        if let text = text {
            textField.text = text
        }
        textField.delegate = delegate
        view.addSubview(textField)
        textField.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(kEdge)
            maker.centerY.equalToSuperview()
            maker.height.equalToSuperview()
        }
        var button : UIButton?
        
        if let buttonTitle = buttonTitle {
            button = UIButton.init(type:.custom)
            view.addSubview(button!)
            button?.snp.makeConstraints({ (maker) in
                maker.right.equalToSuperview().offset(-kEdge)
                maker.centerY.equalToSuperview()
                maker.width.equalTo(75)
                maker.height.equalTo(27)
            })
            button?.layer.cornerRadius = 5.0
            button?.clipsToBounds = true
            button?.backgroundColor = UIColor.blue
            button!.setTitle(buttonTitle, for: .normal)
            textField.snp.makeConstraints({ (maker) in
                maker.right.equalTo((button?.snp.left)!).offset(-kEdge)
            })
            if let textAttribute = btnTextAttribute {
                for item  in textAttribute {
                    switch item {
                    case is UIFont:
                        button!.titleLabel?.font = item as? UIFont
                    case is UIColor:
                        button!.setTitleColor(item as? UIColor, for: .normal)
                    default:
                        break
                    }
                }
            }
            if let target = target {
                button!.addTarget(target, action: #selector(target.action(sender:)), for: .touchUpInside)
            }
            
        }else {
            textField.snp.makeConstraints({ (maker) in
                maker.right.equalToSuperview().offset(-kEdge)
            })
        }
        return (view,textField,button)
    }
    
    /// NOTE: 左边为titleLabel 右边为可选的subTitleLabel 和可选的disclosure
    class func view(title:String,subTitle:String?,subTitleTextAlignment:NSTextAlignment? = .right,colors:[UIColor]?,fonts:[UIFont]?,disclosureIcon:String? = nil,target:actionable? = nil,interactionRectWidth:CGFloat? = nil) -> (view:UIView,titleLabel:UILabel,subTitleLable:UILabel?,disclosureIV:UIImageView?){
        let view = UIView()
        var subTitleLabel : UILabel?
        var disclosureImage : UIImage?
        var disclosureIV : UIImageView?
        
        let titleLabel = UILabel.label(text:title,textAttributes: [colors?.first as Any,fonts?.first as Any])
        view.addSubview(titleLabel)
        
        
        
        if let subTitle = subTitle {
            subTitleLabel = UILabel.label(text:subTitle,textAttributes: [colors?.last as Any,fonts?.last as Any])
            view.addSubview(subTitleLabel!)
            if let textAlignment = subTitleTextAlignment {
                subTitleLabel?.textAlignment = textAlignment
            }
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(-kEdge)
            maker.height.equalTo(titleLabel.font.lineHeight)
            maker.width.lessThanOrEqualTo(SCREEN_WIDTH - 2*kEdge)
            maker.centerY.equalToSuperview()
        }
        
        if let disclosureIcon = disclosureIcon {
            disclosureImage = UIImage.init(named: disclosureIcon)
            disclosureIV = UIImageView.init(image: disclosureImage)
            view.addSubview(disclosureIV!)
            
            disclosureIV?.snp.makeConstraints({ (maker) in
                maker.right.equalToSuperview().offset(kEdge)
                maker.centerY.equalToSuperview()
                maker.width.equalTo(disclosureImage?.size.width ?? 0)
                maker.height.equalTo(disclosureImage?.size.height ?? 0)
            })
            
        }
        
        
        if let subTitleLabel = subTitleLabel {
            subTitleLabel.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.height.equalTo(subTitleLabel.font.lineHeight)
            })
            if let disclosureIV = disclosureIV {
                subTitleLabel.snp.makeConstraints({ (maker) in
                    maker.right.equalTo(disclosureIV.snp.left).offset(-10)
                    maker.width.lessThanOrEqualTo(SCREEN_WIDTH - 2*kEdge - 10 - (disclosureImage?.size.width ?? 0))
                })
            }else {
                subTitleLabel.snp.makeConstraints({ (maker) in
                    maker.right.equalToSuperview().offset(-kEdge)
                    maker.width.lessThanOrEqualTo(SCREEN_WIDTH - 2*kEdge)
                })
            }
        }
        
        
        if let target = target {
            guard  disclosureIV != nil || subTitleLabel != nil else {
                return (view,titleLabel,subTitleLabel,disclosureIV)
            }
            
            let singleTapGesture = UITapGestureRecognizer.init(target: target, action: #selector(target.action(sender:)))
            view.addGestureRecognizer(singleTapGesture)
            let subView = UIView()
            subView.addGestureRecognizer(singleTapGesture)
            view.addSubview(subView)
            
            subView.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.height.equalToSuperview()
                maker.right.equalToSuperview()
            })
            if let width = interactionRectWidth {
                subView.snp.makeConstraints({ (maker) in
                    maker.width.equalTo(width)
                })
            }else {
                if let image = disclosureImage {
                    if let subTitleLabel = subTitleLabel  {
                        subView.snp.makeConstraints({ (maker) in
                            maker.left.equalTo(subTitleLabel)
                        })
                    }else {
                        subView.snp.makeConstraints({ (maker) in
                            maker.width.equalTo(image.size.width)
                        })
                    }
                }
            }
            
        }
        return (view,titleLabel,subTitleLabel,disclosureIV)
    }
    
    /// NOTE: 左边为titleLabel 右边为可选的Image和disclosureIcon
    class func view(title:String,rightImage:String? ,rightDisclosureIcon:String?,titleColor:UIColor?,titleFont:UIFont?,target:actionable? = nil,interactionRectWidth:CGFloat? = nil) -> (view:UIView,rightIV:UIImageView?){
        let imageW:CGFloat = 40
        let view = UIView()
        let titleLabel = UILabel.label(text:title,textAttributes: [titleFont as Any,titleColor as Any])
        view.addSubview(titleLabel)
        var image : UIImage?
        var disclosureIcon : UIImage?
        var subView:UIView?
        
        
        var rightIV : UIImageView?
        var rightDisclosureIV : UIImageView?
        var totalWidth : CGFloat = 0
        if let rightImage = rightImage {
            rightIV = UIImageView()
            view.addSubview(rightIV!)
            totalWidth += imageW + kEdge
            rightIV?.layer.cornerRadius = imageW/2
            rightIV?.clipsToBounds = true
            rightIV?.snp.makeConstraints({ (maker) in
                maker.width.equalTo(imageW)
                maker.height.equalTo(imageW)
            })
            if rightImage.hasPrefix("http") {
                let url = URL(string:rightImage)
                rightIV?.kf.setImage(with: url, placeholder: UIImage.init(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            }else {
                image = UIImage.init(named: rightImage)
                rightIV!.image = image
            }
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(kEdge)
            maker.centerY.equalToSuperview()
            maker.height.equalTo(titleLabel.font.lineHeight)
            maker.width.lessThanOrEqualTo(SCREEN_WIDTH - 2*kEdge)
        }
        
        if let rightDisclosureIcon = rightDisclosureIcon {
            disclosureIcon = UIImage.init(named: rightDisclosureIcon)
            rightDisclosureIV = UIImageView.init(image: disclosureIcon)
            view.addSubview(rightDisclosureIV!)
            
            rightDisclosureIV?.snp.makeConstraints({ (maker) in
                maker.right.equalToSuperview().offset(-kEdge)
                maker.centerY.equalToSuperview()
                maker.width.equalTo(disclosureIcon?.size.width ?? 0)
                maker.height.equalTo(disclosureIcon?.size.height ?? 0)
            })
            
        }
        
        if let rightIV = rightIV {
            if let rightDisclosureIV = rightDisclosureIV {
                rightIV.snp.makeConstraints({ (maker) in
                    maker.right.equalTo(rightDisclosureIV.snp.left).offset(-kEdge)
                    maker.centerY.equalToSuperview()
                })
            }else {
                rightIV.snp.makeConstraints({ (maker) in
                    maker.right.equalToSuperview().offset(-kEdge)
                    maker.centerY.equalToSuperview()
                })
            }
        }
        
        if let target = target {
            guard  rightIV != nil || rightDisclosureIV != nil else {
                return (view,rightIV)
            }
            
            let singleTapGesture = UITapGestureRecognizer.init(target: target, action: #selector(target.action(sender:)))
            view.addGestureRecognizer(singleTapGesture)
            subView = UIView()
            subView!.addGestureRecognizer(singleTapGesture)
            view.addSubview(subView!)
            
            subView?.snp.makeConstraints({ (maker) in
                maker.centerY.equalToSuperview()
                maker.height.equalToSuperview()
                maker.right.equalToSuperview()
            })
            if let width = interactionRectWidth {
                subView?.snp.makeConstraints({ (maker) in
                    maker.width.equalTo(width)
                })
            }else {
                
                if let image = image {
                    totalWidth += image.size.width + kEdge
                }
                
                if let disclosureIcon = disclosureIcon {
                    totalWidth += disclosureIcon.size.width + kEdge
                }
                subView?.snp.makeConstraints({ (maker) in
                    maker.width.equalTo(totalWidth)
                })
            }
        }
        return (view,rightIV)
    }
}

@objc protocol actionable {
    @objc func action(sender:AnyObject)
}

