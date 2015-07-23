//
//  MenuController.swift
//  xyh_client
//
//  Created by administrator on 15/7/23.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    @IBOutlet weak var exitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.orangeColor()
        
    }

    @IBAction func exitProgram(sender: AnyObject) {
        exit(0)
    }
}
