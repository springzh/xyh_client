//
//  SearchNavigation.swift
//  xyh_client
//
//  Created by administrator on 15/7/23.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class SearchNavigation: UINavigationController {
    @IBOutlet weak var searchNavBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchNavBar.barTintColor = UIColor.orangeColor()
    }
}
