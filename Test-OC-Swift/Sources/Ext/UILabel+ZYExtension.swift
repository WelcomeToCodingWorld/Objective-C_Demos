//
//  UILabel+ZYExtension.swift
//  UniteRouteTechnician
//
//  Created by zz on 28/09/2017.
//  Copyright © 2017 Lesta. All rights reserved.
//

import UIKit
extension UILabel {
    class func label(text:String?, textColor:UIColor?,textFont:UIFont?) -> UILabel{
        let label = UILabel.init()
        if let title = text {
            label.text = title
        }
        if let color = textColor {
            label.textColor = color
        }else {
            label.textColor = UIColor.darkText
        }
        
        if let font = textFont {
            label.font = font
        }
        label.font = textFont
        return label
    }
}
