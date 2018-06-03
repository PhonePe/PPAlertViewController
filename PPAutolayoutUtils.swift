//
//  PPAutolayoutUtils.swift
//  PhonePe
//
//  Created by Jatin on 18/05/18.
//  Copyright © 2018 Jatin. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    public func ppe_pin(_ superV: UIView) -> UIView {
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: superV.trailingAnchor),
            leadingAnchor.constraint(equalTo: superV.leadingAnchor),
            topAnchor.constraint(equalTo: superV.topAnchor),
            bottomAnchor.constraint(equalTo: superV.bottomAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func ppe_pinSides(_ superV: UIView) -> UIView {
        self.trailingAnchor.constraint(equalTo: superV.trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superV.leadingAnchor).isActive = true
        return self
    }
    
    @discardableResult
    public func ppe_enableAutolayout() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    public func ppe_add(_ superV: UIView) -> UIView {
        superV.addSubview(self)
        return self
    }
    
    @discardableResult
    public func setHeightConstraint(_ height: CGFloat) -> UIView {
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height))
        return self
    }
    
    @discardableResult
    public func setWidthConstraint(_ width: CGFloat) -> UIView {
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width))
        return self
    }

}
