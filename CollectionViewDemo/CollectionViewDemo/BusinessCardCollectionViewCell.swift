//
//  BusinessCardCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/4/5.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class BusinessCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    private var user : User{
        get{
            return self.user
        }
        
        set{
            self.user = newValue
            titleLabel.text = newValue.name
        }
    }
    
    override func awakeFromNib() {

        super.awakeFromNib()
        
    }
    
}
