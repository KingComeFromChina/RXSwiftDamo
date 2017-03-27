
//
//  MessageViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import enum Result.NoError

class MessageViewController: UIViewController {
    
    var imageArray : [String]!
  
//    var dataArray : [Any]!
     var dataArray  =  [MessageModel]()
    var messageViewModel : MessageViewModel!
    var messageUIService : MessageUIService!
    var messageCollectionView : UICollectionView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startServices()
        self.initData()
        self.creatCollectionView()
        //self.messageCollectionView.reloadData()
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
//         messageViewModel.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "second.jpg"), UIImage(named: "third.jpg")]
        self.imageArray   = ["http://img2.imgtn.bdimg.com/it/u=3141606660,3806191452&fm=23&gp=0.jpg","http://pic26.nipic.com/20130125/4274014_161451663147_2.jpg","http://img5.imgtn.bdimg.com/it/u=241641303,3634637900&fm=23&gp=0.jpg"]
        self.creatSignal()
                     
    }
    
    func creatSignal(){
        
//        let (cycleSignal1,cycleObserver) = Signal<Array<Any>,NoError>.pipe()
//        
//        // self.cycleSignal = cycleSinal1
//        let (goodsSignal1,goodsObserver) = Signal<Array<Any>,NoError>.pipe()
        // self.goodsSignal = goodsSignal1
        
        
        
        WLNetWorkTool.shareInstance.request(requestType: .Get, url: goodsUrl, parameters:["" : ""], succeed: {
            
            (response) in
            let dictArray = response ?? [[String : Any]]()
            //print(dictArray)
            let a : NSInteger = dictArray.count
            
            for i in 0..<a{
                let model = MessageModel()

                let  resultDict = dictArray[i]
                let  goodsName : String = resultDict["title"] as! String
                let  goodsPrice :String = "\(resultDict["price"]!)"
                let  goodsImageStr :String  = resultDict["avatar_url"] as! String
                model.goodsPrice = goodsPrice
                model.goodsName = goodsName
                model.goodsImageStr = goodsImageStr
                self.dataArray.append(model)
                //if model.goodsPrice == nil{
//                if case goodsPrice.isEmpty = false {
//                
//                    model.goodsPrice = goodsPrice
//                }
//                self.dataArray.insert(model, at: a-1)
                //}
            }
            if self.dataArray.count > 0{
            
                self.messageCollectionView.reloadData()
            }
            
            
            
        })  {
            
            (error) in
            guard let error = error  else{
                
                return
            }
            print(error)
        }
//        
//        cycleObserver.send(value: imageArray)
//        goodsObserver.send(value: self.dataArray)
//        
//        
//        Signal.combineLatest(cycleSignal1, goodsSignal1).observeValues({
//            
//            (value) in
//            print("收到的值\(value.0) + \(value.1)")
//        })
    }

    func creatCollectionView(){
    
        let layout = UICollectionViewFlowLayout()
        self.messageCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: -10, width: WLWindowWidth, height: WLWindowHeight  - 39), collectionViewLayout: layout)
       
        self.messageCollectionView.dataSource = self.messageUIService
        self.messageCollectionView.delegate = self.messageUIService
       
        self.messageCollectionView.showsVerticalScrollIndicator = false
        self.messageCollectionView.isPagingEnabled = false
        self.messageCollectionView.backgroundColor = RGB(r: 241, 241, 241)
        self.messageCollectionView.register(CycleCollectionViewCell.self, forCellWithReuseIdentifier: "CycleCollectionViewCell")
        
        self.messageCollectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: "GoodsCollectionViewCell")
        self.messageCollectionView.register(MessageCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MessageCollectionReusableView")
        self.view.addSubview(self.messageCollectionView)
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
