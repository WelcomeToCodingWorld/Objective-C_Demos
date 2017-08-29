//
//  ViewController.swift
//  CATransform3DDemo
//
//  Created by zz on 2017/8/28.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let delegate = LayerDelegate()
    
    lazy var sublayer: CALayer = {
        let layer = CALayer()
        layer.delegate = self.delegate
        
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
    }
}

