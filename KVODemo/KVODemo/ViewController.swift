//
//  ViewController.swift
//  KVODemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lSlide: UISlider!
    @IBOutlet var aSlide: UISlider!
    @IBOutlet var bSlide: UISlider!
    
    @IBOutlet var colorView: UIView!
    
    @IBAction func updateLComponent(_ sender: UISlider) {
        self.labColor.setValue(Double(sender.value), forKey: #keyPath(LabColor.lComponent))
    }
    @IBAction func updateAComponent(_ sender: UISlider) {
        self.labColor.setValue(Double(sender.value), forKey: #keyPath(LabColor.aComponent))
    }
    @IBAction func updateBComponent(_ sender: UISlider) {
        self.labColor.setValue(Double(sender.value), forKey: #keyPath(LabColor.bComponent))
    }
    
    var labColor = LabColor(){
        didSet{
            lSlide.value = Float(labColor.lComponent);
            aSlide.value = Float(labColor.aComponent);
            bSlide.value = Float(labColor.bComponent);
        }
    }
    override func viewDidLoad() {
        self.labColor.addObserver(self, forKeyPath: #keyPath(LabColor.color), options: NSKeyValueObservingOptions.initial, context: nil)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            self.colorView.backgroundColor = self.labColor.color
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        self.labColor.removeObserver(self, forKeyPath: #keyPath(LabColor.color), context: nil)
    }
}

