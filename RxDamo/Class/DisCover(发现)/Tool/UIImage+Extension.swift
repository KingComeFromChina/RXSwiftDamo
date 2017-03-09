//
//  UIImage+Extension.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit


extension Image {
    func forceLazyImageDecompression() -> Image {
        #if os(iOS)
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            self.draw(at: CGPoint.zero)
            UIGraphicsEndImageContext()
        #endif
        return self
    }
}
