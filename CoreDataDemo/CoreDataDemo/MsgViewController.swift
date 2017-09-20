//
//  MsgViewController.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import CoreData

class MsgViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var birthDateTF: UITextField!
    @IBOutlet var nameTF: UITextField!
    @IBAction func add(_ sender: Any) {
        if birthDateTF.text?.characters.count == 0 {
            alert(msg: "出生日期不能为空")
            return;
        }else{//验证日期格式
            do {
                let regex = try NSRegularExpression(pattern: "[1,2][0-9]{3}-((1[0-2])|(0[1-9]))-([0-2][0-9]|3[01])", options: NSRegularExpression.Options.allowCommentsAndWhitespace)
                if regex.matches(in: birthDateTF.text!, options: NSRegularExpression.MatchingOptions.anchored, range:NSMakeRange(0, (birthDateTF.text?.characters.count)!)).count != 1 {
                    alert(msg: "日期格式应为YYYY-MM-DD,请重新输入")
                    return
                }
            } catch {
                alert(msg: "regulareExpression for date failed to create")
                return
            }
        }
        
        if nameTF.text?.characters.count == 0 {
            alert(msg: "姓名不能为空")
            return;
        }
        
        managedObjectContext.performChange {
//            print(Locale.availableIdentifiers)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.doesRelativeDateFormatting = false
            formatter.formattingContext = .standalone
            print(formatter.string(from: Date()))
            if let date = formatter.date(from: self.birthDateTF.text!){
                print("Date format failed")
                _ = Person.insert(into: self.managedObjectContext ,name:self.nameTF.text!,dateOfBirth: date)
            }else{
                _ = Person.insert(into: self.managedObjectContext ,name:self.nameTF.text!,dateOfBirth: Date())
            }
        }
    }
    
    private func alert(msg:String){
        let alertController = UIAlertController.init(title: "温馨提示", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        //            show(alertController, sender: self)
        let alertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func selectX(_ sender:Any)  {
        let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        employeesFetch.returnsDistinctResults = true
        employeesFetch.fetchLimit = 10
        
        do {
            let allUsers = try self.managedObjectContext.fetch(employeesFetch) as! [Person]
            var tempStr = ""
            
            for item in allUsers{
                tempStr += (item.name + item.dateOfBirth.description + "")
            }
            textView.text = tempStr
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    
    var managedObjectContext : NSManagedObjectContext!
    
    var activeTextField:UITextField?{
        willSet{
            if newValue == nil{
                print("the activeTextField is being set to nil")
            }
        }
        
        didSet{
            if  activeTextField?.text == nil {
                print("the activeTextField has been set to nil")
            }else{
                print("The activeTextField now has a value")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
                fatalError("No active textField found")
            }
            
            if screenRect.contains((self.activeTextField?.frame.origin)!) {
                self.scrollView.scrollRectToVisible((self.activeTextField?.frame)!, animated: true)
            }else{
                print("need not to adjust")
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
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.activeTextField?.endEditing(true)
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

extension MsgViewController:UITextFieldDelegate{
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
