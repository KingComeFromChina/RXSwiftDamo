//
//  cycleView.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/7.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

let timeInterval = 0.35


class cycleView: UIView,UIScrollViewDelegate {

    var contentScrollView : UIScrollView!
    var currentImageView  : UIImageView!
    var lastImageView     : UIImageView!
    var nextImageView     : UIImageView!
    var pageIndicator     : UIPageControl!
    var timer             : Timer?
    var delegate          : CycleViewDelegate?
    
    var imageArray: [UIImage?]!{
        willSet(newValue){
        
            self.imageArray = newValue
        }
        
        didSet{
        
            contentScrollView.isScrollEnabled = !(imageArray.count == 1)
            self.pageIndicator.frame = CGRect.init(x: self.frame.size.width - 20 * CGFloat(imageArray.count), y: self.frame.size.height - 30, width: 20 * CGFloat(imageArray.count), height: 20)
            self.pageIndicator.numberOfPages = self.imageArray.count
            
            self.setScrollViewImage()
        }
    }
    
    var urlImageArray : [String]?{
       
        
        willSet(newValue){

            self.urlImageArray = newValue

}
        didSet{
        
            for urlStr:String in self.urlImageArray! {
                let urlImage = NSURL(string: urlStr)
                if urlImage == nil {
                    break
                }
                
                let dataImage =  NSData(contentsOf:urlImage as! URL)
                
                if dataImage == nil {
                    break
                }
                
                let  tempImage = UIImage (data: dataImage! as Data)
                if tempImage == nil {
                    break
                }
                imageArray.append(tempImage)
                
            }
        }
    }
    
    
    
    var indexOfCurrentImage: Int!{
    
        didSet{
        
            self.pageIndicator.currentPage = indexOfCurrentImage
        }
    }
    
  override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, imageArray: [UIImage?]?){
    
        self.init(frame: frame)
        self.imageArray = imageArray
        
        self.indexOfCurrentImage = 0
        self.creatCycleView()
    }
    
    private func creatCycleView(){
    
        self.contentScrollView = UIScrollView (frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        contentScrollView.contentSize = CGSize.init(width: self.frame.size.width * 3, height: 0)
        
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.backgroundColor = UIColor.white
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.isScrollEnabled = !(imageArray.count == 1)
        self.addSubview(contentScrollView)
        
        self.currentImageView = UIImageView()
        currentImageView.frame = CGRect.init(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: 200)
        currentImageView.isUserInteractionEnabled = true
        currentImageView.contentMode = UIViewContentMode.scaleAspectFill
        currentImageView.clipsToBounds = true
        contentScrollView.addSubview(currentImageView)
        
        let imageTap = UITapGestureRecognizer(target: self, action:#selector(cycleView.imageTapAction))
        currentImageView.addGestureRecognizer(imageTap)
        
        self.lastImageView = UIImageView()
        lastImageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 200)
        lastImageView.contentMode = UIViewContentMode.scaleAspectFill
        lastImageView.clipsToBounds = true
        contentScrollView.addSubview(lastImageView)
        
        self.nextImageView = UIImageView()
        nextImageView.frame = CGRect.init(x: self.frame.size.width * 2, y: 0, width: self.frame.size.width, height: 200)
        nextImageView.contentMode = UIViewContentMode.scaleAspectFill
        nextImageView.clipsToBounds = true
        contentScrollView.addSubview(nextImageView)
        
        self.setScrollViewImage()
        contentScrollView.setContentOffset(CGPoint.init(x: self.frame.size.width, y: 0), animated: false)
        
        self.pageIndicator = UIPageControl (frame: CGRect.init(x: self.frame.size.width - 20 * CGFloat(imageArray.count), y: self.frame.size.height - 30, width: 20 * CGFloat(imageArray.count), height: 20))
        pageIndicator.hidesForSinglePage = true
        pageIndicator.numberOfPages = imageArray.count
        pageIndicator.backgroundColor = UIColor.clear
        self.addSubview(pageIndicator)
        
        self.timer = Timer.init(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(cycleView.timerAction), userInfo: nil, repeats: true)
          self.timer?.fireDate = NSDate.distantFuture
    }
    
    private func setScrollViewImage(){
    
        self.currentImageView.image = self.imageArray[self.indexOfCurrentImage]
        self.nextImageView.image = self.imageArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.lastImageView.image = self.imageArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
    }
    
    private func getLastImageIndex(indexOfCurrentImage index: Int) -> Int{
    
        let tempIndex = index - 1
        if tempIndex == -1 {
            return self.imageArray.count - 1
        }else{
        
            return tempIndex
        }
        
    }
    
    private func getNextImageIndex(indexOfCurrentImage index: Int)-> Int{
    
        let tempIndex = index + 1
        return tempIndex < self.imageArray.count ? tempIndex : 0
        
    }
    
    func timerAction(){
    
        contentScrollView.setContentOffset(CGPoint.init(x: self.frame.size.width * 2, y: 0), animated: true)
    }
    
    func  imageTapAction(tap: UITapGestureRecognizer){
        self.delegate?.clickCurrentImage!(currentIndex: indexOfCurrentImage)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let  offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrentImage = self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }else if offset == self.frame.size.width * 2 {
        
            self.indexOfCurrentImage = self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }
        
        self.setScrollViewImage()
        
        scrollView.setContentOffset(CGPoint.init(x: self.frame.size.width, y: 0), animated: false)
        
        if timer == nil {
            self.timer = Timer.init(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(cycleView.timerAction), userInfo: nil, repeats: true)
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(contentScrollView)
    }
    
    
}

@objc protocol CycleViewDelegate :NSObjectProtocol{
    
    @objc optional func clickCurrentImage(currentIndex: Int)
}

