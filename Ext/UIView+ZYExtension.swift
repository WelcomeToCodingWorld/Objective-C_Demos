//
//  UIView+ZYExtension.swift
//  UniteRouteTechnician
//
//  Created by zz on 28/09/2017.
//  Copyright © 2017 Lesta. All rights reserved.
//


extension UIView {
    /// NOTE: 添加水平分割线
    class func addSeperateLine(below:Bool,vRelativeView:UIView,to parentView:UIView, vMargin:CGFloat ,lMargin:CGFloat,rMargin:CGFloat,height:CGFloat,color:UIColor?) -> UIView{
        let line = UIView()
        if let color = color {
            line.backgroundColor = color;
        }else {
            line.backgroundColor = UIColor.init(hexString: "#dcdcdc")
        }
        
        parentView.addSubview(line)
        
        _ = line.sd_layout()
            .leftSpaceToView(parentView, lMargin)?
            .rightSpaceToView(parentView, rMargin)?
            .heightIs(height)
        
        if (below) {
            if vRelativeView == parentView {
                _ = line.sd_layout().bottomSpaceToView(parentView,vMargin)
            }else  {
                _ = line.sd_layout().topSpaceToView(parentView,vMargin)
            }
        }else{
            if vRelativeView == parentView {
                _ = line.sd_layout().topSpaceToView(parentView,vMargin)
            }else {
                _ = line.sd_layout().bottomSpaceToView(parentView,vMargin)
            }
        }
        return line;
    }
    
    /// NOTE: 添加垂直分割线
    class func addSeperateLine(right:Bool,hRelativeView:UIView,to parentView:UIView, hMargin:CGFloat ,tMargin:CGFloat?,bMargin:CGFloat?,width:CGFloat,height:CGFloat?,color:UIColor?) -> UIView{
        let line = UIView()
        if let color = color {
            line.backgroundColor = color;
        }else {
            line.backgroundColor = UIColor.init(hexString: "#dcdcdc")
        }
        
        parentView.addSubview(line)
        
        if let tMargin = tMargin,let bMargin = bMargin {
            _ = line.sd_layout()
                .bottomSpaceToView(parentView,bMargin)?
                .widthIs(width)?
                .topSpaceToView(parentView,tMargin)
        }else if let height = height {
            _ = line.sd_layout()
                .centerYEqualToView(parentView)?
                .widthIs(width)?
                .heightIs(height)
        }
        
        if (right) {
            if hRelativeView == parentView {
                _ = line.sd_layout().rightSpaceToView(hRelativeView,hMargin)
            }else {
                _ = line.sd_layout().leftSpaceToView(hRelativeView,hMargin)
            }
            
        }else{
            if hRelativeView == parentView {
                _ = line.sd_layout().leftSpaceToView(hRelativeView,hMargin)
            }else {
                _ = line.sd_layout().rightSpaceToView(hRelativeView,hMargin)
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
        _ = textField.sd_layout().leftSpaceToView(view,kEdge)?.centerYEqualToView(view)?.heightRatioToView(view,1)
        
        var button : UIButton?
        
        if let buttonTitle = buttonTitle {
            button = UIButton.init(type:.custom)
            view.addSubview(button!)
            _ = button!.sd_layout().rightSpaceToView(view,kEdge)?.centerYEqualToView(view)?.widthIs(75)?.heightIs(27)
            button?.sd_cornerRadius = 5.0
            button?.backgroundColor = UIColor.kBlue
            button!.setTitle(buttonTitle, for: .normal)
            _ = textField.sd_layout().rightSpaceToView(button,kEdge)
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
            _ = textField.sd_layout().rightSpaceToView(view,kEdge)
        }
        return (view,textField,button)
    }
    
    /// NOTE: 左边为titleLabel 右边为可选的subTitleLabel 和可选的disclosure
    class func view(title:String,subTitle:String?,subTitleTextAlignment:NSTextAlignment? = .right,colors:[UIColor]?,fonts:[UIFont]?,disclosureIcon:String? = nil,target:actionable? = nil,interactionRectWidth:CGFloat? = nil) -> (view:UIView,titleLabel:UILabel,subTitleLable:UILabel?,disclosureIV:UIImageView?){
        let view = UIView()
        var subTitleLabel : UILabel?
        var disclosureImage : UIImage?
        var disclosureIV : UIImageView?
        
        
        let titleLabel = UILabel.label(text:title,textColor: colors?.first, textFont: fonts?.first)
        view.addSubview(titleLabel)
        
        
        if let subTitle = subTitle {
            subTitleLabel = UILabel.label(text:subTitle,textColor: colors?.last, textFont: fonts?.last)
            view.addSubview(subTitleLabel!)
            if let textAlignment = subTitleTextAlignment {
                subTitleLabel?.textAlignment = textAlignment
            }
        }
        
        _ = titleLabel.sd_layout().leftSpaceToView(view,kEdge)?.centerYEqualToView(view)?.autoHeightRatio(0)
        titleLabel.setSingleLineAutoResizeWithMaxWidth(kScreenBounds.width - 2*kEdge)
        
        if let disclosureIcon = disclosureIcon {
            disclosureImage = UIImage.init(named: disclosureIcon)
            disclosureIV = UIImageView.init(image: disclosureImage)
            view.addSubview(disclosureIV!)
            
            _ = disclosureIV?.sd_layout().rightSpaceToView(view,kEdge)?.centerYEqualToView(view)?.widthIs(disclosureImage?.size.width ?? 0)?.heightIs(disclosureImage?.size.height ?? 0)
        }
        
        
        if let subTitleLabel = subTitleLabel {
            _ = subTitleLabel.sd_layout().centerYEqualToView(view)?.autoHeightRatio(0)
            if let disclosureIV = disclosureIV {
                _ = subTitleLabel.sd_layout().rightSpaceToView(disclosureIV,10)
                subTitleLabel.setSingleLineAutoResizeWithMaxWidth(kScreenBounds.width - 2*kEdge - 10 -  (disclosureImage?.size.width ?? 0))
            }else {
                _ = subTitleLabel.sd_layout().rightSpaceToView(view,kEdge)
                subTitleLabel.setSingleLineAutoResizeWithMaxWidth(kScreenBounds.width - 2*kEdge)
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
            
            _ = subView.sd_layout().centerYEqualToView(view)?.heightRatioToView(view,1)?.rightEqualToView(view)
            if let width = interactionRectWidth {
                _ = subView.sd_layout().widthIs(width)
            }else {
                if let image = disclosureImage {
                    if let subTitleLabel = subTitleLabel  {
                        _ = subView.sd_layout().leftEqualToView(subTitleLabel)
                    }else {
                        _ = subView.sd_layout().widthIs(image.size.width)
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
        let titleLabel = UILabel.label(text:title,textColor: titleColor, textFont: titleFont)
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
            _ = rightIV!.sd_layout().widthIs(imageW)?.heightIs(imageW)
            rightIV!.sd_cornerRadius = (imageW/2 as NSNumber)
            if rightImage.hasPrefix("http") {
                let url = URL(string:rightImage)
                rightIV?.kf.setImage(with: url, placeholder: UIImage.init(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            }else {
                image = UIImage.init(named: rightImage)
                rightIV!.image = image
            }
        }
        
        
        _ = titleLabel.sd_layout()
            .leftSpaceToView(view,kEdge)?
            .centerYEqualToView(view)?
            .autoHeightRatio(0)
        titleLabel.setSingleLineAutoResizeWithMaxWidth(kScreenBounds.width - 2*kEdge)
        
        if let rightDisclosureIcon = rightDisclosureIcon {
            disclosureIcon = UIImage.init(named: rightDisclosureIcon)
            rightDisclosureIV = UIImageView.init(image: disclosureIcon)
            view.addSubview(rightDisclosureIV!)
            
            _ = rightDisclosureIV?.sd_layout().rightSpaceToView(view,kEdge)?.centerYEqualToView(view)?.widthIs(disclosureIcon?.size.width ?? 0)?.heightIs(disclosureIcon?.size.height ?? 0)
        }
        
        if let rightIV = rightIV {
            if let rightDisclosureIV = rightDisclosureIV {
                _ = rightIV.sd_layout().rightSpaceToView(rightDisclosureIV,kEdge)?.centerYEqualToView(view)
            }else {
                _ = rightIV.sd_layout().rightSpaceToView(view,kEdge)?.centerYEqualToView(view)
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
            
            _ = subView!.sd_layout().centerYEqualToView(view)?.heightRatioToView(view,1)?.rightEqualToView(view)
            if let width = interactionRectWidth {
                _ = subView!.sd_layout().widthIs(width)
            }else {
                
                if let image = image {
                    totalWidth += image.size.width + kEdge
                }
                
                if let disclosureIcon = disclosureIcon {
                    totalWidth += disclosureIcon.size.width + kEdge
                }
                _ = subView!.sd_layout().widthIs(totalWidth)
            }
            
        }
        return (view,rightIV)
    }
}

@objc protocol actionable {
    @objc func action(sender:AnyObject)
}
