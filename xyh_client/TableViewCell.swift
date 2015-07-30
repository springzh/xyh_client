//
//  TableViewCell.swift
//  xyh_client
//
//  Created by administrator on 15/7/30.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.imageView?.frame = CGRectMake(0, 0, 80, 40)
        self.textLabel?.frame = CGRectMake(80, 0, 300, 40)
    }

}
