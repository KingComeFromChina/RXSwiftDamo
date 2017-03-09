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
    var imageArray       : [UIImage?]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatData()
        self.initUI()
    }
    
    func creatData(){
        
        self.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]
    }
    
    func initUI(){
    
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: WLWindowWidth, height: 200))
        
        self.headCycleView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: WLWindowWidth, height: 200), imageNamesGroup: self.imageArray)
        bgView.addSubview(self.headCycleView)
        
    }
    
    public class func getCycleViewHeight() -> CGFloat{
    
        let height = CGFloat(315 / 640 * WLWindowWidth)
        return height
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
