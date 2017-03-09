
//
//  MessageViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit


class MessageViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {

    
    var messageViewModel : MessageViewModel!
    var messageUIService : MessageUIService!
    var messageCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.startServices()
//        self.initData()
        self.creatCollectionView()
        self.messageCollectionView.reloadData()
        // Do any additional setup after loading the view.
        
    }

  
    
    
    func startServices(){
    
        self.messageViewModel = MessageViewModel()
        self.messageUIService = MessageUIService()
        self.messageUIService.messageUIViewModel = self.messageViewModel
        self.messageUIService.messageViewController = self
        
    }
    
    func initData(){
    
//        self.messageUIService.dataArray :NSMutableArray = []
//        self.messageUIService.dataArray.removeAllObjects()
        //self.messageCollectionView .reloadData()
        
    }
    
    func creatCollectionView(){
    
        let layout = UICollectionViewFlowLayout()
        self.messageCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 64, width: WLWindowWidth, height: WLWindowHeight - 64 - 49), collectionViewLayout: layout)
        self.messageCollectionView.backgroundColor = UIColor.red
//        self.messageCollectionView.dataSource = self.messageUIService
//        self.messageCollectionView.delegate = self.messageUIService
        self.messageCollectionView.dataSource = self
        self.messageCollectionView.delegate = self
        self.messageCollectionView.showsVerticalScrollIndicator = false
        self.messageCollectionView.isPagingEnabled = false
        //self.messageCollectionView.backgroundColor = RGB(r: 241, 241, 241)
        self.messageCollectionView.register(NSClassFromString("CycleCollectionViewCell"), forCellWithReuseIdentifier: "CycleCollectionViewCell")
        
//        self.messageCollectionView.register(NSClassFromString("GoodsCollectionViewCell"), forCellWithReuseIdentifier: "GoodsCollectionViewCell")
//        self.messageCollectionView.register(NSClassFromString("MessageCollectionReusableView"), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MessageCollectionReusableView")
        self.view.addSubview(self.messageCollectionView)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 1 {
//            // return (self.dataArray?.count)!
//            return 10
//        }
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // var newCell : UICollectionViewCell? = nil
        
         let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CycleCollectionViewCell", for: indexPath)
       
        
        return cell
//        if indexPath.section == 0 {
//            let cell :CycleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CycleCollectionViewCell", for: indexPath) as! CycleCollectionViewCell
//            if cell == nil {
//                cell = CycleCollectionViewCell()
//            }
//            newCell = cell
//        }else if indexPath.section == 1{
//            
//            let cell : GoodsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsCollectionViewCell", for: indexPath) as! GoodsCollectionViewCell
//            newCell = cell
//            
//        }
//        return newCell!
        
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
