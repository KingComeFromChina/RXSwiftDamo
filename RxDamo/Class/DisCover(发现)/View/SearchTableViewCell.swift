//
//  SearchTableViewCell.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

public class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var imagesCollectionView: UICollectionView!

    @IBOutlet weak var URLLabel: UILabel!
    
    var disposeBag: DisposeBag?
    
    let imageService = DefaultImageService.sharedImageService
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imagesCollectionView.register(UINib(nibName:"ImageCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }
    
    var viewModel: SearchResultViewModel?{
    
        didSet{
        
            let disposeBag = DisposeBag()
            
            guard let viewModel = viewModel else {
                return
            }
            
            viewModel.title.map(Optional.init)
            .drive(self.titleLabel.rx.text)
            .disposed(by: disposeBag)
            
            self.URLLabel.text = viewModel.searchResult.URL.absoluteString
            
            let reachabilityService = Dependencies.sharedDependencies.reachabilityService
            
            viewModel.imageURLs
                .drive(self.imagesCollectionView.rx.items(cellIdentifier: "ImageCollectionViewCell", cellType: ImageCollectionViewCell.self)){
            
                    [weak self] (_, url,cell) in
                    cell.downloadableImage = self?.imageService.imageFromURL(url, reachabilityService: reachabilityService) ?? Observable.empty()
                    
                    #if DEBUG
                        
                   cell.installHackBecauseOfAutomationLeakOnIOS10(firstViewThatDoesntLeak: self!.superview!.superview!)
                        
                    #endif
            }
            .disposed(by: disposeBag)
            
            self.disposeBag = disposeBag
            
            #if DEBUG
               
                self.installHackBecauseOfAutomationLeakOnIOS10(firstViewThatDoesntLeak: self.superview!.superview!)
                
            #endif
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel = nil
        self.disposeBag = nil
        
    }
    
    deinit {
        
    }
    
    
}

fileprivate protocol ReusableView: class{

    var disposeBag: DisposeBag? {get}
    func prepareForReuse()
    
}

extension SearchTableViewCell: ReusableView{

}

extension ImageCollectionViewCell : ReusableView{

}

fileprivate extension ReusableView{

    func installHackBecauseOfAutomationLeakOnIOS10(firstViewThatDoesntLeak: UIView){
    
        if #available(iOS 10.0, *) {
            firstViewThatDoesntLeak.rx.deallocated.subscribe(onNext: {[weak self] _ in
            
                self?.prepareForReuse()
            })
            .disposed(by: self.disposeBag!)
        }
    }
}
