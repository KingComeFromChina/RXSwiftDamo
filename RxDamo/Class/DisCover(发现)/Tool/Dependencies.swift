//
//  Dependencies.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import RxSwift
import RxCocoa
import class Foundation.URLSession
import class Foundation.OperationQueue
import enum Foundation.QualityOfService

class Dependencies {
    
    static let sharedDependencies = Dependencies()

    let URLSession = Foundation.URLSession.shared
    let backgroundWorkScheduler: ImmediateSchedulerType
    let mainScheduler: SerialDispatchQueueScheduler
    let wireframe: Wireframe
    let reachabilityService : ReachabilityService
    
    private init(){
    
        wireframe = DefaultWireframe()
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        
        operationQueue.qualityOfService = QualityOfService.userInitiated
        
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        mainScheduler = MainScheduler.instance
        reachabilityService = try! DefaultReachabilityService()
        
    }
    
    
}
