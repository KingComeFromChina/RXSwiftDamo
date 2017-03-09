//
//  SearchResult.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import RxSwift
import RxCocoa
import struct Foundation.URL

struct SearchResult: CustomDebugStringConvertible{
    let title : String
    let description: String
    let URL : Foundation.URL

    static func parseJSON(_ json: [AnyObject]) throws -> [SearchResult] {
        let rootArrayTyped: [[AnyObject]] = json.flatMap { $0 as? [AnyObject]}
        
        guard rootArrayTyped.count == 3 else {
            throw SearchParseError
        }
        
        let (titles, descriptions, urls) = (rootArrayTyped[0], rootArrayTyped[1], rootArrayTyped[2])
        let titleDescriptionAndUrl: [((AnyObject,AnyObject), AnyObject)] = Array (zip(zip(titles, descriptions), urls))
        
        return try titleDescriptionAndUrl.map{ result -> SearchResult in
        
            let ((title, description), url) = result
            
            guard let titleString = title as? String,
            let descriptionString = description as? String,
            let urlString = url as? String,
                let URL = Foundation.URL(string: urlString) else {
                    throw SearchParseError
            }
            
            return SearchResult(title: titleString, description: descriptionString, URL: URL)
        
        }
        
    }
}

extension SearchResult{

    var debugDescription: String{
    
        return "[\(title)](\(URL))"
    }
    
}
