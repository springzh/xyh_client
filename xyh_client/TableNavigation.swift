//
//  TableViewNavigation.swift
//  xyh_client
//
//  Created by administrator on 15/7/23.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class TableNavigation: UINavigationController {
    
    @IBOutlet weak var tableNavBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNavBar.barTintColor = UIColor.orangeColor()
    }
}
