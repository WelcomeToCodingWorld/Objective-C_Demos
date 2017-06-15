        //
//  ViewController.swift
//  KVCDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var topSpace: NSLayoutConstraint!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var ageField: UITextField!
    let me = Person(name: "Lee",age:26)
    var currentField : UITextField?
    var originTopSpace = CGFloat()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originTopSpace = topSpace.constant
        // Do any additional setup after loading the view, typically from a nib.
        //MARK:register for receive keyboardNotification
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: OperationQueue.main) { (notification:Notification) in
            let keyBoardFrame:CGRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
            if (self.currentField?.frame.maxY)! > keyBoardFrame.origin.y {
                UIView.animate(withDuration:0.25, animations: { 
                    self.topSpace.constant -= (self.currentField?.frame.maxY)! - keyBoardFrame.origin.y
                })
            }
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: OperationQueue.main) { (notification:Notification) in
            self.topSpace.constant = self.originTopSpace
        }
        
        
        //access Object's property
        let gabrielle = Person(name: "Gabrielle" ,age:11)
        let jim = Person(name: "Jim",age:12)
        let yuanyuan = Person(name: "Yuanyuan",age:10)
        
        gabrielle.friends = [jim, yuanyuan]
        gabrielle.bestFriend = yuanyuan
        

        print(gabrielle.value(forKey: #keyPath(Person.name))!)

        print(gabrielle.value(forKeyPath: #keyPath(Person.bestFriend.name))!)

        print(gabrielle.value(forKeyPath: #keyPath(Person.friends.name))!)
        
        
        //access collection properties
        
        
        let myAccount = BankAccount()
        let transaction1 = Transaction(payee: "Green Power", amount: 120.0, date: Date(timeIntervalSince1970: 12000))
        let transaction2 = Transaction(payee: "Green Power", amount: 150.0, date: Date(timeIntervalSince1970: 10000))
        let transaction3 = Transaction(payee: "Green Power", amount: 180.0, date: Date(timeIntervalSince1970: 150000))
        let transaction4 = Transaction(payee: "Green Power", amount: 280.0, date: Date(timeIntervalSince1970: 200000))
        myAccount.transactions = [transaction1,transaction2,transaction3,transaction4]
        
        let transactionAvg = (myAccount.transactions! as NSArray).value(forKeyPath: "@avg.amount") as! Double
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.formatterBehavior = .default
        
        if let avgStr = numberFormatter.string(from: NSNumber(floatLiteral: transactionAvg)) {
            print("The average amount of money is \(avgStr))")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nameField.text = self.me.name
        self.ageField.text = String(self.me.age)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    //MARK:UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentField = textField
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameField {
            self.me.setValue(textField.text , forKey: #keyPath(Person.name))
        }else{
            if let age = UInt(textField.text!) {
                self.me.setValue(age, forKey: #keyPath(Person.age))
            }else{
                self.me.setValue(nil, forKey: #keyPath(Person.age))
            }
            
        }
    }
    
    //MARK:Deinit
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }

}

