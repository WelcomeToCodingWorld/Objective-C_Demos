//
//  ViewController.swift
//  InternationalizationandLocalizationDemo
//
//  Created by zz on 2017/5/18.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var nationalityLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    
    @IBOutlet var alertBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        alertBtn.layer.cornerRadius = 3.0;
    }
    @IBAction func alert(_ sender: Any) {
        let alertController = UIAlertController(title: NSLocalizedString("FriendlyTips", comment: "alertController的标题"), message: NSLocalizedString("Please operate carefully!", comment: "alertController的message"), preferredStyle: UIAlertControllerStyle.alert)
        let cancleAction = UIAlertAction(title: NSLocalizedString("OK", comment: "确认按钮的文本"), style: UIAlertActionStyle.cancel, handler: { (alertAction) in
            
        })
        
        let sureAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "取消按钮的文本"), style: UIAlertActionStyle.default, handler: { (alertAction) in
            
        })
        
        alertController.addAction(cancleAction)
        alertController.addAction(sureAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

