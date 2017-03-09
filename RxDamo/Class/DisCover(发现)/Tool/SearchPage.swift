//
//  SearchPage.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import class Foundation.NSDictionary
import RxSwift
import RxCocoa


struct SearchPage {
   
    let title : String
    let text  : String
    
    static func parseJSON(_ json: NSDictionary) throws -> SearchPage {
        guard
            let parse = json.value(forKey: "parse"),
            let title = (parse as AnyObject).value(forKey: "title") as? String,
            let t = (parse as AnyObject).value(forKey: "text"),
            let text = (t as AnyObject).value(forKey: "*") as? String else{
        
                throw apiError("网络请求失败")
        }
        
        return SearchPage(title : title, text: text)
        
        
    }
}
