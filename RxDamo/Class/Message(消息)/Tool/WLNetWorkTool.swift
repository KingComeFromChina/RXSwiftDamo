//
//  WLNetWorkTool.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/13.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

import AFNetworking

enum WLRequestType {
    case Get
    case Post
}

class WLNetWorkTool: AFHTTPSessionManager {
    
    static let shareInstance : WLNetWorkTool = {
    
       let toolInstance = WLNetWorkTool()
        toolInstance.responseSerializer.acceptableContentTypes?.insert("text/html")
        return toolInstance
    }()
    
    //将成功和失败的回调写在一个逃逸闭包中
    func request(requestType : WLRequestType, url : String, parameters : [String:Any],resultBlock : @escaping ([[String : Any]]?, Error?) -> ()) {
        
        // 成功闭包
        let successBlock = {
        
            (task: URLSessionDataTask, responseObject: Any?) in
            resultBlock(responseObject as? [[String : Any]],nil)
        }
        
        // 失败闭包
        let failureBlock = {
        
            (task: URLSessionDataTask?,error: Error)in
            resultBlock(nil,error)
        }
        
        // Get 请求
        if requestType == .Get {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post 请求
        if requestType == .Post {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        
    }
    
    // 将成功和失败的回调分别写在两个逃逸的闭包中
    func request(requestType : WLRequestType, url : String,parameters : [String : Any],succeed : @escaping ([[String : Any]]?) -> (),failure : @escaping(Error?) -> ()) {
        
        // 成功的闭包
        
        let successBlock = {
            (task: URLSessionDataTask, responseObj: Any?) in
            succeed(responseObj as? [[String : Any]])
        }

        
        
        // 失败的闭包
        let failureBlock = {
            (task: URLSessionDataTask?,error: Error) in
            failure(error)
        }
        
        // Get请求
        if requestType == .Get {
            get(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
        // Post请求
        if requestType == .Post {
            post(url, parameters: parameters, progress: nil, success: successBlock, failure: failureBlock)
        }
        
    }

}
