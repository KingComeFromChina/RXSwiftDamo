//
//  CycleCollectionViewCell.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/8.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SDWebImage

class CycleCollectionViewCell: UICollectionViewCell {
    
    
    var headCycleView    : SDCycleScrollView!
    var imageArray       : [String?]!
   // var messageViewModel : MessageViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatData()
        self.initUI()
    }
    
    func creatData(){
        
//        self.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]
        self.imageArray = ["http://img2.imgtn.bdimg.com/it/u=3141606660,3806191452&fm=23&gp=0.jpg","http://pic26.nipic.com/20130125/4274014_161451663147_2.jpg","http://img5.imgtn.bdimg.com/it/u=241641303,3634637900&fm=23&gp=0.jpg"]
    }
    
    func initUI(){
    
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: WLWindowWidth, height: self.frame.size.height))
        
        self.headCycleView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: WLWindowWidth, height: self.frame.size.height), imageURLStringsGroup:
           self.imageArray)
        
        bgView.addSubview(self.headCycleView)
        self.contentView.addSubview(bgView)
        
        
    }
    
    public class func getCycleViewHeight() -> CGFloat{
    
        let height = CGFloat(315 / 640 * WLWindowWidth)
        return height
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
