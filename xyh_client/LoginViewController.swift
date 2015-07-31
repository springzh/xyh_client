//
//  LoginViewController.swift
//  xyh_client
//
//  Created by administrator on 15/7/22.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var rememberMe: UILabel!
    //测试用数据源
//    var loginDict = ["email": "123456789@qq.com", "password": "123456"]
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    //实例化默认偏好设置类
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //判断偏好设置是否为空
        if(defaults.objectForKey("userEmail") as? String != ""){
            loginEmail.text = defaults.objectForKey("userEmail") as? String
            if(defaults.objectForKey("password") as? String != ""){
                loginPassword.text = defaults.objectForKey("password") as? String
            }
        }
        //初始化默认偏好设置
        let myDefaults = ["userEmail": "", "password": ""]
        defaults.registerDefaults(myDefaults)
        //初始化控件
        loginPassword.delegate = self
        loginPassword.keyboardType = UIKeyboardType.NumbersAndPunctuation
        loginPassword.placeholder = "请输入8位以上密码"
        loginPassword.secureTextEntry = true
        loginPassword.returnKeyType = UIReturnKeyType.Done
        loginPassword.clearButtonMode = UITextFieldViewMode.WhileEditing
        loginEmail.delegate = self
        loginEmail.keyboardType = UIKeyboardType.Default
        loginEmail.placeholder = "输入注册时使用的邮箱"
        loginEmail.returnKeyType = UIReturnKeyType.Done
        loginEmail.clearButtonMode = UITextFieldViewMode.WhileEditing
        userId.hidden = true
        logoutBtn.setTitle("退出登录", forState: .Normal)
        logoutBtn.hidden = true
        checkbox.layer.borderWidth = 2
        checkbox.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnMessage(message: NSDictionary){
        let status = message["status"] as! Int
        let error = message["error"] as! NSArray
        if(status == 0){
            let alert:UIAlertView = UIAlertView(title: "信息", message: "登录失败，email不存在或密码错误", delegate: self, cancelButtonTitle: "OK")
            alert.tag = 3
            alert.show()
        }
        else{
            let alert:UIAlertView = UIAlertView(title: "信息", message: "登录成功", delegate: self, cancelButtonTitle: "OK")
            alert.tag = 2
            alert.show()
        }
    }
    
    func loginPost(callback:(NSDictionary)->()){
        var params:NSDictionary = ["email":loginEmail.text,"password":loginPassword.text]
        var url = "http://xiangyouhui.cn/api/v1/register"
        var login = PostServices()
        login.userDataPost(url, params: params, callback: callback)
    }
    
    @IBAction func backToLoginView(segue:UIStoryboardSegue) {}
    
    @IBAction func checkboxChange(sender: AnyObject) {
        if(checkbox.backgroundColor == UIColor.whiteColor()){
            checkbox.backgroundColor = UIColor.orangeColor()
        }
        else{
            checkbox.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func logoutSubmit(sender: AnyObject) {
        let alert:UIAlertView = UIAlertView(title: "提醒", message: "确定退出吗？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.tag = 4
        alert.show()
    }
    @IBAction func loginSubmit(sender: AnyObject) {
        if(loginEmail.text == "" || loginPassword.text == ""){
            let alert:UIAlertView = UIAlertView(title: "提示", message: "登录信息不能为空", delegate: self, cancelButtonTitle: "知道了")
            alert.tag = 1
            alert.show()
        }
        else{
            if(checkbox.backgroundColor == UIColor.orangeColor()){
                defaults.setObject(loginPassword.text, forKey: "password")
            }
            defaults.setObject(loginEmail.text, forKey: "userEmail")
            self.loginPost{
                (response) in
                self.returnMessage(response as NSDictionary)
            }
        }
    }
    //委托方法，点击return，退出键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //委托方法，点击空白地方退出键盘

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        loginEmail.resignFirstResponder()
        loginPassword.resignFirstResponder()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == 2){
            checkbox.hidden = true
            rememberMe.hidden = true
            emailLabel.hidden = true
            passwordLabel.hidden = true
            loginEmail.hidden = true
            loginPassword.hidden = true
            loginBtn.hidden = true
            userId.hidden = false
            logoutBtn.hidden = false
            userId.text = loginEmail.text as String
        }
        else if(alertView.tag == 4 && buttonIndex == 1){
            checkbox.hidden = true
            rememberMe.hidden = true
            emailLabel.hidden = false
            passwordLabel.hidden = false
            loginEmail.hidden = false
            loginPassword.hidden = false
            loginBtn.hidden = false
            userId.hidden = true
            logoutBtn.hidden = true
            loginPassword.text = ""
            userId.text = ""
        }
    }
}