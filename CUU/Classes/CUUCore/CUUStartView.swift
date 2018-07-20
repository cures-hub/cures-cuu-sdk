//
//  CUUStartView.swift
//  CUU
//
//  Created by Lara Marie Reimer on 13.07.18.
//

import Foundation
import UIKit

enum CUUStartOption: Int {
    case Features = 0
    case Interactions
}

protocol CUUStartViewDelegate : class {
    func didPressContinueButton(with selection: [CUUStartOption]) -> Void
}

class CUUStartView: UIView, CUUStartViewOptionDelegate {

    // MARK: Properties
    
    var didSetupConstraints = false
    
    weak var delegate : CUUStartViewDelegate?
    
    var selectedOptions: [CUUStartOption] = [.Features, .Interactions]
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        
        self.addSubview(scrollView)
        self.scrollView.addSubview(backgroundView)
        self.backgroundView.addSubview(titleLabel)
        self.backgroundView.addSubview(contentLabel)
        self.backgroundView.addSubview(goButton)
        self.backgroundView.addSubview(kitStackView)
        
        self.kitStackView.addArrangedSubview(self.featureKitView)
        self.kitStackView.addArrangedSubview(self.interactionKitView)
        
        self.featureKitView.delegate = self
        self.interactionKitView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Autolayout
    
    override func updateConstraints() {
        if(!didSetupConstraints) {
            // AutoLayout constraints
            didSetupConstraints = true
            
            //position constraints
            let viewsDictionary = ["scroll": scrollView, "background": backgroundView, "title": titleLabel, "content": contentLabel, "stack": kitStackView, "go": goButton] as [String : Any]
            let metrics = ["screenWidth": UIScreen.main.bounds.width] as [String : Any]
            
            let scrollViewHC = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scroll]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            let scrollViewVC = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scroll]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            
            let backgroundViewHC = NSLayoutConstraint.constraints(withVisualFormat: "H:|[background(screenWidth)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: viewsDictionary)
            let backgroundViewVC = NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            
            let backgroundWidth = NSLayoutConstraint(item: backgroundView,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .width,
                                           multiplier: 1.0,
                                           constant: 0.0)
            
            let backgroundHeight = NSLayoutConstraint(item: backgroundView,
                                                     attribute: .height,
                                                     relatedBy: .greaterThanOrEqual,
                                                     toItem: self,
                                                     attribute: .height,
                                                     multiplier: 1.0,
                                                     constant: 0.0)
            
            let centerTitleX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title]-10-|", options: NSLayoutFormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let centerContentX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[content]-10-|", options: NSLayoutFormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let hConstraintsStack = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stack]-20-|", options: NSLayoutFormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let hConstraintsButton = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[go]-20-|", options: NSLayoutFormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[title]-40-[content]-30-[stack]-(>=30)-[go]-30-|", options: NSLayoutFormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            
            addConstraints(scrollViewHC)
            addConstraints(scrollViewVC)
            addConstraint(backgroundWidth)
            addConstraint(backgroundHeight)
            scrollView.addConstraints(backgroundViewHC)
            scrollView.addConstraints(backgroundViewVC)
            backgroundView.addConstraints(centerTitleX)
            backgroundView.addConstraints(centerContentX)
            backgroundView.addConstraints(hConstraintsStack)
            backgroundView.addConstraints(hConstraintsButton)
            backgroundView.addConstraints(vConstraints)
        }
        super.updateConstraints()
    }
    
    // MARK: - Getters
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Continuous User Understanding"
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "This release automatically collects information about its usage. Please review the following options."
        return label
    }()
    
    var kitStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.leading
        stackView.spacing = 24.0
        return stackView
    }()
    
    var featureKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Features)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "FeatureKit"
        view.contentLabel.text = "Information on whether a feature has been used and how often."
        return view
    }()
    
    var interactionKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Interactions)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "InteractionKit"
        view.contentLabel.text = "Information on application usage and device specifications."
        return view
    }()
    
    var goButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapGoButton), for: .touchUpInside)
        button.setTitle("Continue", for: UIControlState.normal)
        button.backgroundColor = #colorLiteral(red: 0.07676978277, green: 0.378797845, blue: 0.8541600571, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.contentEdgeInsets = UIEdgeInsetsMake(15.0, 35.0, 15.0, 35.0)
        return button
    }()
    
    // MARK : - Button Actions
    
    @objc func didTapGoButton(sender: UIButton) {
        guard let delegate = self.delegate else { return }
        delegate.didPressContinueButton(with: selectedOptions)
    }
    
    // MARK : - Delegate
    
    func didPressDisableButton(enabled: Bool, option: CUUStartOption) {
        if (enabled) {
            if !selectedOptions.contains(option) {
                selectedOptions.append(option)
            }
        } else {
            if selectedOptions.contains(option) {
                if let index = selectedOptions.index(of: option) {
                    selectedOptions.remove(at: index)
                }
            }
        }
    }
}
