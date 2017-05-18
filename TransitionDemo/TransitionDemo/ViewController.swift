//
//  ViewController.swift
//  TransitionDemo
//
//  Created by zz on 2017/3/22.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TransitionDemo"
        print("hello");
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func loadView() {
        super .loadView();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }

    @IBAction func transitionTest(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let DemoVC1 = sb.instantiateViewController(withIdentifier: "DemoVC1")
        DemoVC1.modalTransitionStyle = .flipHorizontal
        DemoVC1.modalPresentationStyle = .currentContext
        DemoVC1.title = "DemoVC1"
        self.navigationController?.show(DemoVC1, sender: self)
//        self.present(DemoVC1, animated: true, completion: nil)
        
//        self.show(DemoVC1, sender: self)        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

