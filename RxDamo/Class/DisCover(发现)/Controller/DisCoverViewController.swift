//
//  DisCoverViewController.swift
//  WeiBoSwiftDamo
//
//  Created by 王垒 on 2017/3/2.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

var tableView = UITableView()
let searchTF = UITextField()

class DisCoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatSearchView()
        self.creatTableView()
        self.edgesForExtendedLayout = .all
        self.configureTableDataSource()
        self.configureKeyboardDismissesOnScroll()
        self.configureNavigateOnRowClick()
        self.configureActivityIndicatorsShow()
    }

    func creatSearchView(){
        
        searchTF.frame = CGRect.init(x: 20, y: 84, width: WLWindowWidth-40, height: 45)
        searchTF.borderStyle = .roundedRect
        searchTF.adjustsFontSizeToFitWidth = true
        searchTF.minimumFontSize = 14
        searchTF.returnKeyType = .search
        searchTF.placeholder = "请输入你要查询的信息"
        self.view.addSubview(searchTF)
        
    }
    
    func creatTableView(){

        tableView = UITableView(frame:(CGRect.init(x: 0, y: 84+65, width: WLWindowWidth, height: WLWindowHeight-84-65-49)),style:UITableViewStyle.plain)
        tableView.rowHeight = 194
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName:"SearchTableViewCell",bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableView.hideEmptyCells()
        self.view.addSubview(tableView)
        
    }
    
    func configureTableDataSource(){
    
        let API = DefaultSearchAPI.sharedAPI
        
        let results = searchTF.rx.text.orEmpty
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .flatMapLatest{
        
                query in
                API.getSearchResults(query)
                    .retry(3)
                    .retryOnBecomesReachable([], reachabilityService: Dependencies.sharedDependencies.reachabilityService)
                .startWith([])
                .asDriver(onErrorJustReturn: [])
        }
            .map{ results in
        
                results.map(SearchResultViewModel.init)
        }
        

        results
            .drive(tableView.rx.items(cellIdentifier: "SearchTableViewCell", cellType: SearchTableViewCell.self)) { (_, viewModel, cell) in
                cell.viewModel = viewModel
            }
            .disposed(by: disposeBag)
        
       

    }
    
    func configureKeyboardDismissesOnScroll(){
    
        
        
        tableView.rx.contentOffset.asDriver().drive(onNext:{ _ in
            if searchTF.isFirstResponder {
            
                _ = searchTF.resignFirstResponder()
            }
        })
        .disposed(by: disposeBag)
        
    }
    
    
    func configureNavigateOnRowClick(){
        let wireframe = DefaultWireframe.sharedInstance
        
        tableView.rx.modelSelected(SearchResultViewModel.self)
            .asDriver()
            .drive(onNext:{ searchResult in
        
            wireframe.open(url: searchResult.searchResult.URL)
        })
        .disposed(by: disposeBag)
        
    }
    
    func configureActivityIndicatorsShow(){
    
        Driver.combineLatest(
        DefaultSearchAPI.sharedAPI.loadingSearchData, DefaultImageService.sharedImageService.loadingImage
        ){ $0 || $1 }
        .distinctUntilChanged()
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
