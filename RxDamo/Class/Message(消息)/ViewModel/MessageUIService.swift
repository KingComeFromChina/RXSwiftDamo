//
//  MessageUIService.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/7.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit


class MessageUIService : NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
//
   public var messageViewController  : MessageViewController!
   public var messageUIViewModel     : MessageViewModel!
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
           // return (self.dataArray?.count)!
            //return messageViewController.dataArray.count
            if messageViewController.dataArray.count > 0 {
               return messageViewController.dataArray.count
            }

        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var newCell : UICollectionViewCell? = nil
        
        if indexPath.section == 0 {
            let cell :CycleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CycleCollectionViewCell", for: indexPath) as! CycleCollectionViewCell
            
           newCell = cell
        }else if indexPath.section == 1{
        
            let cell : GoodsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsCollectionViewCell", for: indexPath) as! GoodsCollectionViewCell
            var model = MessageModel()
            print("看看数组",messageViewController.dataArray)
            if messageViewController.dataArray.count > 0 {
                 model = messageViewController.dataArray[indexPath.row]
            }
           
            cell.goodsNameLabel.text = model.goodsName
            cell.goodsPriceLabel.text = "¥" + model.goodsPrice
            let url = URL.init(string: model.goodsImageStr)
            
            cell.goodsImageView.sd_setImage(with: url)
            newCell = cell
            
        }
        return newCell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize.init(width: WLWindowWidth, height: CycleCollectionViewCell.getCycleViewHeight())
        }else if indexPath.section == 1 {
        
            return CGSize.init(width: (WLWindowWidth - 15) / 2, height: GoodsCollectionViewCell.getGoodsCellheight())
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var view : UICollectionReusableView? = nil
        if kind == UICollectionElementKindSectionHeader{
            
            if indexPath.section == 1 {
                let headView :MessageCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MessageCollectionReusableView", for: indexPath) as! MessageCollectionReusableView
                view = headView
                
            }
            
        }
        return view!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize.init(width: WLWindowWidth, height: MessageCollectionReusableView.getActHeaderHeight())
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    
}
