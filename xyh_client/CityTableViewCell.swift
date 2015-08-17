//
//  CityTableViewCell.swift
//  xyh_client
//
//  Created by administrator on 15/8/3.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.textLabel?.frame = CGRectMake(10, 20, 100, 20)
        self.textLabel?.font = UIFont(name: "Helvetica", size: 25)
    }

}
