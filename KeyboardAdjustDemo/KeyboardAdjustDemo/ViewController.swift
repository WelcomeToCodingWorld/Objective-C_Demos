//
//  ViewController.swift
//  KeyboardAdjustDemo
//
//  Created by zz on 09/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tfs: [UITextField]!
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.keyboardDismissMode = .onDrag
        automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets = UIEdgeInsetsMake(10, 10, 10, 10)
            printLog(view.safeAreaInsets)
        } else {
            // Fallback on earlier versions
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printLog("\(scrollView.contentInset):\(scrollView.contentOffset)")
        
    }

    

}

extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    }
}

extension ViewController:UITextViewDelegate {
    
}

