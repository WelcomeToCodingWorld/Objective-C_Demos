//
//  ViewController.swift
//  GCDDemo
//
//  Created by zz on 16/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var testLab: UILabel!
    var time:UInt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // MARK:- GCD
        let group = DispatchGroup()
        let workItem1 = DispatchWorkItem.init(block: {[weak self] in
            DispatchQueue.main.async {
                self?.testLab.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 30))
                self?.testLab.text = "Brown"
                print("Brown")
            }
        })
        
        let workItem2 = DispatchWorkItem.init(block: {[weak self] in
            DispatchQueue.main.async {
                self?.testLab.textAlignment = .center
                self?.testLab.center = (self?.view.center)!
                self?.testLab.text = "James"
                print("James")
            }
        })
        
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(group: group, execute: workItem1)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(group: group, execute: workItem2)
        
        let workItem3 = DispatchWorkItem.init(block: {[weak self] in
            DispatchQueue.main.async {
                self?.testLab.textAlignment = .center
                self?.testLab.center = (self?.view.center)!
                self?.testLab.text = "Kyrie Irving"
                print("Kyrie Irving")
            }
        })
        
        workItem3.notify(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default)) {
            print("What's going on!")
        }
        
        workItem3.notify(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default), execute: workItem2)
        

        DispatchQueue.global().async {
            print("Let me go first")
        }
        
        //Sets the target queue for the given object.
        
        // MARK:- Operation
        let operation1 = BlockOperation.init {
            print("this is a blockOperation")
        }
        
        operation1.completionBlock = {
            print("the operation is completed")
        }
        
        let operation2 = BlockOperation.init {
            print("this is the second blockOperation")
        }
        
        operation1.addDependency(operation2)
        OperationQueue.current?.addOperation(operation1)
        OperationQueue.current?.addOperation(operation2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

