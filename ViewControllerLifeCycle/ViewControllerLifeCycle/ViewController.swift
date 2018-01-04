//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by zz on 2017/5/18.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Called after the controller's view is loaded into memory.
    var scrollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // MARK:- UnderStand the UIScrollView
        // Do any additional setup after loading the view, typically from a nib.
//        view.backgroundColor = UIColor.lightGray
        scrollView = UIScrollView(frame: view.bounds)
//        scrollView.frame.origin.y += 20
//        scrollView.frame.size.height -= 20
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        } else {
            // Fallback on earlier versions
        }
        scrollView.backgroundColor = UIColor.lightGray
//        scrollView.bounds = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(scrollView)
        let view1 = UIView(frame: CGRect(x: 15, y: 20, width: UIScreen.main.bounds.width - 2*15, height: 700))
        view1.backgroundColor = UIColor.cyan
        scrollView.addSubview(view1)
        scrollView.alwaysBounceVertical = true
        printLog(scrollView.contentSize)
        
        // When you change the contentInset, you changed the max and min value of contentOffset.
        // When you change the contentOffset , the scrollView's bounds is also changed relatively
        // So we can think of the bounds of a scrollView as a window into the scrollable area defined by contentSize
        scrollView.contentInset = UIEdgeInsetsMake(100, 0, 400, 0)//
        printLog("scrollView.contentSize:\(scrollView.contentSize)")//scrollView.contentSize:(0.0, 0.0)
        printLog("scrollView.bounds:\(scrollView.bounds)")//scrollView.bounds:(0.0, -100.0, 375.0, 667.0)
        printLog("scrollView.contentOffset:\(scrollView.contentOffset)")//scrollView.contentOffset:(0.0, -100.0)
        printLog("view.bounds:\(view.bounds)")
        if #available(iOS 11.0, *) {
            printLog("view.safeAreaInsets:\(view.safeAreaInsets)")
            printLog("scrollView.safeAreaInsets:\(scrollView.safeAreaInsets)")
            printLog("adjustedContentInset:\(scrollView.adjustedContentInset)")
        } else {
            // Fallback on earlier versions
        }
        
        // No,it's place is not expected.
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.contentOffset.y))
        view2.backgroundColor = UIColor.black
        view2.alpha = 0.1
        scrollView.addSubview(view2)
        
        scrollView.delegate = self
        
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToResetContentInset))
//        view1.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapToResetContentInset() {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        printLog(scrollView.contentOffset)
        printLog(scrollView.contentSize)
    }
    
    //The view controller calls this method when its view property is requested but is currently nil. This method loads or creates a view and assigns it to the view property.
    override func loadView() {
        super.loadView()
        
        // set custom view as rootView
//        self.view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    //Notifies the view controller that its view is about to be added to a view hierarchy.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Notifies the view controller that its view was added to a view hierarchy.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            printLog("view.safeAreaInsets:\(view.safeAreaInsets)")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            printLog("scrollView.safeAreaInsets:\(scrollView.safeAreaInsets)")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            printLog("adjustedContentInset:\(scrollView.adjustedContentInset)")
        } else {
            // Fallback on earlier versions
        }
        printLog("scrollView.contentOffset:\(scrollView.contentOffset)")
        printLog("view.bounds:\(view.bounds)")
        printLog("scrollView.contentSize:\(scrollView.contentSize)")
    }
    
    //
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        printLog("scrollView.bounds:\(scrollView.bounds)")
    }
}
