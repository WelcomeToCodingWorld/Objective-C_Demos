//
//  ViewController.swift
//  TextFieldDemo
//
//  Created by zz on 2017/5/4.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self;
//        self.textField.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("wow!")
        return ((textField.text?.characters.count)! - range.length + string.characters.count)<=10 ;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        print("editingChanged")
        if sender === self.textField {
            if (sender.text?.characters.count)! > 10 {
                sender.text = sender.text?.substring(to: (sender.text?.index((sender.text?.startIndex)!, offsetBy: 10))!)
            }
        }
    }

}

