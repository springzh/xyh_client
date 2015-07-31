//
//  RegisterViewController.swift
//  xyh_client
//
//  Created by administrator on 15/7/22.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIAlertViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var registerNickname: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerNickname.delegate = self
        registerNickname.keyboardType = UIKeyboardType.Default
        registerNickname.placeholder = "请输入昵称"
        registerNickname.returnKeyType = UIReturnKeyType.Done
        registerNickname.clearButtonMode = UITextFieldViewMode.WhileEditing
        registerEmail.delegate = self
        registerEmail.keyboardType = UIKeyboardType.Default
        registerEmail.placeholder = "请输入希望注册的邮箱"
        registerEmail.returnKeyType = UIReturnKeyType.Done
        registerEmail.clearButtonMode = UITextFieldViewMode.WhileEditing
        registerPassword.delegate = self
        registerPassword.secureTextEntry = true
        registerPassword.keyboardType = UIKeyboardType.NumbersAndPunctuation
        registerPassword.placeholder = "请输入8位以上密码"
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
    
    func registerPost(callback:(NSDictionary)->()){
        var params:NSDictionary = ["email":registerEmail.text,"nick_name":registerNickname.text,"password":registerPassword.text]
        var url = "http://xiangyouhui.cn/api/v1/register"
        var register = PostServices()
        register.userDataPost(url, params: params, callback: callback)
    }
    
    @IBAction func registerSubmit(sender: AnyObject) {
        if(registerNickname.text == "" || registerEmail.text == "" || registerPassword.text == ""){
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
        registerNickname.resignFirstResponder()
        registerEmail.resignFirstResponder()
        registerPassword.resignFirstResponder()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == 2){
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}