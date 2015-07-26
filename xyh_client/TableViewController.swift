//
//  TableViewController.swift
//  xyh_client
//
//  Created by administrator on 15/7/22.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var newsList: UITableView!
    
    
    var postsCollection = [NSString]()
    var counts: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var postObj = PostServices()
        postObj.updateNews{
            (response) in
            self.loadPosts(response as NSArray)
        }
        // Do any additional setup after loading the view, typically from a nib.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadPosts(posts:NSArray){
        for post in posts{
            var title = post["news_title"]! as NSString
            postsCollection.append(title)
            dispatch_async(dispatch_get_main_queue()){
                self.newsList.reloadData()
            }
        }
    }
    
    
    
    @IBAction func backToTableinView(segue:UIStoryboardSegue) {}
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsCollection.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = newsList.dequeueReusableCellWithIdentifier("news") as UITableViewCell
        
        var post = postsCollection[indexPath.row] as NSString
        var label = cell.viewWithTag(101) as UILabel
        label.text = post
        return cell
    }
    
    
    
}
