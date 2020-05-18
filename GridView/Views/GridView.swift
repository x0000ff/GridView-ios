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
    
    var resources: [Resource]? {
        didSet {
            refreshUI()
        }
    }
    
    var horizontalMargin: Int = 0 {
        didSet {
            refreshUI()
        }
    }
     
     var verticalMargin: Int = 0 {
        didSet {
            stackView.spacing = CGFloat(verticalMargin)
        }
    }
    
    var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }

    func initialSetup() {
        setupUI()
        configureStackView()
    }

    func setupUI() {
        colorizeBorder(withColor: UIColor.magenta)
    }

    func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = CGFloat(verticalMargin)
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        delegate?.didLayoutSubviews(sender: self)
        refreshUI()
    }
    
    func refreshUI() {
        
        stackView.removeArrangedSubviews()
        
        guard let resources = resources else { return }
        
        let margin = horizontalMargin
        let maxWidth = bounds.width
        var accumultedWidth = 0
        
        var currentRow = [Resource]()
        for r in resources {
            let nextWidth: Int = accumultedWidth + (currentRow.count > 0 ? margin : 0) + Int(r.size.width)
            if (nextWidth < Int(maxWidth)) {
                accumultedWidth = nextWidth
                currentRow.append(r)
                continue
            }
            
            let rowView = createRow(images: currentRow)
            stackView.addArrangedSubview(rowView)

            currentRow.removeAll()
            currentRow.append(r)
            accumultedWidth = Int(r.size.width)
        }
        
        if currentRow.count > 0 {
            let rowView = createRow(images: currentRow)
            stackView.addArrangedSubview(rowView)
        }

    }
    
    func createRow(images: [Resource]) -> UIStackView {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = CGFloat(horizontalMargin)
        
        for i in images {
            stack.addArrangedSubview(createImageView(resource: i))
        }
        
        return stack
    }
    
    func createImageView(resource: Resource) -> UIImageView {
        
        let imageView = UIImageView(image: resource.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: resource.size.width)
        widthConstraint.priority = UILayoutPriority(rawValue: 750)
        widthConstraint.isActive = true
        
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: resource.size.height)
        heightConstraint.priority = UILayoutPriority(rawValue: 750)
        heightConstraint.isActive = true
        
        imageView.contentMode = .scaleToFill
        imageView.image = resource.image
      
        imageView.colorizeBorder(withColor: UIColor.blue)

        return imageView
    }
}
