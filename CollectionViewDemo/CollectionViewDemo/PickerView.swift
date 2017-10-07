//
//  PickerView.swift
//  CollectionViewDemo
//
//  Created by ari 李 on 08/10/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//


import UIKit
class PickerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UIPickerViewDemo"
        createView()
    }
    
    private func createView() {
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension PickerViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            //切换1，2 components中对应的数据源
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(1)
        }else if component == 1 {
            //切换2 components中对应的数据源
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        pickerView.reloadComponent(2)
    }
}

extension PickerViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            
        }else if component == 1 {
            
        }else if component == 2 {
            
        }
        return nil
    }
    
}
