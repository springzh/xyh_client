//
//  RegisterViewController.swift
//  xyh_client
//
//  Created by administrator on 15/7/22.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIAlertViewDelegate {
    
    @IBOutlet weak var registerNickname: UITextField!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerSubmit(sender: AnyObject) {
        if(registerNickname.text == "" || registerEmail.text == "" || registerPassword.text == ""){
            let alert = UIAlertView()
            alert.delegate = self
            alert.title = "提示"
            alert.message = "注册信息不能为空"
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
        
    }
    
}