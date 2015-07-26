//
//  Postservices.swift
//  xyh_client
//
//  Created by administrator on 15/7/26.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class PostServices{
    var dataArray:NSMutableArray = NSMutableArray()
    
    func updateNews(callback:(NSArray)->()){
        let url = "http://xiangyouhui.cn/api/v1/articles"
        getNewsJson(url, callback: callback)
    }
    
    
    func getNewsJson(url:String, callback:(NSArray)->()) {
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
