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
    
    @IBOutlet weak var tableFooterView: UIView!
    var postObj = PostServices()
    var postsCollection = [PostInit]()
    var moreJsonData = [PostInit]()
    var allJson: NSArray!
    //加载更多，状态，风火轮
    
    @IBOutlet weak var _aiv: UIActivityIndicatorView!
    
    @IBOutlet weak var loadMoreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //发出http请求并通过闭包提取json数据
        self.updateNews{
            (response) in
            self.loadPosts(response as NSArray)
            self.allJson = response as NSArray
            
        }
        // Do any additional setup after loading the view, typically from a nib.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //初始化下拉刷新控件
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "加载中......")
        self.refreshControl?.tintColor = UIColor.greenColor()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        //加载更多按钮背景视图
        tableFooterView.hidden = true
        //加载更多按钮
        loadMoreBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        loadMoreBtn.hidden = true
        //加载更多，状态，风火轮
        _aiv.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateNews(callback:(NSArray)->()){
        let url = "http://xiangyouhui.cn/api/v1/articles"
        postObj.getNewsListJson(url,callback: callback)
    }
    
    func loadMoreJson(json:NSArray){
        self.reloadJson(json)
    }
    
    func loadPosts(posts:NSArray){
        for(var i = 0; i < 20; i++){
            var title = posts[i]["news_title"] as NSString
            var idStr = posts[i]["news_id"] as String
            var id = idStr.toInt()
            var json = PostInit(id: id!, title: title)
            self.postsCollection.append(json)
            
            dispatch_async(dispatch_get_main_queue()){
                self.newsList.reloadData()
                self.tableFooterView.hidden = false
                self.loadMoreBtn.hidden = false
            }
        }
    }
    
    
    func reloadJson(json:NSArray){
        var postsCount = self.postsCollection.count
        for(var i = postsCount; i < postsCount + 18; i++){
            var titles = json[i]["news_title"] as String
            var idStrs = json[i]["news_id"] as String
            var id = idStrs.toInt()
            var json = PostInit(id: id!, title: titles)
            self.postsCollection.append(json)
            dispatch_async(dispatch_get_main_queue()){
                self.newsList.reloadData()
            }
        }
    }
    
    
    @IBAction func loadMore(sender:AnyObject) {
        if(self.postsCollection.count == 200){
            self.loadMoreBtn.setTitle("已经没有了", forState: .Normal)
        }
        else{
            loadMoreBtn.hidden = true
            _aiv.hidden = false
            _aiv.startAnimating()
            self.loadMoreJson(self.allJson)
        }
    }
    
    func refreshPosts(posts:NSArray){
        for post in posts{
            var title = post["news_title"]! as NSString
            var idStr = post["news_id"]! as String
            var id = idStr.toInt()
            var json = PostInit(id: id!, title: title)
            postsCollection.append(json)
        }
    }
    
    func refresh() {
        if self.refreshControl?.refreshing == true {
            self.refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        }
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.updateNews{
                    (response) in
                    self.refreshPosts(response as NSArray)
                }
                sleep(1)
                self.refreshControl?.endRefreshing()
                self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
                self.tableView.reloadData()
            })
        })
    }
    
    
    @IBAction func backToTableinView(segue:UIStoryboardSegue) {}
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postsCollection.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("newsdetail", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = newsList.dequeueReusableCellWithIdentifier("news") as UITableViewCell
        
        self.moreJsonData.append(postsCollection[indexPath.row] as PostInit)
        var post = postsCollection[indexPath.row] as PostInit
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        cell.textLabel?.text = post.newsTitle
        cell.textLabel?.tag = post.newsId
        cell.textLabel?.sizeToFit()
        var index = indexPath.row
        if(index == self.postsCollection.count - 1){
            self._aiv.stopAnimating()
            self._aiv.hidden = true
            self.loadMoreBtn.hidden = false
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var newsView = segue.destinationViewController as NewsViewController
        var indexPath = newsList.indexPathForSelectedRow()
        var cell = newsList.cellForRowAtIndexPath(indexPath!)
        newsView.newsId = cell?.textLabel?.tag
    }
    
}
