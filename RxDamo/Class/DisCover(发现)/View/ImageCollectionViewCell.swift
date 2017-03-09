//
//  ImageCollectionViewCell.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

public class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    

    var disposeBag: DisposeBag?
    
    var downloadableImage: Observable<DownloadableImage>?{
    
        didSet{
        
            let disposeBag = DisposeBag()
            
            self.downloadableImage?
                .asDriver(onErrorJustReturn: DownloadableImage.offlinePlaceholder)
                .drive(imageView.rx.downloadableImageAnimated(kCATransitionFade))
                .disposed(by: disposeBag)
            
            self.disposeBag = disposeBag
            
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadableImage = nil
        disposeBag = nil
    }
    
    deinit {
        
    }
    
}
