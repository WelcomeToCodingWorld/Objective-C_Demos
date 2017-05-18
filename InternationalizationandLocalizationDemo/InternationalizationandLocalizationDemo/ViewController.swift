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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameLabel.text = NSLocalizedString("name", comment: "The text of the nameLabel")
        ageLabel.text = NSLocalizedString("age", comment: "The text of the ageLabel")
        nationalityLabel.text = NSLocalizedString("nationality", comment: "The text of the nationalityLabel")
        genderLabel.text = NSLocalizedString("gender", comment: "The text of the genderLabel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

