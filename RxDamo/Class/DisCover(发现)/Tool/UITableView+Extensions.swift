//
//  UITableView+Extensions.swift
//  RxDamo
//
//  Created by 王垒 on 2017/3/6.
//  Copyright © 2017年 王垒. All rights reserved.
//

import UIKit

extension UITableView{

    func hideEmptyCells(){
        self.tableFooterView = UIView(frame: .zero)
    }
}
