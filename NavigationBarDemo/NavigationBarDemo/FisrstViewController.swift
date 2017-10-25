//
//  FisrstViewController.swift
//  NavigationBarDemo
//
//  Created by zz on 2017/7/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
class FisrstViewController: UIViewController {

    var defaultBgImage : UIImage?
    var defaultShadowImage : UIImage?
    var defaultNavColor : UIColor?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FirstVC"
        defaultBgImage = navigationController?.navigationBar.backgroundImage(for: .default)
        defaultShadowImage = navigationController?.navigationBar.shadowImage
        defaultNavColor = navigationController?.view.backgroundColor
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(defaultBgImage, for: .default)
        navigationController?.navigationBar.shadowImage = defaultShadowImage
        navigationController?.view.backgroundColor = defaultNavColor
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
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
