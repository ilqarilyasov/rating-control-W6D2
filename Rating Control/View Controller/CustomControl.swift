//
//  CustomControl.swift
//  Rating Control
//
//  Created by Ilgar Ilyasov on 10/2/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    // MARK: - Properties

    var value: Int = 1 // For ratings
    private let componentDimension: CGFloat = 40.0
    private let componentCount: Int = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .gray
    private var stars = [UILabel]() // Local UILabel array
    
    // MARK: Initializer
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }
    
    func setup() {
        for i in 1...5 {
            let aFrame = CGRect(x: 0, y: 0, width: componentDimension, height: componentDimension)
            let star = UILabel(frame: aFrame)
            star.tag = i
            self.addSubview(star)
            stars.append(star)
        }
        // TODO: - Make them layout in a row
        for star in stars {
            star.layoutMargins = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: (componentDimension + 16.0))
            star.font = UIFont.boldSystemFont(ofSize: 32.0)
            star.text = "✩"
            star.textAlignment = .center
            star.textColor = componentActiveColor
        }
    }
    
    // MARK: Setting CustomControl's size
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    // MARK: - Add touch handler
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        sendActions(for: .touchDown)
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: .touchDragInside)
            updateValue(at: touch)
        } else {
            sendActions(for: .touchDragOutside)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: .touchDragInside)
        } else {
            sendActions(for: .touchDragOutside)
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    // MARK: - Update value
    
    func updateValue(at touch: UITouch) {
        
    }
}
