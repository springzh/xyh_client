//
//  Postservices.swift
//  xyh_client
//
//  Created by administrator on 15/7/26.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class PostServices{
    var dataArray: NSMutableArray = NSMutableArray()
    
    
    func getNewJson(url:String,callback:(NSDictionary)->()) {
        let manager = AFHTTPRequestOperationManager()
        
        var aobject = manager.GET(url,
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

    
    func getNewsListJson(url:String,callback:(NSArray)->()) {
        let manager = AFHTTPRequestOperationManager()
        
        var aobject = manager.GET(url,
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


