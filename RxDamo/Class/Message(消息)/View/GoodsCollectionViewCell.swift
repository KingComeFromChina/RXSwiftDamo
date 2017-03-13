//
//  GoodsCollectionViewCell.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/7.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import SnapKit

class GoodsCollectionViewCell: UICollectionViewCell {
    
    typealias GoodsAddBlock = (_ imageView : UIImageView) -> Void
   public var goodsAddBlock : GoodsAddBlock?
    var goodsImageView      : UIImageView!
    var goodsNameLabel      : UILabel!
    var goodsPriceLabel     : UILabel!
    var addCartButton       : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initGoodsUI()
    }
    
    
    func initGoodsUI(){
    
        self.backgroundColor = UIColor.white
        
        self.goodsImageView = UIImageView()
//        self.goodsImageView.sd_setImage(with: NSURL.init(string: "") as URL!)
        self.goodsImageView.sd_setImage(with: NSURL.init(string: "") as URL!, placeholderImage: UIImage.init(named: "nange.jpg"))
        self.contentView.addSubview(self.goodsImageView)
        self.goodsImageView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(self.frame.size.width - 10)
        }
        
        self.goodsNameLabel = UILabel()
        self.goodsNameLabel.numberOfLines = 2
        self.goodsNameLabel.font = UIFont.systemFont(ofSize: 13)
        self.goodsNameLabel.text = "我是一只小小鸟 我要飞的高"
        self.goodsNameLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.goodsNameLabel)
        self.goodsNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.goodsImageView.snp.bottom).offset(0)
            make.left.equalTo(3)
           make.right.equalTo(-3)
        }
        
        self.goodsPriceLabel = UILabel()
        self.goodsPriceLabel.textColor = UIColor.red
        self.goodsPriceLabel.font = UIFont.systemFont(ofSize: 17)
        self.goodsPriceLabel.text = "¥20"
        self.contentView.addSubview(self.goodsPriceLabel)
        self.goodsPriceLabel.adjustsFontSizeToFitWidth = true
        self.goodsPriceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-8)
            make.left.equalTo(2)
            make.width.equalTo(self.frame.size.width / 2 - 2)
        }
        
        self.addCartButton = UIButton()
        let image = UIImage (named: "plusbutton_icon")
        self.addCartButton.setImage(image?.reSizeImage(reSize: CGSize.init(width: 30, height: 30)), for: .normal)
        self.addCartButton.addTarget(self, action: #selector(GoodsCollectionViewCell.addCartBtnClick), for: .touchUpInside)
        self.contentView.addSubview(self.addCartButton)
        self.addCartButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-5)
            make.right.equalTo(-5)
        }
    }
    
    func addCartBtnClick(){
        print("点击了加号按钮")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public class func getGoodsCellheight() -> CGFloat{
    
        return (((WLWindowWidth - 15) / 2) + 35 + 30)
    }
    
}
