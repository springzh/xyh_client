//
//  LoginNavigation.swift
//  xyh_client
//
//  Created by administrator on 15/7/23.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class LoginNavigation: UINavigationController {
    @IBOutlet weak var loginNavBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginNavBar.barTintColor = UIColor.orangeColor()
    }
}
