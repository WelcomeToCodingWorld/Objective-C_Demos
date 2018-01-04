//
//  ViewController.swift
//  ScrollLayout_ContentOffset_Test
//
//  Created by ari 李 on 03/01/2018.
//  Copyright © 2018 ari 李. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

