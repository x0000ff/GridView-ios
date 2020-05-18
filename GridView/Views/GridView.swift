//
//  GridView.swift
//  GridView
//
//  Created by Konstantin Portnov on 15-05-20.
//  Copyright © 2020 Konstantin Portnov. All rights reserved.
//

import UIKit

protocol GridViewDelegate: AnyObject {
    func didLayoutSubviews(sender: UIView)
}

class GridView: UIView {
    
    weak var delegate: GridViewDelegate?
    
    var resources: [Resource]?
    
    var horizontalMargin: Int = 0
    
    var verticalMargin: Int = 0
    
}
