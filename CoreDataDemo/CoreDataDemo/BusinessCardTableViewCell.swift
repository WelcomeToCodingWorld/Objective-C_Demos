//
//  BusinessCardTableViewCell.swift
//  CoreDataDemo
//
//  Created by zz on 2017/6/27.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class BusinessCardTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    

}


private let dateFormatter:DateFormatter = {
    let xformatter = DateFormatter()
    xformatter.dateStyle = .medium
    xformatter.timeStyle = .short
    xformatter.doesRelativeDateFormatting = true
    xformatter.formattingContext = .standalone
    return xformatter
}()

extension BusinessCardTableViewCell{
    func config(with person:Person) {
        nameLabel.text = person.name
        ageLabel.text = dateFormatter.string(from: person.dateOfBirth)
    }
}
