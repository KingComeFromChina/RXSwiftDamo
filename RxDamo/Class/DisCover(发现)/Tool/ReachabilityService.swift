//
//  ReachabilityService.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

import class Dispatch.queue.DispatchQueue

public enum  ReachabilityStatus{

    case reachable(viaWiFi: Bool)
    case unreachable
}

extension ReachabilityStatus{

    var reachable: Bool{
    
        switch self{
        case .reachable:
            return true
            
        case .unreachable:
            return false
        
        }
    }
}

protocol ReachabilityService {
    var reachability: Observable<ReachabilityStatus>{ get }
}

enum ReachabilityServiceError: Error {
    case failedToCreate
}

class DefaultReachabilityService: ReachabilityService {
    private let _reachabilitySubjct : BehaviorSubject<ReachabilityStatus>
    
    var reachability: Observable<ReachabilityStatus>{
    
        return _reachabilitySubjct.asObservable()
    }
    
    let _reachability: Reachability
    
    init() throws {
        guard let reachabilityRef = Reachability() else {
            throw ReachabilityServiceError.failedToCreate
        }
        
        let reachabilitySubject = BehaviorSubject<ReachabilityStatus>(value: .unreachable)
        
        let backgroundQueue = DispatchQueue(label: "检查是否Wi-Fi在线")
        
        reachabilityRef.whenReachable = {
        
            reachbility in
            
            backgroundQueue.async {
                reachabilitySubject.on(.next(.reachable(viaWiFi: reachabilityRef.isReachableViaWiFi)))
            }
        }
        
        reachabilityRef.whenUnreachable = {
        
            reachability in
            backgroundQueue.async {
                reachabilitySubject.on(.next(.unreachable))
            }
        }
        
        try reachabilityRef.startNotifier()
        _reachability = reachabilityRef
        _reachabilitySubjct = reachabilitySubject
    }
    
    deinit {
        _reachability.stopNotifier()
    }
    
    
}

extension ObservableConvertibleType{

    func retryOnBecomesReachable(_ valueOnFailure: E, reachabilityService: ReachabilityService) -> Observable<E> {
        return self.asObservable()
            .catchError{
        
                (e) -> Observable<E> in
                reachabilityService.reachability
                .skip(1)
                .filter{ $0.reachable}
                .flatMap{ _ in
                
                    Observable.error(e)
                }
                .startWith(valueOnFailure)
        }
        .retry()
        
    }
}
