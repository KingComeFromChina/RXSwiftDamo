//
//  MessageCollectionReusableView.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/8.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

class MessageCollectionReusableView: UICollectionReusableView {
    
    var categoryNameLabel  : UILabel!
    var categoryImageView  : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatUI()
    }
    
    func creatUI(){
    
        let bgView = UIImageView.init(image: UIImage (named: "goodsbg"))
        bgView.frame = self.bounds
        bgView.isUserInteractionEnabled = true
        self.addSubview(bgView)
        
        let WW = CGFloat(self.frame.size.height - 10)
        
        self.categoryNameLabel = UILabel.init(frame: CGRect.init(x: WLWindowWidth / 2 - 30 + WW / 2, y: 0, width: 100, height: self.frame.size.height))
        self.categoryNameLabel.textColor = UIColor.red
        self.categoryNameLabel.text = "热卖单品"
        self.categoryNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.categoryNameLabel.textAlignment = NSTextAlignment.left
        bgView.addSubview(self.categoryNameLabel)
        
        self.categoryImageView = UIImageView.init(frame: CGRect.init(x: self.categoryNameLabel.frame.origin.x - (WW + 2), y: 5, width: WW, height: WW))
                self.categoryImageView.image = UIImage (named: "hot")
        bgView.addSubview(self.categoryImageView)

    }
    
    public class func getActHeaderHeight() -> CGFloat{
    
        let height = (CGFloat)(50 / 640 * WLWindowWidth)
        
        return height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
