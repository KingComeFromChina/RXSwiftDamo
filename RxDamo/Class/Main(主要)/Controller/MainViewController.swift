//
//  MainViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupAddBtn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildViewControllers()
    }

    
    
    private func addChildViewControllers(){
        
        let homeVC = HomeViewController()
        addOneChildVC(childVC: homeVC, title: "首页", imageName: "tabbar_home", selectImageName: "tabbar_home_highlighted")
        
        let messageVC = MessageViewController()
        addOneChildVC(childVC: messageVC, title: "消息", imageName: "tabbar_message_center", selectImageName: "tabbar_message_center")
        
        let addVC  = AddViewController()
        addOneChildVC(childVC: addVC, title: "", imageName: "", selectImageName: "")
        
        let discoverVC = DisCoverViewController()
        addOneChildVC(childVC: discoverVC, title: "广场", imageName: "tabbar_discover", selectImageName: "tabbar_discover")
        
        let meVC = MeViewController()
        addOneChildVC(childVC: meVC, title: "我", imageName: "tabbar_profile", selectImageName: "tabbar_profile")
        
        
        
        
    }
    
    private func addOneChildVC (childVC : UIViewController, title: String, imageName: String,selectImageName:String){
        
        childVC.title = title
        
        childVC.tabBarItem.image = UIImage (named: imageName)
        
        childVC.tabBarItem.selectedImage = UIImage (named: selectImageName)
        
        let shadow = NSShadow()
        
        shadow.shadowOffset = CGSize.zero
        
        let nav = UINavigationController()
        
        nav.addChildViewController(childVC)
        
        addChildViewController(nav)
    }

    private lazy var addBtn:UIButton = {
    
        let btn = UIButton()
        
        
        
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), for: .normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: .highlighted)
        
        btn.addTarget(self, action: #selector(MainViewController.addBtnClick), for: .touchUpInside)
        
        return btn
        
    }()
    
    func addBtnClick(){
        let addVC = AddViewController()
        let nav = UINavigationController(rootViewController: addVC)
        present(nav, animated: true, completion: nil)
        
    }
    
   
    private func setupAddBtn(){
    
        tabBar.addSubview(addBtn)
        
        let width = UIScreen.main.bounds.size.width / CGFloat((viewControllers?.count)!)
        let  rect = CGRect (x: 0, y: 0, width: width, height: 49)
        addBtn.frame = rect.offsetBy(dx: 2*width, dy: 0)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
