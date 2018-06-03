//
//  PPAlertViewAppearence.swift
//  PhonePe
//
//  Created by Jatin on 21/05/18.
//  Copyright © 2018 Jatin. All rights reserved.
//

import Foundation
import UIKit

public struct PPAlertViewAppearence {
    
    public let customView: UIView?
    public let title: Label
    public let subtitle: Label
    public let separator: Separator
    public let buttonHeight: CGFloat
    public let backgroundViewColor: UIColor
    public let cornerRadius: CGFloat
    public let margin: Margin
    public let tappableTitleRanges: [PPAlertViewLabelTapppableRange]
    
    public struct Separator {
        public let height: CGFloat
        public let color: UIColor
        
        public init(height: CGFloat = 1,
                    color: UIColor = UIColor.gray) {
            self.height = height
            self.color = color
        }
    }
    
    public struct Label {
        public let text: String
        public let attributedText: NSAttributedString?
        public let textColor: UIColor
        public let backgroundColor: UIColor
        public let font: UIFont
        
        public init(text: String = "",
                    attributedText: NSAttributedString? = nil,
                    textColor: UIColor = .black,
                    backgroundColor: UIColor = .clear,
                    font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
            self.text = text
            self.attributedText = attributedText
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.font = font
        }
        
        func apply(to label: UILabel) {
            label.textColor = self.textColor
            label.font = self.font
            label.backgroundColor = self.backgroundColor
            label.text = self.text
            
            if let attrText = self.attributedText {
                label.attributedText = attrText
            }
            
            label.numberOfLines = 0
            label.textAlignment = .center
        }
    }
    
    public struct Margin {
        public let top: CGFloat
        public let titleTop: CGFloat
        public let subtitleTop: CGFloat
        public let separatorTop: CGFloat
        public let buttonTop: CGFloat
        public let bottom: CGFloat
        public let buttonSides: CGFloat
        public let alertSides: CGFloat
        public let titleSides: CGFloat
        
        public init(top: CGFloat = 24,
                    titleTop: CGFloat = 24,
                    subtitleTop: CGFloat = 24,
                    separatorTop: CGFloat = 24,
                    buttonTop: CGFloat = 8,
                    bottom: CGFloat = 8,
                    buttonSides: CGFloat = 8,
                    alertSides: CGFloat = 40,
                    titleSides: CGFloat = 24) {
            self.top = top
            self.titleTop = titleTop
            self.subtitleTop = subtitleTop
            self.separatorTop = separatorTop
            self.buttonTop = buttonTop
            self.bottom = bottom
            self.buttonSides = buttonSides
            self.alertSides = alertSides
            self.titleSides = titleSides
        }
    }
    
    public init(customView: UIView? = nil,
                title: Label = Label(),
                subtitle: Label = Label(),
                separator: Separator = Separator(),
                buttonHeight: CGFloat = 40.0,
                backgroundViewColor: UIColor = .clear,
                cornerRadius: CGFloat = 5.0,
                margin: Margin = Margin(),
                tappableTitleRanges: [PPAlertViewLabelTapppableRange] = []) {
        self.customView = customView
        self.title = title
        self.subtitle = subtitle
        self.separator = separator
        self.buttonHeight = buttonHeight
        self.backgroundViewColor = backgroundViewColor
        self.cornerRadius = cornerRadius
        self.margin = margin
        self.tappableTitleRanges = tappableTitleRanges
    }
    
}
