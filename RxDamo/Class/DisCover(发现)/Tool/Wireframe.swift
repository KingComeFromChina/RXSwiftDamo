//
//  Wireframe.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import RxSwift
import UIKit

enum RetryResult {
    case retry
    case cancel
}

protocol Wireframe {
    
    func open(url: URL)
    func promptFor<Action: CustomStringConvertible>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action>
}

class DefaultWireframe: Wireframe {
    
    static let sharedInstance = DefaultWireframe()
    
    func open(url: URL) {
        UIApplication.shared.canOpenURL(url)
    }
    
    private static func rootViewController() -> UIViewController{
    
        return UIApplication.shared.keyWindow!.rootViewController!
    }
    
    static func presentAlert(_ message: String){
    
        let alertView = UIAlertController(title: "RxDamo",message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK",style: .cancel){ _ in
        })
        
        rootViewController().present(alertView, animated: true, completion: nil)
        
    }
    
   func promptFor<Action : CustomStringConvertible>(_ message: String, cancelAction: Action, actions: [Action]) -> Observable<Action> {
    return Observable.create{
    
        observe in
        let alertView = UIAlertController(title: "RxDamo", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: cancelAction.description, style: .cancel){
        
            _ in
            observe.on(.next(cancelAction))
        })
    
    
    for action in actions {
        
        alertView.addAction(UIAlertAction(title: action.description, style: .default){
        _ in
          observe.on(.next(action))
        })
    }
    
    DefaultWireframe.rootViewController().present( alertView, animated: true, completion: nil)
    
    return Disposables.create {
        alertView.dismiss(animated: false, completion: nil)
    }
    }
    }
}

extension RetryResult : CustomStringConvertible{

    var description: String{
    
        switch self {
        case .retry:
            return "重试"
            
        case .cancel:
            return "取消"
        
        }
    }
    
}
