//
//  ViewController.swift
//  ScrollView_Gesture
//
//  Created by zz on 2017/1/14.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(x: 0, y: 100, width: 375, height: 70);
        
        let scrollView = UIScrollView(frame: rect)
        scrollView.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 1, alpha: 0.3)
        let gesture = UITapGestureRecognizer(target: self,action: #selector(test))
        let images = ["zwt_140-140","zwt_140-140","zwt_140-140","zwt_140-140","zwt_140-140","zwt_140-140","zwt_140-140"]
        for index in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(origin:CGPoint(x:15 + index*(70 + 15),y:0), size: CGSize(width: 70, height: 80)))
            scrollView.addSubview(imageView)
            imageView.image = UIImage(named: images[index])
        }
        
        scrollView.delegate = self
        scrollView .addGestureRecognizer(gesture)
        scrollView.contentSize = CGSize(width: images.count*(15 + 70 )  + images.count*15, height: 70)
        
        self.view .addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        print("gesture")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scroll")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scroll")
    }
}

