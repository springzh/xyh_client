//
//  Postservices.swift
//  xyh_client
//
//  Created by administrator on 15/7/26.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class PostServices{
    
    //请求获取资讯详情
    func getNewJson(url:String,callback:(NSDictionary)->()) {
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                var json = responseObject as NSDictionary
                var list = json["news"] as NSDictionary
                callback(list)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)}
        )
        
    }
    
    //请求提交用户信息
    func userDataPost(url:String,params:NSDictionary,callback:(NSDictionary)->()){
        let manager = AFHTTPRequestOperationManager()
        manager.GET(url,
            parameters: params,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                var json = responseObject as NSDictionary
                callback(json)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)}
        )
    }

    //请求获取资讯列表
    func getNewsListJson(url:String,callback:(NSArray)->()) {
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                var list = responseObject as NSArray
                callback(list)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)}
        )
        
    }
}

class NewsInit {
    var newsId: Int!
    var newsTitle: NSString!
    var newsContent: NSString!
    init(id:Int, title:NSString, content:NSString){
        newsId = id
        newsTitle = title
        newsContent = content
    }
}

class PostInit {
    var newsId: Int!
    var newsTitle: NSString!
    init(id: Int,title: NSString){
        newsId = id
        newsTitle = title
    }
}


