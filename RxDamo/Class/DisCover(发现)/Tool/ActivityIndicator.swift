//
//  ActivityIndicator.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

private struct ActivityToken<E> : ObservableConvertibleType,Disposable{

    private let _source: Observable<E>
    private let _dispose: Cancelable
    
    init(source: Observable<E>, disposeAction: @escaping() -> ()) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }
    
     func dispose() {
        _dispose.dispose()
    }
    
     func asObservable() -> Observable<E> {
    
        return _source
    }
}

public class ActivityIndicator : SharedSequenceConvertibleType{

    public typealias E = Bool
    public typealias SharingStrategy = DriverSharingStrategy
    
    private let _lock = NSRecursiveLock()
    private let _variable = Variable(0)
    private let _loading : SharedSequence<SharingStrategy, Bool>
    
    public init(){
    
        _loading = _variable.asDriver()
            .map{ $0 > 0}
            .distinctUntilChanged()
    }
    
    private func increment(){
    
        _lock.lock()
        _variable.value = _variable.value + 1
        _lock.unlock()
    }
    
    private func decrement(){
    
        _lock.lock()
        _variable.value = _variable.value - 1
        _lock.unlock()
    }
    
    public func asSharedSequence() -> SharedSequence<SharingStrategy, E> {
        
        return _loading
    }
    
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O)-> Observable<O.E>{
    
        return Observable.using({() -> ActivityToken<O.E>in
        
            self.increment()
            return ActivityToken(source: source.asObservable(),disposeAction: self.decrement)
        }){
        
            t in
            return t.asObservable()
        }
    }
    
}

extension ObservableConvertibleType{

    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E>{
    
        return activityIndicator.trackActivityOfObservable(self)
    }
}
