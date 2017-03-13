//
//  AddViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.creatSignalMethods()
        self.creatHotSignalMethods()
    }

    func creatSignalMethods() {
        
        // creat coldSignal by SignalProducer
        // 通过信号发生器创建冷信号
        
        let producer = SignalProducer<String,NoError>.init{
            
            (observer, _) in
            print("新的订阅，启动操作")
            observer.send(value: "I")
            observer.send(value: "Love")
            observer.send(value: "iOS")
        }
        
        let subscribre1 = Observer<String, NoError>(value:{
            
            print("观察者1接收到值 \($0)")
        })
        
        let subscribre2 = Observer<String, NoError>(value:{
            
            print("观察者2接收到值 \($0)")
        })
        
        let subscribre3 = Observer<String, NoError>(value:{
            
            print("观察者3接收到值 \($0)")
        })
        
        print("观察者1订阅信号发生器")
        producer.start(subscribre1)
        
        print("观察者2订阅信号发生器")
        producer.start(subscribre2)
        
        print("观察者3订阅信号发生器")
        producer.start(subscribre3)
    }

    
    func creatHotSignalMethods(){
    
        // creat hotSignal by pipe
        // 通过管道创建热信号
        
        let (signalA, observerA) = Signal<String,NoError>.pipe()
        let (signalB, observerB) = Signal<String,NoError>.pipe()
        
        Signal.combineLatest(signalA, signalB).observeValues{
        
            (value) in
            print("收到的值\(value.0) + \(value.1)")
        }
        
        observerA.send(value: "1")
        observerA.sendCompleted()
        
        observerB.send(value: "2")
        observerB.sendCompleted()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
