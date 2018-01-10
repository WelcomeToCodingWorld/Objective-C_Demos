//
//  UILabel+ZYExtension.swift
//  UniteRouteTechnician
//
//  Created by zz on 28/09/2017.
//  Copyright © 2017 Lesta. All rights reserved.
//

import UIKit
extension UILabel {
    class func label(text:String?, textAttributes:[Any]?) -> UILabel{
        let label = UILabel.init()
        if let title = text {
            label.text = title
        }
        
        if let attributes = textAttributes{
            for attribute in attributes {
                switch attribute {
                case is UIFont:
                    label.font = attribute as? UIFont
                case is UIColor:
                    label.textColor = attribute as? UIColor
                default:
                    break
                }
            }
        }
        return label
    }
    
    var isAttributedString:Bool? {
        get {
            return objc_getAssociatedObject(self, UnsafeRawPointer(bitPattern: "isAttributedString.Key".hashValue)!) as? Bool
        }
        
        set{
            objc_setAssociatedObject(self, UnsafeRawPointer(bitPattern: "isAttributedString.Key".hashValue)!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func showMaxNumberOf(lines count:Int,maxWidth:CGFloat,lineSpacing:CGFloat) {
        guard let text = text else {
            return
        }
        numberOfLines = 0
        if let isAttrubuted = isAttributedString {
            if isAttrubuted {
                let size = sizeThatFits(CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)))
                snp.updateConstraints({ (maker) in
                    if let attributedText = attributedText {
                        var lineSpacing : CGFloat = 0
                        let rangePointer = UnsafeMutablePointer<NSRange>.allocate(capacity: 1)
                        rangePointer.initialize(to: NSMakeRange(0, text.count - 1))
                        if let paraStyle = attributedText.attributes(at: 0, effectiveRange:rangePointer)[NSAttributedStringKey.paragraphStyle] as? NSParagraphStyle {
                            lineSpacing = paraStyle.lineSpacing
                        }
                        maker.height.equalTo(min(size.height, (font.lineHeight + lineSpacing)*CGFloat(count)) + font.lineHeight)
                    }
                })
            }else {
                let rect = (text as NSString).boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : font], context: nil)
                snp.makeConstraints({ (maker) in
                    maker.height.equalTo(min(rect.size.height, font.lineHeight*(lineSpacing - 1) + font.lineHeight))
                })
            }
        }
    }
}


