//
//  RecipViewController.swift
//  AnimationDemo
//
//  Created by zz on 2017/7/11.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class RecipViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroll()
        // Do any additional setup after loading the view.
    }

    @IBAction func addItem(_ sender: Any) {
        
    }
    
    func setupScroll() {
        let inset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        scrollView.contentInset = inset
        scrollView.scrollIndicatorInsets = inset
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
