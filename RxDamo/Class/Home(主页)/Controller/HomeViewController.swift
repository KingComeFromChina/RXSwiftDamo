//
//  HomeViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif
public let WLWindowWidth = UIScreen.main.bounds.size.width

public let WLWindowHeight = UIScreen.main.bounds.size.height

public func RGB(r:CGFloat,_ g:CGFloat,_ b: CGFloat) -> UIColor{
    
    return UIColor (red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}


 var disposeBag = DisposeBag()

class HomeViewController: UIViewController,UITextFieldDelegate {

     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        creatView()
    }

    func creatView(){
        
        let numTF1 = UITextField()
        numTF1.frame = CGRect (x: 50, y: 80, width: WLWindowWidth-100, height: 45)
        numTF1.borderStyle = .roundedRect
        numTF1.placeholder = "请输入数字"
        numTF1.adjustsFontSizeToFitWidth = true
        numTF1.minimumFontSize = 14
        numTF1.textAlignment = .center
        numTF1.keyboardType = .numberPad
        numTF1.returnKeyType = .done
        numTF1.delegate = self
        self.view.addSubview(numTF1)
        
        
        let numTF2 = UITextField()
        numTF2.frame = CGRect (x: 50, y: 90+45, width: WLWindowWidth-100, height: 45)
        numTF2.borderStyle = .roundedRect
        numTF2.placeholder = "请输入数字"
        numTF2.adjustsFontSizeToFitWidth = true
        numTF2.minimumFontSize = 14
        numTF2.textAlignment = .center
        numTF2.keyboardType = .numberPad
        numTF2.returnKeyType = .done
        numTF2.delegate = self
        self.view.addSubview(numTF2)
        
       
        
        let  addLabel = UILabel()
        addLabel.frame = CGRect (x: 50, y: 90+45+45+10, width: 20, height: 45)
        addLabel.text = "+"
        addLabel.textColor = UIColor.black
        addLabel.backgroundColor = UIColor.white
        addLabel.textAlignment = .center
        self.view.addSubview(addLabel)

        
        let numTF3 = UITextField()
        numTF3.frame = CGRect (x: 80, y: 90+45+45+10, width: WLWindowWidth - 130, height: 45)
        numTF3.borderStyle = .roundedRect
        numTF3.placeholder = "请输入数字"
        numTF3.adjustsFontSizeToFitWidth = true
        numTF3.minimumFontSize = 14
        numTF3.textAlignment = .center
        numTF3.keyboardType = .numberPad
        numTF3.returnKeyType = .done
        numTF3.delegate = self
        self.view.addSubview(numTF3)
        
        let lineView = UIView()
        lineView.frame = CGRect (x: 50, y: 90+45+45+10+45+10, width: WLWindowWidth-100, height: 1)
        lineView.backgroundColor = UIColor.black
        self.view.addSubview(lineView)
        
        let sumLabel = UILabel()
        sumLabel.frame = CGRect (x: 50, y: 245+10, width: WLWindowWidth - 100, height: 45)
        sumLabel.textColor = UIColor.black
        sumLabel.backgroundColor = UIColor.white
        sumLabel.textAlignment = .center
        self.view .addSubview(sumLabel)
        
        
//        Observable.combineLatest(numTF1.rx.text.orEmpty, numTF2.rx.text.orEmpty, numTF3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
//            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
//            }
//            .map { $0.description }
//            .bindTo(sumLabel.rx.text)
        
    
        Observable.combineLatest(numTF1.rx.text.orEmpty, numTF2.rx.text.orEmpty, numTF3.rx.text.orEmpty){
        
            textValue1,textValue2,textValue3 -> Int in
            return (Int (textValue1) ?? 0) + (Int (textValue2) ?? 0) + (Int (textValue3) ?? 0)
            }
            .map{ $0.description}
            .bindTo(sumLabel.rx.text)
            .disposed(by: disposeBag)
        
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
