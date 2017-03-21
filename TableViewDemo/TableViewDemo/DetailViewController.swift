//
//  DetailViewController.swift
//  TableViewDemo
//
//  Created by zz on 2017/2/10.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 10, y: 100, width: 355, height: 30));
        label.backgroundColor = UIColor.blue;
        label.textAlignment = .center;
        label.textColor = UIColor.white;
        label.text = "Hello,swift!";
        label.layer.cornerRadius = 3.0;
        label.layer.masksToBounds = .init(booleanLiteral: true);
        self.view.addSubview(label);        
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
