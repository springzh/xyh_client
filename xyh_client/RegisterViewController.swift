//
//  RegisterViewController.swift
//  xyh_client
//
//  Created by administrator on 15/7/22.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIAlertViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var registerText1: UITextField!
    @IBOutlet weak var registerText2: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var verificationCode: UIButton!
    var segmentIndex:Int = 0
    var timerCount:UILabel!
    var timer:NSTimer!
    var seconds = 60
    @IBOutlet weak var segment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var timerCountFrame = CGRectMake(CGRectGetMidX(verificationCode.frame) + 70, CGRectGetMaxY(verificationCode.frame) - 10, 40, 20)
        timerCount = UILabel(frame: timerCountFrame)
        timerCount.hidden = true
        verificationCode.addSubview(timerCount)
        registerText1.placeholder = "请输入您的手机号码"
        registerText2.placeholder = "请输入输入验证码"
        registerPassword.placeholder = "设置你的密码"
        verificationCode.setTitle("获取验证码", forState: .Normal)
        verificationCode.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        verificationCode.tintColor = UIColor.blackColor()
        verificationCode.backgroundColor = UIColor.grayColor()
        registerText1.delegate = self
        registerText1.keyboardType = UIKeyboardType.NumberPad
        registerText1.returnKeyType = UIReturnKeyType.Done
        registerText1.clearButtonMode = UITextFieldViewMode.WhileEditing
        registerText2.delegate = self
        registerText2.keyboardType = UIKeyboardType.NumberPad
        registerText2.returnKeyType = UIReturnKeyType.Done
        registerText2.clearButtonMode = UITextFieldViewMode.WhileEditing
        registerPassword.delegate = self
        registerPassword.secureTextEntry = true
        registerPassword.keyboardType = UIKeyboardType.NumbersAndPunctuation
        registerPassword.returnKeyType = UIReturnKeyType.Done
        registerPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnMessage(message: NSDictionary){
        let status = message["status"] as! Int
        let error = message["error"] as! NSArray
        if(status == 0){
            let alert:UIAlertView = UIAlertView(title: "信息", message: "注册失败", delegate: self, cancelButtonTitle: "OK")
            alert.tag = 3
            alert.show()
            NSLog("status: %@, error: %@", status,error)
        }
        else{
            let alert:UIAlertView = UIAlertView(title: "信息", message: "注册成功", delegate: self, cancelButtonTitle: "OK")
            alert.tag = 2
            alert.show()
        }
    }
    
    func timerFireMethod(timer: NSTimer){
        if(self.seconds == 0){
            //设置按钮文字居中
            verificationCode.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
            self.timerCount.hidden = true
            segment.userInteractionEnabled = true
            self.seconds = 60
            timer.invalidate()
            verificationCode.enabled = true
            verificationCode.setTitle("获取验证码", forState: .Normal)
        }
        else{
            //设置按钮文字居左，并设置文字与左边框的距离为10
            verificationCode.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            verificationCode.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            self.seconds--
            verificationCode.enabled = false
            verificationCode.setTitle("重新获取", forState: .Disabled)
            self.timerCount.hidden = false
            self.timerCount.text = "\(self.seconds)"
        }
    }
    
    @IBAction func getVerification(sender: AnyObject) {
        if(self.segmentIndex == 0){
            //设置分段按钮不可用
            segment.userInteractionEnabled = false
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFireMethod:", userInfo: nil, repeats: true)
        }
        else{
        }
    }
    
    @IBAction func choiceWay(sender: UISegmentedControl) {
        self.segmentIndex = sender.selectedSegmentIndex
        switch sender.selectedSegmentIndex{
        case 0:
            registerText1.placeholder = "请输入您的手机号码"
            registerText2.placeholder = "请输入输入验证码"
            registerPassword.placeholder = "设置你的密码"
            verificationCode.setTitle("获取验证码", forState: .Normal)
        case 1:
            registerText1.placeholder = "请输入您的Email"
            registerText2.placeholder = "请输入验证码"
            registerPassword.placeholder = "设置你的密码"
            verificationCode.setTitle("发送激活邮件", forState: .Normal)
            registerText1.keyboardType = UIKeyboardType.NumbersAndPunctuation
        default:
            registerText1.placeholder = "请输入您的手机号码"
            registerText2.placeholder = "请输入输入验证码"
            registerPassword.placeholder = "设置你的密码"
            verificationCode.setTitle("获取验证码", forState: .Normal)
        }
    }
    
    
    func registerPost(callback:(NSDictionary)->()){
        var params:NSDictionary = ["email":registerText2.text,"nick_name":registerText1.text,"password":registerPassword.text]
        var url = "http://xiangyouhui.cn/api/v1/register"
        var register = PostServices()
        register.userDataPost(url, params: params, callback: callback)
    }
    
    @IBAction func registerSubmit(sender: AnyObject) {
        if(registerText1.text == "" || registerText2.text == "" || registerPassword.text == ""){
            let alert:UIAlertView = UIAlertView(title: "提示", message: "注册信息不能为空", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
        else{
            self.registerPost{
                (response) in
                self.returnMessage(response as NSDictionary)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        registerText1.resignFirstResponder()
        registerText2.resignFirstResponder()
        registerPassword.resignFirstResponder()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == 2){
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}