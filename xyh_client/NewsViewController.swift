//
//  NewsViewController.swift
//  xyh_client
//
//  Created by administrator on 15/7/27.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var postobj = PostServices()
    var newsId: Int!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getNews{
            (response) in
            self.loadPost(response as NSDictionary)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPost(news:NSDictionary){
        titleLabel.text = news["news_title"] as? String
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        titleLabel.sizeToFit()
        var content = news["news_content"] as String
        webView.loadHTMLString(content, baseURL: nil)
    }
    
    func getNews(callback:(NSDictionary)->()){
        var url = "http://xiangyouhui.cn/api/v1/article?id=\(newsId)"
        postobj.getNewJson(url, callback: callback)
    }

    
}
