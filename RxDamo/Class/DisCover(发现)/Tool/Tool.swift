//
//  Tool.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit
typealias Image = UIImage

let MB = 1024 * 1024

func DamoError(_ error: String, location: String = "\(#file):\(#line)") -> NSError{

    return NSError(domain: "DamoError", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(location):\(error)"])
}

extension String{

    func toFloat() -> Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.floatValue
    }
    
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.doubleValue
    }
}

func showAlert(_ message: String){

    UIAlertView(title: "RxDamo", message: message, delegate: nil, cancelButtonTitle: "OK").show()
}
