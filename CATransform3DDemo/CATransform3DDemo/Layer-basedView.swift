//
//  Layer-basedView.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/9/1.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class Layer_basedView: UIView {
    
    override var layer: CALayer{
        return super.layer
    }
    
    override class var layerClass: Swift.AnyClass{
        return CAMetalLayer.self
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
