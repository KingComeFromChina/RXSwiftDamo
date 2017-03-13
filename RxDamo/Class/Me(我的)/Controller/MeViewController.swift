
//
//  MeViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactiveSwift
import Result

let minimumPhoneNumberLength = 11
let minimumPassWordLength = 8

let userNameTF = UITextField()
let phoneNumberLabel = UILabel()
let passWordTF = UITextField()
let passWordLabel = UILabel()

class MeViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self .creatView()
    }

    
    private func creatView(){
    
        
        userNameTF.frame = CGRect (x: 20, y: 80, width: WLWindowWidth - 40, height: 45)
        userNameTF.borderStyle = .roundedRect
        userNameTF.placeholder = "请输入你的手机号"
        userNameTF.delegate = self
        
        userNameTF.keyboardType = .numberPad
        userNameTF.textAlignment = .left
        userNameTF.adjustsFontSizeToFitWidth = true
        userNameTF.minimumFontSize = 14
        self.view.addSubview(userNameTF)
        
        
        phoneNumberLabel.frame = CGRect (x: 20, y: 80+55, width: WLWindowWidth - 40, height: 21)
        phoneNumberLabel.backgroundColor = UIColor.white
        phoneNumberLabel.textColor = UIColor.red
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 15)
        phoneNumberLabel.textAlignment = .left
        phoneNumberLabel.text = "请输入正确的手机号"
        self.view.addSubview(phoneNumberLabel)
        
        
        passWordTF.frame = CGRect (x: 20, y: 80+55+21+10, width: WLWindowWidth - 40, height: 45)
        passWordTF.borderStyle = .roundedRect
        passWordTF.delegate = self
        passWordTF.placeholder = "密码为字母加数字8～16位"
        passWordTF.keyboardType = .default
        passWordTF.textAlignment = .left
        passWordTF.returnKeyType = .done
        passWordTF.adjustsFontSizeToFitWidth = true
        passWordTF.minimumFontSize = 14
        self.view.addSubview(passWordTF)
        
        
        passWordLabel.frame = CGRect (x: 20, y: 80+55+21+10+10+45, width: WLWindowWidth - 40, height: 21)
        passWordLabel.backgroundColor = UIColor.white
        passWordLabel.textColor = UIColor.red
        passWordLabel.textAlignment = .left
        passWordLabel.font = UIFont.systemFont(ofSize: 15)
        passWordLabel.text = "密码为字母加数字8～16位"
        self.view.addSubview(passWordLabel)
        
        let loginBtn = UIButton()
        loginBtn.frame = CGRect (x: 20, y: 80+55+21+10+10+45+21+20, width: WLWindowWidth - 40, height: 55)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor.red
        loginBtn.setTitle("登录", for: .normal)
        self.view.addSubview(loginBtn)
        
            let userNameValid = userNameTF.rx.text.orEmpty
                .map { $0.characters.count == minimumPhoneNumberLength && self.isTelNumber(num: $0)}
                .shareReplay(1)
            
            let passwordValid = passWordTF.rx.text.orEmpty
                .map{ $0.characters.count >= minimumPassWordLength && $0.characters.count <= 16 && self.isTruePassWord(num: passWordTF.text!)}
                .shareReplay(1)
            
            let allValid = Observable.combineLatest(userNameValid, passwordValid){
                
                $0 && $1
                }.shareReplay(1)
            
            
            userNameValid
                .bindTo(passWordTF.rx.isEnabled)
                .disposed(by: disposeBag)
            
            userNameValid
                .bindTo(phoneNumberLabel.rx.isHidden)
                .disposed(by: disposeBag)
            
            passwordValid
                .bindTo(passWordLabel.rx.isHidden)
                .disposed(by: disposeBag)
            
            allValid
                .bindTo(loginBtn.rx.isEnabled)
                .disposed(by: disposeBag)
            
            loginBtn.rx.tap
                .subscribe(onNext:{ [weak self] in self?.showAlert() })
                .disposed(by: disposeBag)

        
        
        
        
    }
    
    
    func showAlert(){
        let alertView = UIAlertView(
        
            title:"恭喜你",
            message:"登录成功",
            delegate:nil,
            cancelButtonTitle:"OK"
        )
        
        alertView.show()
    }
    
    func isTelNumber(num:String)->Bool
    {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
            
        }  
    }
    
    func isTruePassWord(num:String) -> Bool {
        let passWord = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        let regextestpassWord = NSPredicate(format: "SELF MATCHES %@",passWord)
        if regextestpassWord.evaluate(with: num) == true {
            return true
        }else{
        
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTF.resignFirstResponder()
        passWordTF.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
