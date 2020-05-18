//
//  UIStackView+Subviews.swift
//  GridView
//
//  Created by Konstantin Portnov on 18-05-20.
//  Copyright © 2020 Konstantin Portnov. All rights reserved.
//

import UIKit

extension UIStackView {

    func removeArrangedSubviews() {
        for v in arrangedSubviews {
            v.removeFromSuperview()
        }
    }

}
