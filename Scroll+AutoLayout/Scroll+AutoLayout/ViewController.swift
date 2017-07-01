//
//  ViewController.swift
//  Scroll+AutoLayout
//
//  Created by zz on 2017/6/29.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    var activeTextField:UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let leftEdgeAlign = NSLayoutConstraint(item: self.contentView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let rightEdgeAlign = NSLayoutConstraint(item: self.contentView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        self.view.addConstraints([leftEdgeAlign,rightEdgeAlign])
        self.registerKeyboardNotification()
    }
    
    func registerKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: OperationQueue.main) { (notification) in
            print("The \(NSNotification.Name.UIKeyboardDidShow.rawValue) notification received")
            let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardRect?.size.height)!, right: 0)
            
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var screenRect = self.view.frame
            screenRect.size.height -= (keyboardRect?.size.height)!
            
            guard self.activeTextField != nil else{
                fatalError("active textField has not found")
            }
            
            if screenRect.contains((self.activeTextField?.frame.origin)!) {
                self.scrollView.scrollRectToVisible((self.activeTextField?.frame)!, animated: true)
            }
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification) in
            print("The \(NSNotification.Name.UIKeyboardWillHide.rawValue) notification received")
            let contentInsets = UIEdgeInsets.zero
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
        
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

