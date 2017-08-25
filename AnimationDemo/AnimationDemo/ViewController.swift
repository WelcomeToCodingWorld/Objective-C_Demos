//
//  ViewController.swift
//  AnimationDemo
//
//  Created by zz on 2017/7/10.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    let thirdView = UIView()
    
    
    @IBAction func test(_ sender: Any) {
        testAlpha()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(thirdView)
 
        // Creating the same constraints using Layout Anchors
        view.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 15)
        let margins = view.layoutMarginsGuide

        thirdView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        thirdView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        thirdView.topAnchor.constraint(equalTo: secondView.layoutMarginsGuide.bottomAnchor, constant:80).isActive = true
        thirdView.backgroundColor = UIColor.blue
//        print("\(#function)\n\(thirdView.constraintsAffectingLayout(for: UILayoutConstraintAxis.horizontal))")
    }
    
    
    func testAlpha() {
        _ = delay(2){
//            UIView.animate(withDuration: 1) {
//                self.firstView.alpha = 0
//                self.secondView.alpha = 1
//            }
            
        }
        
//        UIView.animateKeyframes(withDuration: 2, delay: 5, options: UIViewKeyframeAnimationOptions.autoreverse, animations: {
//            self.firstView.alpha = 0
//            self.secondView.alpha = 1
//        }, completion: nil)
        
//        UIView.transition(from: firstView, to: secondView, duration: 1, options: UIViewAnimationOptions.showHideTransitionViews, completion: nil)
        
        UIView.transition(with: self.view, duration: 2, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
            self.firstView.removeFromSuperview()
//            self.view.addSubview(self.thirdView)
            
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.  
    }


}

