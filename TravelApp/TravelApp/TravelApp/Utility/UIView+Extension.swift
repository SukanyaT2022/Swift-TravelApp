//
//  UIView+Extension.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 8/29/23.
//

import Foundation
import UIKit
@IBDesignable
extension UIView{
    @IBInspectable
    var cornerRadius: CGFloat{
        get{return layer.cornerRadius}
        set{layer.cornerRadius = newValue}
    }
}
