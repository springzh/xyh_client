//
//  ScrollPageController.swift
//  xyh_client
//
//  Created by administrator on 15/8/17.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class ScrollPageController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    
    var pageControl: UIPageControl!
    var colors:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    var frame: CGRect = CGRectMake(0, 0, 0, 0)
    var timer: NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.scrollView.delegate = self
        //不显示垂直和水平滚动条
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.pageControl = UIPageControl(frame: CGRectMake(150, 600, 100, 40))
        self.pageControl.defersCurrentPageDisplay = true
        self.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.pageControl.numberOfPages = self.colors.count
        self.pageControl.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        for index in 0..<colors.count {
            
            //设置每个页面起点位置
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.pagingEnabled = true
            
            var subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView .addSubview(subView)
        }
        var current = self.scrollView.contentOffset.x / UIScreen.mainScreen().bounds.width
        self.pageControl.currentPage = Int(current)
        //设置滚动视图总的宽度,以限定边界
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * CGFloat(colors.count), self.scrollView.frame.size.height)
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "autoScroll:", userInfo: nil, repeats: true)
    }
    
    func autoScroll(timers: NSTimer){
        var i = self.pageControl.currentPage
        if(i == colors.count - 1){
            i = 0
        }
        else{
            i++
        }
        self.scrollView.setContentOffset(CGPointMake(CGFloat(i) * self.scrollView.frame.width, 0), animated: true)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //重新添加定时器
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "autoScroll:", userInfo: nil, repeats: true)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.pageControl.updateCurrentPageDisplay()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //释放定时器
        self.timer.invalidate()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var current = self.scrollView.contentOffset.x / self.scrollView.frame.width
        self.pageControl.currentPage = Int(current)
        if(self.pageControl.currentPage == colors.count){
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}