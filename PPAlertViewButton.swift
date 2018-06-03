//
//  PPAlertViewButtonAction.swift
//  PhonePe
//
//  Created by Jatin on 17/05/18.
//  Copyright © 2018 Jatin. All rights reserved.
//

import Foundation
import UIKit

public final class PPAlertViewButton {
    
    public enum ButtonStyle {
        case custom(textColor: UIColor, backgroundColor: UIColor, font: UIFont, cornerRadius: CGFloat)
        //Dark background and light text color
        case normal
        //Light background and dark text color
        case inverse
    }
    
    public let title: String
    public let handler: () -> Void
    public let style: ButtonStyle
    
    public init(title: String,
         style: ButtonStyle = .normal,
         handler: @escaping () -> Void) {
        self.title = title
        self.handler = handler
        self.style = style
    }
    
    public var titleColor: UIColor {
        switch style {
        case .custom(let textColor, _, _, _):
            return textColor
        case .normal:
            return .white
        case .inverse:
            return UIColor(red: 103.0/255.0, green: 63.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        }
    }
    
    public var backgroundColor: UIColor {
        switch style {
        case .custom(_, let backgroundColor, _, _):
            return backgroundColor
        case .normal:
            return UIColor(red: 103.0/255.0, green: 63.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        case .inverse:
            return .white
        }
    }
    
    public var cornerRadius: CGFloat {
        switch style {
        case .custom(_, _, _, let radius):
            return radius
        case .normal, .inverse:
            return 2.0
        }
    }
    
    public var font: UIFont {
        switch style {
        case .custom(_, _, let font, _):
            return font
        case .normal, .inverse:
            return UIFont.systemFont(ofSize: 20.0)
        }
    }
    
}
