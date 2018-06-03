//
//  TestCustomView.swift
//  PhonePe
//
//  Created by Jatin on 31/05/18.
//  Copyright © 2018 Jatin. All rights reserved.
//

import UIKit

final class TestCustomView: UIView {

    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        label = UILabel()
        label.textAlignment = .center
        label.text = "Add custom views here!"
        label.numberOfLines = 0
        label.ppe_add(self).ppe_enableAutolayout().ppe_pin(self)
    }
    
    override var intrinsicContentSize: CGSize {
        return label.intrinsicContentSize
    }
    
}
