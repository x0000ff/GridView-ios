//
//  ViewController.swift
//  GridView
//
//  Created by Konstantin Portnov on 15-05-20.
//  Copyright © 2020 Konstantin Portnov. All rights reserved.
//

import UIKit

struct Resource {
    let name: String
    let image: UIImage
    let size: CGSize
}

extension Resource: CustomDebugStringConvertible {
    var debugDescription: String {
        return name
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var rightMarginSlider: UISlider!

    @IBOutlet weak var rightMarginLabel: UILabel!
    @IBOutlet weak var frameLabel: UILabel!
    @IBOutlet weak var gridView: GridView!

    @IBOutlet weak var rightMarginContraint: NSLayoutConstraint!

    @IBOutlet weak var verticalMarginLabel: UILabel!
    @IBOutlet weak var verticalMarginStepper: UIStepper!

    @IBOutlet weak var horizontalMarginLabel: UILabel!
    @IBOutlet weak var horizontalMarginStepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gridView.delegate = self
        
        horizontalMarginStepper.value = 12
        changeHorizontalMargin()

        verticalMarginStepper.value = 16
        changeVerticalMargin()
        
        rightMarginSlider.minimumValue = 57
        rightMarginSlider.value = Float(rightMarginContraint.constant)

        changeRightMargin()
        
        gridView.resources = loadResources()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rightMarginSlider.maximumValue = Float(view.bounds.width)
    }
    
    @IBAction func changeRightMargin() {
        let normalized = round(rightMarginSlider.value)
        rightMarginSlider.value = normalized

        rightMarginLabel.text = "← " + String(Int(normalized)) + "px →"
        rightMarginContraint.constant = CGFloat(normalized)
    }

    @IBAction func changeVerticalMargin() {
        let normalized = round(verticalMarginStepper.value)
        verticalMarginStepper.value = normalized

        verticalMarginLabel.text = String(Int(normalized))
        gridView.verticalMargin = Int(normalized)
    }

    
    @IBAction func changeHorizontalMargin() {
        let normalized = round(horizontalMarginStepper.value)
        horizontalMarginStepper.value = normalized

        horizontalMarginLabel.text = String(Int(normalized))
        gridView.horizontalMargin = Int(normalized)
    }

    func loadResources() -> [Resource] {
        return [
            Resource(name: "Santander",
                     image: UIImage(named: "santander")!,
                     size: CGSize(width: 38, height: 35)),
            
            Resource(name: "Itau",
                     image: UIImage(named: "itau")!,
                     size: CGSize(width: 35, height: 35)),
            
            Resource(name: "BV",
                     image: UIImage(named: "bv")!,
                     size: CGSize(width: 49, height: 35)),
            
            Resource(name: "Pan",
                     image: UIImage(named: "pan")!,
                     size: CGSize(width: 45, height: 35)),
            
            Resource(name: "Bradesco",
                     image: UIImage(named: "bradesco")!,
                     size: CGSize(width: 43, height: 35)),
            
            Resource(name: "Banco do Brasil",
                     image: UIImage(named: "banco-do-brasil")!,
                     size: CGSize(width: 63, height: 35)),
        ]
    }

}

extension ViewController: GridViewDelegate {
    func didLayoutSubviews(sender: UIView) {
        frameLabel.text = "Frame: " + sender.frame.debugDescription
    }
}
