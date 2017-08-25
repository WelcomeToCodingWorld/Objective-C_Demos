//
//  ProductCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/8/23.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet var productIdLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    
    var product:Product?{
        didSet{
            productIdLabel.text = product?.productId
            productNameLabel.text = product?.productName
        }
    }
}
