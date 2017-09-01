//
//  AnimationViewController.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/9/1.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(sublayer)
        sublayer.backgroundColor = UIColor.white.cgColor
        sublayer.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        
        //when the case is 2 , code below is not required
//        sublayer.frame = CGRect(x: 20, y: 100, width: 300, height: 300)
        sublayer.setNeedsDisplay()

        //3.subclass CALayer to provide content
//        let customLayer = CustomLayer()
//        self.view.layer.addSublayer(customLayer)
//        customLayer.setNeedsDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        moveSublayer()
    }
    
    deinit {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static var delegate = LayerDelegate()
    
    lazy var sublayer: CALayer = {
        let layer = CALayer()
        
        //1.set delgate to provide layer content
        layer.delegate = AnimationViewController.delegate
        
//        2.assign image object directly to layer to provide content
//        layer.contents = UIImage.init(named: "screenshot")?.cgImage
//        layer.contentsGravity = kCAGravityLeft
//        layer.contentsScale = 2.0
        return layer
    }()
    
    func moveSublayer() {
        guard let action = sublayer.action(forKey: "moveRight") else {
            return
        }
        
        action.run(forKey: "transform", object: sublayer, arguments: nil)
    }
    
    class LayerDelegate: NSObject, CALayerDelegate {
        func action(for layer: CALayer, forKey event: String) -> CAAction? {
            
            guard event == "moveRight" else {
                return nil
            }
            
            let animation = CABasicAnimation()
            animation.valueFunction = CAValueFunction(name: kCAValueFunctionTranslateX)
            animation.fromValue = 1
            animation.toValue = 300
            animation.duration = 2
            return animation
        }
        
        func draw(_ layer: CALayer, in ctx: CGContext) {
            let thePath = CGMutablePath()
            thePath.move(to: CGPoint(x: 15, y: 15))
            thePath.addCurve(to: CGPoint(x: 300 - 15, y: 15), control1: CGPoint(x: 20, y: 200), control2: CGPoint(x: 280, y: 200))
            ctx.beginPath()
            ctx.addPath(thePath)
            ctx.setLineWidth(5)
            ctx.strokePath()
        }
        
        func display(_ layer: CALayer) {
            layer.contents = UIImage.init(named: "layer_border_background_2x")?.cgImage
            layer.contentsGravity = kCAGravityCenter
        }
    }
}
