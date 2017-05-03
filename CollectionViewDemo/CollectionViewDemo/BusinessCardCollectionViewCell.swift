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
    public var user : User?{
        willSet{
            
        }
        
        didSet{
            self.titleLabel.text = user?.name
        }
    }
    override func awakeFromNib() {

        super.awakeFromNib()
        
    }
    
}
