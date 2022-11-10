//
//  StoryboardUI.swift
//  Pinvoice
//
//  Created by plaipa on 1/28/1400 AP.
//

import Foundation
import AVKit


extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


extension UIView {
    @IBInspectable
    var cornerRadiusPer: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = bounds.height / newValue
        }
    }
    
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
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
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
    
    @IBInspectable
    var shadowOpacity : Float {
        
        get{
            return layer.shadowOpacity
        }
        set {
            
            layer.shadowOpacity = newValue
            
        }
    }
    @IBInspectable
    var shadowOffset : CGSize{
        
        get{
            return layer.shadowOffset
        }set{
            
            layer.shadowOffset = newValue
        }
    }
    
    
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
}



//MARK: -- TextField Max Character
private var maxChar = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxCharacter: Int {
        get {
            guard let defaultMax = maxChar[self] else {
               return 150 // default limit for textField
            }
            return defaultMax
        }
        set {
            maxChar[self] = newValue
            addTarget(self, action: #selector(validatee), for: .editingChanged)
        }
    }
    @objc func validatee(textField: UITextField) {
        let t = textField.text
        textField.text = t?.prefix(maxCharacter).description
    }
}

