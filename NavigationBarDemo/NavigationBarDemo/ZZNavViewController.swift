//
//  ZZNavViewController.swift
//  NavigationBarDemo
//
//  Created by zz on 2017/7/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ZZNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backIndicatorImage = UIImage()
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage()
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
