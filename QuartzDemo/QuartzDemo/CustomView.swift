//
//  CustomView.swift
//  QuartzDemo
//
//  Created by zz on 2017/4/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext(){
            context.setFillColor(red: 0.5, green: 0.6, blue: 1, alpha: 0.5)
            context.setFontSize(14)
            context.setLineWidth(2)
            context.setStrokeColor(UIColor.red.cgColor)
            context.move(to: CGPoint(x: 30, y: 40))
            context.addLine(to: CGPoint(x: 50, y: 50))
            context.addArc(tangent1End: CGPoint(x: 50, y: 50), tangent2End: CGPoint(x: 100, y: 120), radius: 25)
            context.fillEllipse(in: CGRect(x: 30, y: 40, width: 200, height: 100))
            context.saveGState()

            let path = CGMutablePath()
            path.move(to: CGPoint(x: 60, y: 100))
            path.addCurve(to: CGPoint(x: 80, y: 250), control1: CGPoint(x: 115, y: 205), control2: CGPoint(x: 135, y: 220))
            path.closeSubpath()
            context.addPath(path)
            context.fillPath()
            context.strokePath()
        }
        
    }

}
