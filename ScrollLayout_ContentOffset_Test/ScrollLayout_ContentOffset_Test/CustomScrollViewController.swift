//
//  CustomScrollViewController.swift
//  ScrollLayout_ContentOffset_Test
//
//  Created by ari 李 on 03/01/2018.
//  Copyright © 2018 ari 李. All rights reserved.
//

import UIKit
import SnapKit

class CustomScrollViewController: UIViewController {
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
    
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width:5*screenW,height:0)
        scrollView.isPagingEnabled = true
        // when contentSize is not known,it doesn't work
        scrollView.setContentOffset(CGPoint(x: 4*screenW, y: 0), animated: true)
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        print(view.safeAreaInsets)
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // contentSize of the scrollView is still unknown
        // so it's still doesn't work
//        scrollView.setContentOffset(CGPoint(x: 4*screenW, y: 0), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        scrollView.setContentOffset(CGPoint(x: 4*screenW, y: 0), animated: true)
    }
    
    private func setupScroll() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalToSuperview()
        }
        
//        let contentView = UIView()
//        scrollView.addSubview(contentView)
//        contentView.snp.makeConstraints { (maker) in
//            maker.left.equalToSuperview()
//            maker.right.equalToSuperview()
//            maker.top.equalToSuperview()
//            maker.height.equalToSuperview()
////            maker.bottom.equalToSuperview()
//        }
        
        for idx in 0...4 {
            let item = UIView()
            item.frame = CGRect(x: 0, y: 0, width: CGFloat(idx)*screenW, height: screenH - 20)
            item.backgroundColor = UIColor.cyan
            scrollView.addSubview(item)
            item.snp.makeConstraints({ (maker) in
                maker.left.equalTo(CGFloat(idx)*screenW)
                maker.width.equalTo(screenW)
                maker.top.equalToSuperview()
//                maker.bottom.equalToSuperview()
                maker.height.equalToSuperview()
            })
            
            // since contentSize is explictly set,why need this one.
//            if idx == 4 {
//                item.snp.makeConstraints({ (maker) in
//                    maker.right.equalToSuperview()
//                })
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
