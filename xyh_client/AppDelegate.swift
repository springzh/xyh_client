//
//  AppDelegate.swift
//  xyh_client
//
//  Created by administrator on 15/7/22.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        var pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.blackColor()
        pageController.backgroundColor = UIColor.whiteColor()
        
        let ver:String = UIDevice.currentDevice().systemVersion
        if (ver as NSString).floatValue >= 8.0{
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge , categories: nil))
        }
        
        //NSThread.sleepForTimeInterval(2)
        return true
    }
    
    //接收本地通知
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        let alert = UIAlertView(title: "通知", message: notification.alertBody, delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        //var notification = UIApplication.sharedApplication().
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //进入后台时添加本地通知... （测试功能）
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let notification = UILocalNotification()
        var date:NSDate = NSDate()
        notification.fireDate = date.dateByAddingTimeInterval(3.0)
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.alertBody = "这是一个本地通知"
        notification.alertAction = "知道了"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = 1;
        
        var aUserInfo:NSMutableDictionary = NSMutableDictionary()
        aUserInfo["kLocalNotificationID"] = "anID"
        notification.userInfo = aUserInfo as [NSObject : AnyObject]
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

