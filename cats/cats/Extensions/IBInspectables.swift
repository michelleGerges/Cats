//
//  IBInspectables.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//


import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var defaultShadow: Bool {
        get {
            return false
        }
        set(value) {
            if value {
                self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowRadius = 4
                self.layer.shadowOpacity = 1.0
            }
        }
    }
}

extension UITextField {
    
    @IBInspectable var placeholderColor: UIColor? {
        get { return nil }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                            attributes: [.foregroundColor: newValue ?? UIColor.white])
        }
    }
}
