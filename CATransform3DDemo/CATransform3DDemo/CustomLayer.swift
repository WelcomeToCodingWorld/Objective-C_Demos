//
//  CustomLayer.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/9/1.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class CustomLayer: CALayer {
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.white.cgColor
        self.frame = CGRect(x: 20, y: 100, width: 300, height: 300)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func display() {
//        self.contents = UIImage.init(named: "screenshot")?.cgImage
//    }
    
    override func draw(in ctx: CGContext) {
        let thePath = CGMutablePath()
        thePath.move(to: CGPoint(x: 15, y: 15))
        thePath.addCurve(to: CGPoint(x: 300 - 15, y: 15), control1: CGPoint(x: 20, y: 200), control2: CGPoint(x: 280, y: 200))
        ctx.beginPath()
        ctx.addPath(thePath)
        ctx.setLineWidth(5)
        ctx.strokePath()
    }
    
//    use this method (instead of a delegate) to handle any layout tasks
    override func layoutSublayers() {
        
    }
    
}
