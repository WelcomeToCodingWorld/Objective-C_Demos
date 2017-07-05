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
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var textView: UITextView!
    var activeView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        // Do any additional setup after loading the view.
        observeKeyboard()
    }
    
    fileprivate func observeKeyboard() {
        let notiCenter = NotificationCenter.default
        notiCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification) in
            let kbF = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
            self.scrollView.contentInset = UIEdgeInsetsMake(10, 0, ((kbF?.size.height)! - 49), 0)
            self.scrollView.scrollRectToVisible((self.activeView?.frame)!, animated: true)
        }
        
        notiCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification) in
            self.scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
//            self.scrollView.contentOffset = CGPoint(x: 0, y: -10)
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if textView.contentSize.height < 200 {
                textView.contentSize.height = 200
            }
            textViewHeightConstraint.constant = textView.contentSize.height
            scrollView.layoutIfNeeded()
            scrollView.scrollRectToVisible(textView.frame, animated: true)
        }
    }

}

extension GeneralViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.endEditing(true)
            return false
        }
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeView = textView;
        textView.addObserver(self, forKeyPath: #keyPath(UITextView.contentSize), options: NSKeyValueObservingOptions.new, context: nil)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        activeView = nil
        textView.removeObserver(self, forKeyPath: #keyPath(UITextView.contentSize))
        return true
    }
}

extension GeneralViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeView = textField
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        activeView = nil
        return true
    }
}
