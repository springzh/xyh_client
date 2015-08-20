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
    
    @IBOutlet weak var pageControl: UIPageControl!
    var colors:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    var frame: CGRect = CGRectMake(0, 0, 0, 0)
    var timer: NSTimer!
    @IBOutlet weak var goToNewsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        //不显示垂直和水平滚动条
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        pageControl.defersCurrentPageDisplay = true
        pageControl.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        pageControl.numberOfPages = self.colors.count
        goToNewsBtn.hidden = true
        goToNewsBtn.addTarget(self, action: "goNewsList:", forControlEvents: UIControlEvents.TouchUpInside)
        goToNewsBtn.layer.borderWidth = 2
        goToNewsBtn.layer.cornerRadius = 10
        goToNewsBtn.tintColor = UIColor.blackColor()
        goToNewsBtn.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(scrollView)
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
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "autoScroll:", userInfo: nil, repeats: true)
    }
    
    func goNewsList(sender: AnyObject!){
        //通过idntifier实例化视图控制器
        var indexView = self.storyboard?.instantiateViewControllerWithIdentifier("revealviewcontroller") as! UIViewController
        self.presentViewController(indexView, animated: true, completion: nil)
    }
    
    func autoScroll(timers: NSTimer){
        var i = pageControl.currentPage
        if(i == colors.count - 1){
            timer.invalidate()
        }
        else{
            i++
        }
        self.scrollView.setContentOffset(CGPointMake(CGFloat(i) * self.scrollView.frame.width, 0), animated: true)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //重新添加定时器
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "autoScroll:", userInfo: nil, repeats: true)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        pageControl.updateCurrentPageDisplay()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //释放定时器
        self.timer.invalidate()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var current = self.scrollView.contentOffset.x / self.scrollView.frame.width
        self.pageControl.currentPage = Int(current)
        if(self.pageControl.currentPage == colors.count - 1){
            self.goToNewsBtn.hidden = false
        }
        else{
            self.goToNewsBtn.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
