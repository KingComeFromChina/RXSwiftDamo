//
//  SearchResultViewModel.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchResultViewModel {
    
    let searchResult :SearchResult
    var title: Driver<String>
    var imageURLs: Driver<[URL]>
    
    let API = DefaultSearchAPI.sharedAPI
    let $: Dependencies = Dependencies.sharedDependencies
    
    init(searchResult: SearchResult) {
        
        self.searchResult = searchResult
        
        self.title = Driver.never()
        self.imageURLs = Driver.never()
        
        let URLs = configureImageURLs()
        
        self.imageURLs = URLs.asDriver(onErrorJustReturn: [])
        self.title = configureTitle(URLs).asDriver(onErrorJustReturn: "解析失败")
        
    }
    
    func configureTitle(_ imageURLs: Observable<[URL]>) -> Observable<String> {
        
        let searchResult = self.searchResult
        
        let loadingValue: [URL]? = nil
        
        return imageURLs
        .map(Optional.init)
        .startWith(loadingValue)
        .map{ URLs in
            if let URLs = URLs{
            
                return "\(searchResult.title)(\(URLs.count)图片)"
            }else{
            
                return "\(searchResult.title)(loading...)"
            }
        }
        .retryOnBecomesReachable("⚠️ 服务器繁忙 ⚠️", reachabilityService: $.reachabilityService)

   }
    
    func configureImageURLs() -> Observable<[URL]> {
        
        let searchResult = self.searchResult
        return API.articleContent(searchResult)
        .observeOn($.backgroundWorkScheduler)
            .map{page in
         
                do{
                
                    return try parseImageURLsfromHTMLSuitableForDisplay(page.text as NSString)
                } catch{
                
                    return []
                }
        }
        .shareReplayLatestWhileConnected()
    }
    
}
    
    

