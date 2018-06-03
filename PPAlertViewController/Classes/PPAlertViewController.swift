//
//  PPAlertViewController.swift
//  PhonePe
//
//  Created by Jatin on 17/05/18.
//  Copyright © 2018 Jatin. All rights reserved.
//

import UIKit

public protocol PPAlertViewControllerDelegate: class {
    func alertViewController(_ alertViewController: PPAlertViewController, didTapInRange: PPAlertViewLabelTapppableRange)
}

public final class PPAlertViewController: UIViewController {
    
    public var containerStackView_V: UIStackView!
    public var buttonStackView_H: UIStackView!
    
    public var customView: UIView?
    public var titleLabel: UILabel!
    public var subtitleLabel: UILabel!
    public var separatorView: UIView!
    public var backgroundView: UIView!
    
    //Spacer views
    public var topSpacingView: UIView!
    public var titleTopSpacingView: UIView!
    public var subtitleTopSpacingView: UIView!
    public var separatorTopSpacingView: UIView!
    public var buttonTopSpacingView: UIView!
    public var bottomSpacingView: UIView!
    
    public var buttons = [PPAlertViewButton]()
    
    let appearence: PPAlertViewAppearence
    weak public var delegate: PPAlertViewControllerDelegate?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(appearence: PPAlertViewAppearence,
                delegate: PPAlertViewControllerDelegate? = nil) {
        self.appearence = appearence
        self.customView = appearence.customView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        setupViews()
    }
    
    public func addButton(_ button: PPAlertViewButton) {
        buttons.append(button)
    }
    
    private func setupViews() {
        
        containerStackView_V = UIStackView(arrangedSubviews: [])
        containerStackView_V.backgroundColor = UIColor.white
        containerStackView_V.axis = .vertical
        containerStackView_V.ppe_add(view).ppe_enableAutolayout()
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sides)-[sv]-(sides)-|", options: [], metrics: ["sides": appearence.margin.alertSides], views: ["sv": containerStackView_V]))
        view.addConstraint(NSLayoutConstraint(item: containerStackView_V, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        //Because the UIStackView doesn't have rendering phase
        //Hence we need a separate backgroundView to give the backgroundColor
        
        backgroundView = UIView().ppe_add(containerStackView_V).ppe_pin(containerStackView_V).ppe_enableAutolayout()
        backgroundView.backgroundColor = appearence.backgroundViewColor
        backgroundView.layer.cornerRadius = appearence.cornerRadius
        backgroundView.layer.masksToBounds = true
        
        if let customView = self.customView {
            //Add spacer view
            topSpacingView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.margin.top)
            containerStackView_V.addArrangedSubview(topSpacingView)
            
            containerStackView_V.addArrangedSubview(customView)
        }
        
        titleTopSpacingView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.margin.titleTop)
        containerStackView_V.addArrangedSubview(titleTopSpacingView)
        
        addTitleViews()
        addButtonsAndSeparator()
        
        bottomSpacingView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.margin.bottom)
        bottomSpacingView.backgroundColor = .clear
        containerStackView_V.addArrangedSubview(bottomSpacingView)
    }
    
    private func addTitleViews() {
        
        let titlePaddingStackView_H = UIStackView(arrangedSubviews: [])
        titlePaddingStackView_H.axis = .horizontal
        
        let leftSpacer = UIView().ppe_enableAutolayout().setWidthConstraint(appearence.margin.titleSides)
        titlePaddingStackView_H.addArrangedSubview(leftSpacer)
        
        let titleStackView_V = UIStackView(arrangedSubviews: [])
        titleStackView_V.axis = .vertical
        titlePaddingStackView_H.addArrangedSubview(titleStackView_V)
        
        let rightSpacer = UIView().ppe_enableAutolayout().setWidthConstraint(appearence.margin.titleSides)
        titlePaddingStackView_H.addArrangedSubview(rightSpacer)
        
        titleLabel = UILabel()
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.isUserInteractionEnabled = true
        appearence.title.apply(to: titleLabel)
        titleLabel.ppe_enableAutolayout()
        
        let titleLabelStackView = UIStackView(arrangedSubviews: [])
        titleLabelStackView.axis = .vertical
        titleLabelStackView.addArrangedSubview(titleLabel)
        titleStackView_V.addArrangedSubview(titleLabelStackView)
        
        subtitleTopSpacingView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.margin.subtitleTop)
        titleStackView_V.addArrangedSubview(subtitleTopSpacingView)
        
        subtitleLabel = UILabel()
        subtitleLabel.lineBreakMode = .byWordWrapping
        appearence.subtitle.apply(to: subtitleLabel)
        subtitleLabel.ppe_enableAutolayout()
        titleStackView_V.addArrangedSubview(subtitleLabel)
        
        containerStackView_V.addArrangedSubview(titlePaddingStackView_H)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        titleLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func addButtonsAndSeparator() {
        
        guard !buttons.isEmpty else {
            return
        }
        
        separatorTopSpacingView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.margin.separatorTop)
        containerStackView_V.addArrangedSubview(separatorTopSpacingView)
        
        separatorView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.separator.height)
        separatorView.backgroundColor = UIColor.gray
        containerStackView_V.addArrangedSubview(separatorView)
        
        buttonTopSpacingView = UIView().ppe_enableAutolayout().setHeightConstraint(appearence.margin.buttonTop)
        containerStackView_V.addArrangedSubview(buttonTopSpacingView)
        
        buttonStackView_H = UIStackView(arrangedSubviews: [])
        buttonStackView_H.ppe_enableAutolayout()
        containerStackView_V.addArrangedSubview(buttonStackView_H)
        
        //Add a spacer view before the buttons
        let buttonSpacer = UIView().ppe_enableAutolayout().setWidthConstraint(appearence.margin.buttonSides)
        buttonStackView_H.addArrangedSubview(buttonSpacer)
        
        for b in buttons {
            let button = UIButton(type: .system)
            button.setTitle(b.title, for: .normal)
            button.setTitleColor(b.titleColor, for: .normal)
            button.backgroundColor = b.backgroundColor
            button.layer.cornerRadius = b.cornerRadius
            button.layer.masksToBounds = true
            button.titleLabel?.font = b.font
            button.ppe_enableAutolayout()
            buttonStackView_H.addArrangedSubview(button)
            button.setHeightConstraint(appearence.buttonHeight)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            
            //#spacerviews = #buttons + 1
            //Reduce the width of each button proportionally based on the total space taken by spacer views
            let widthAdjustment = (appearence.margin.buttonSides * CGFloat(buttons.count + 1)) / CGFloat(buttons.count)
            buttonStackView_H.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: buttonStackView_H, attribute: .width, multiplier: CGFloat(1.0)/CGFloat(buttons.count), constant: -widthAdjustment))
            
            //Add a spacer view after every button
            let buttonSpacer = UIView().ppe_enableAutolayout().setWidthConstraint(appearence.margin.buttonSides)
            buttonStackView_H.addArrangedSubview(buttonSpacer)
        }
        
    }
    
    public override func viewDidLayoutSubviews() {
        backgroundView.layer.masksToBounds = true
        backgroundView.clipsToBounds = true
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowPath = UIBezierPath(rect: backgroundView.bounds).cgPath
        backgroundView.layer.shadowOpacity = 1.0
        backgroundView.layer.shadowRadius = 10.0
    }
    
    @objc
    func labelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard titleLabel.text != nil else {
            return
        }
        
        for tappableRange in appearence.tappableTitleRanges {
            if gestureRecognizer.didTapAttributedTextInLabel(titleLabel, targetRange: tappableRange.range) {
                delegate?.alertViewController(self, didTapInRange: tappableRange)
                return
            }
        }
    }
    
    @objc
    func buttonPressed(_ button: UIButton) {
        
        var index = 0
        
        //Considering only buttons out of the arranged subviews (because there are spacer views present as well)
        for view in buttonStackView_H.arrangedSubviews {
            if view as? UIButton != nil {
                if view === button {
                    self.dismiss(animated: true, completion: nil)
                    buttons[index].handler()
                    break
                }
                
                index += 1
            }
        }
        
    }
    
    
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(_ label: UILabel, targetRange: NSRange) -> Bool {
        
        guard let attributedText = label.attributedText else {
            return false
        }
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer to match label's characteristics
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
