//
//  DetailViewController.swift
//  SearchControllerDemo
//
//  Created by zz on 2017/5/6.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    static let storyboardName = "Main"
    static let viewControllerIdentifier = "DetailViewController"
    static let restoreProduct = "restoreProductKey"
    var product : Product!
    
    class func detailViewControllerForProduct(_ product:Product) -> DetailViewController {
        let storyboard = UIStoryboard(name: DetailViewController.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailViewController.viewControllerIdentifier) as! DetailViewController
        viewController.product = product;
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product.title
        yearLabel.text = "\(product.title)"
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.formatterBehavior = .default
        let priceString = numberFormatter.string(from: NSNumber(value: product.introPrice))
        priceLabel.text = "\(priceString!)"
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
