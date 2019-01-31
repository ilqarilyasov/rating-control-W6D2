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
    
    
    ///From instruction. Setting CustomControl's size
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    // MARK: Setup
    
    func setup() {
        backgroundColor = .clear
        frame = CGRect(origin: .zero, size: intrinsicContentSize)
        for index in 1...componentCount {
            let star = UILabel()
            self.addSubview(star)
            stars.append(star)
            
            let offset = (CGFloat(index-1)*componentDimension) + (CGFloat(index)*8.0)
            star.frame = CGRect(x: offset, y: 0, width: componentDimension, height: componentDimension)
            
            star.tag = index
            star.font = UIFont.boldSystemFont(ofSize: 32.0)
            star.text = "✩"
            star.textAlignment = .center
            star.textColor = star.tag == 1 ? componentActiveColor : componentInactiveColor
        }
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
        for star in stars {
            let oldValue = value
            
            let touchPoint = touch.location(in: self)
            if star.frame.contains(touchPoint) {
                value = star.tag
                
                if value != oldValue {
                    updateLabelColor()
                    star.performFlare()
                    sendActions(for: .valueChanged)
                } else {
                    star.performFlare()
                }
            }
        }
    }
    
    func updateLabelColor() {
        for star in stars {
            if star.tag <= value {
                star.textColor = componentActiveColor
            } else {
                star.textColor = componentInactiveColor
            }
        }
    }
}

/// From instruction
extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
