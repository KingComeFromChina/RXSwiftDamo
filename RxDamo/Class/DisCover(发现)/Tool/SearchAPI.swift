//
//  SearchAPI.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

func apiError(_ error: String) -> NSError {
    return NSError(domain: "SearchAPI", code : -1, userInfo: [NSLocalizedDescriptionKey: error])
}

public let SearchParseError = apiError("接口请求错误")

protocol SearchAPI {
    func getSearchResults(_ query: String) ->  Observable<[SearchResult]>
    func articleContent(_ searchResult: SearchResult) -> Observable<SearchPage>
}

class DefaultSearchAPI: SearchAPI {
   
    static let sharedAPI = DefaultSearchAPI()
    let $: Dependencies = Dependencies.sharedDependencies
    let loadingSearchData = ActivityIndicator()
    
    private init() {}
    
    private func JSON(_ url: URL) -> Observable<Any>{
    
        return $.URLSession
            .rx.json(url: url)
            .trackActivity(loadingSearchData)
    }
    
    func getSearchResults(_ query: String) -> Observable<[SearchResult]> {
        
        let escapedQuery = query.URLEscaped
        let urlContent = "http://en.wikipedia.org/w/api.php?action=opensearch&search=\(escapedQuery)"
        let url = URL(string: urlContent)
        
        return JSON(url!)
            .observeOn($.backgroundWorkScheduler)
            .map{
        
            json in
            guard let json = json as? [AnyObject] else{
            
                throw DamoError("请求失败")
            }
            return try SearchResult.parseJSON(json)
        }
        
        .observeOn($.mainScheduler)
    }
    
    func articleContent(_ searchResult: SearchResult) -> Observable<SearchPage> {
        
        let escapedPage = searchResult.title.URLEscaped
        
        guard let url = URL(string: "http://en.wikipedia.org/w/api.php?action=parse&page=\(escapedPage)&format=json") else {
            return Observable.error(apiError("网址拼写错误"))
        }
        return JSON(url)
            .map{jsonResult in
            guard let json = jsonResult as? NSDictionary else{
                throw DamoError("请求失败")
            }
            return try SearchPage.parseJSON(json)
        }
        .observeOn($.mainScheduler)
    }
    
 
}


