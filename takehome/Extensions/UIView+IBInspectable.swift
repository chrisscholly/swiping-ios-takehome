//
//  UIView+IBInspectable.swift
//  takehome
//
//  Created by Christophe Scholly on 17/08/2020.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var leftBorderWidth: CGFloat {
        get {
            return 0 // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)

            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "|[line(==lineWidth)]",
                options: [],
                metrics: metrics,
                views: views
            ))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[line]|",
                options: [],
                metrics: nil,
                views: views
            ))
        }
    }

    @IBInspectable
    var topBorderWidth: CGFloat {
        get {
            return 0 // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)

            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "|[line]|",
                options: [],
                metrics: nil,
                views: views
            ))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[line(==lineWidth)]",
                options: [],
                metrics: metrics,
                views: views
            ))
        }
    }

    @IBInspectable
    var rightBorderWidth: CGFloat {
        get {
            return 0 // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: bounds.width, y: 0, width: newValue, height: bounds.height))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)

            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "[line(==lineWidth)]|",
                options: [],
                metrics: metrics,
                views: views
            ))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[line]|",
                options: [],
                metrics: nil,
                views: views
            ))
        }
    }

    @IBInspectable
    var bottomBorderWidth: CGFloat {
        get {
            return 0 // Just to satisfy property
        }
        set {
            let line = UIView(frame: CGRect(x: 0, y: bounds.height, width: bounds.width, height: newValue))
            line.translatesAutoresizingMaskIntoConstraints = false
            line.backgroundColor = borderColor
            self.addSubview(line)

            let views = ["line": line]
            let metrics = ["lineWidth": newValue]
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "|[line]|",
                options: [],
                metrics: nil,
                views: views
            ))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:[line(==lineWidth)]|",
                options: [],
                metrics: metrics,
                views: views
            ))
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

@IBDesignable class DesignableView: UIView {}
@IBDesignable class DesignableImageView: UIImageView {}
@IBDesignable class DesignableTextField: UITextField {}
@IBDesignable class DesignableTextView: UITextView {}
@IBDesignable class DesignableLabel: UILabel {}
@IBDesignable class DesignableButton: UIButton {}
@IBDesignable class DesignableVisualEffectView: UIVisualEffectView {}
@IBDesignable class DesignableActivityIndicatorView: UIActivityIndicatorView {}
@IBDesignable class DesignableSwitch: UISwitch {}
