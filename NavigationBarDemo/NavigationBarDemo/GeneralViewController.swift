//
//  GeneralViewController.swift
//  NavigationBarDemo
//
//  Created by zz on 2017/7/4.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class GeneralViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        // Do any additional setup after loading the view.
    }
    
    func observeKeyboard() {
        let notiCenter = NotificationCenter.default
        notiCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification) in
            
        }
        
        notiCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification) in
            
        }
        
    }
    
    deinit {
        let notiCenter = NotificationCenter.default
        notiCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notiCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
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

extension GeneralViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.endEditing(true)
            return false
        }
        return true
    }
}

extension GeneralViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
