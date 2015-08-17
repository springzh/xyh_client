//
//  CityTableViewController.swift
//  xyh_client
//
//  Created by administrator on 15/8/3.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cityCollection: NSArray = ["广州","北京","上海","深圳","珠海","长沙","武汉"]
    var cityList = NSMutableArray()
    var cityTableView = UITableView()
    var cityNavBar = UINavigationBar()
    var cityNavBarItem = UINavigationItem(title: "添加城市")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var header = UIView(frame: CGRectMake(0, 0, 400, 55))
        self.tableView.tableHeaderView = header
        var footer = UIView(frame: CGRectMake(0, 0, 400, 55))
        self.tableView.tableFooterView = footer
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        cityNavBar.frame = CGRectMake(0, 0, 400, 55)
        cityNavBar.barTintColor = UIColor.orangeColor()
        cityNavBar.pushNavigationItem(cityNavBarItem, animated: false)
        cityNavBarItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "backNewsList")
        cityNavBarItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        self.tableView.addSubview(cityNavBar)
        loadCityList(self.cityCollection)
    }
    
    func backNewsList(){
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func loadCityList(cityLists: NSArray){
        for city in cityLists{
            self.cityList.addObject(city)
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = CityTableViewCell()
        cell.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: -50)
        cell.textLabel?.text = self.cityList[indexPath.row] as? String
        return cell
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.cityList.count
    }

}
