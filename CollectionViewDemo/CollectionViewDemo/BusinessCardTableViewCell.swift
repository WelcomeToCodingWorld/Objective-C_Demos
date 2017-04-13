//
//  BusinessCardTableViewCell.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/4/5.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

fileprivate class BusinessCardTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var comAddrLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let nameLab = nameLabel {
            print(nameLab);
        }
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
