//
//  TestViewController.swift
//  TransitionDemo
//
//  Created by zz on 2017/5/17.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBAction func toCustomVc(_ sender: Any) {
        let customVC = CustomViewController()
//        let noNibVC = NoNibViewController()
//        noNibVC.view.backgroundColor = UIColor.cyan
        self.navigationController?.pushViewController(customVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
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
