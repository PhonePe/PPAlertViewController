//
//  ViewController.swift
//  PPAlertViewController
//
//  Created by arorajatin on 06/02/2018.
//  Copyright (c) 2018 arorajatin. All rights reserved.
//

import UIKit
import PPAlertViewController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let customView = TestCustomView(frame: CGRect.zero).ppe_enableAutolayout()
        
        let attrString = NSMutableAttributedString(string: "This alert will help you.", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0)])
        let linkAttrSting = NSMutableAttributedString(string: "Terms & Conditons Apply", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0)])
        attrString.append(linkAttrSting)
        
        let attributedTitle = PPAlertViewAppearence.Label(attributedText: attrString)
        let rangeOfTNC = (attributedTitle.attributedText!.string as NSString).range(of: "Terms & Conditons Apply")
        let tappableRange = PPAlertViewLabelTapppableRange(name: "t&c", range: rangeOfTNC)
        
        let subtitle = PPAlertViewAppearence.Label(text: "You look very nice today", textColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.7), font: UIFont.systemFont(ofSize: 15.0))
        
        let appearence = PPAlertViewAppearence(customView: customView, title: attributedTitle, subtitle: subtitle, tappableTitleRanges: [tappableRange])
        
        let alertController = PPAlertViewController(appearence: appearence, delegate: self)
        alertController.addButton(PPAlertViewButton(title: "Button1", style: .inverse, handler: {}))
        alertController.addButton(PPAlertViewButton(title: "Button2", handler: {}))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController: PPAlertViewControllerDelegate {
    func alertViewController(_ alertViewController: PPAlertViewController, didTapInRange: PPAlertViewLabelTapppableRange) {
        print("Callback received")
    }
}



