//
//  UIView+Debug.swift
//  GridView
//
//  Created by Konstantin Portnov on 18-05-20.
//  Copyright © 2020 Konstantin Portnov. All rights reserved.
//

import UIKit

extension UIView {
    func colorizeBorder(withColor color: UIColor) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
