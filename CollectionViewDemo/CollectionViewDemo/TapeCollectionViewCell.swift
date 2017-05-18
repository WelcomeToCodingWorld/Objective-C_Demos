//
//  TapeCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/4/13.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class TapeCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        print("awakeFromNib")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        print("aDecoder")
    }
}
