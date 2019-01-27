//
//  CUUStartView.swift
//  CUU
//
//  Created by Lara Marie Reimer on 13.07.18.
//

import Foundation
import UIKit

protocol CUUStartViewDelegate : class {
    func didPressContinueButton(with selection: [CUUStartOption]) -> Void
}

class CUUStartView: UIView, CUUStartViewOptionDelegate {

    // MARK: Properties
    
    var didSetupConstraints = false
    
    weak var delegate : CUUStartViewDelegate?
    
    // Options selected by the user.
    var selectedOptions : [CUUStartOption] = [.Features, .Interactions]
    
    // Options allowed by the developer.
    var allowedOptions : [CUUStartOption] = [.Features, .Interactions]
    
    // MARK: Initialization
    
    init(frame: CGRect, options: [CUUStartOption]) {
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
        
        if options.contains(.Behavior) {
            self.kitStackView.addArrangedSubview(self.behaviorKitView)
            self.behaviorKitView.delegate = self
            self.selectedOptions.append(.Behavior)
            self.allowedOptions.append(.Behavior)
        }
        
        if options.contains(.Notes) {
            self.kitStackView.addArrangedSubview(self.noteKitView)
            self.noteKitView.delegate = self
            self.selectedOptions.append(.Notes)
            self.allowedOptions.append(.Behavior)
        }
    
        if options.contains(.ThinkingAloud) && ThinkingAloudKit.isSupported {
            self.kitStackView.addArrangedSubview(self.thinkingAloudKitView)
            self.thinkingAloudKitView.delegate = self
            self.allowedOptions.append(.ThinkingAloud)
        }
        
        if options.contains(.Emotions) && EmotionKit.isSupported {
            self.kitStackView.addArrangedSubview(self.emotionKitView)
            self.emotionKitView.delegate = self
            self.allowedOptions.append(.Emotions)
        }
        
        if options.contains(.Personas) {
            self.kitStackView.addArrangedSubview(self.personaKitView)
            self.personaKitView.delegate = self
            self.allowedOptions.append(.Personas)
        }
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
            
            let scrollViewHC = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scroll]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            let scrollViewVC = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scroll]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            
            let backgroundViewHC = NSLayoutConstraint.constraints(withVisualFormat: "H:|[background(screenWidth)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewsDictionary)
            let backgroundViewVC = NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            
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
            
            let centerTitleX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let centerContentX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[content]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let hConstraintsStack = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stack]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let hConstraintsButton = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[go]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[title]-40-[content]-30-[stack]-(>=30)-[go]-30-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            
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
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 24.0
        return stackView
    }()
    
    var featureKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Features)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "FeatureKit"
        view.contentLabel.text = "Tracks if the usage of a feature is started, cancelled, or finished. Cannot be disabled."
        view.isUserInteractionEnabled = false
        view.disableButton.isSelected = true
        return view
    }()
    
    var interactionKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Interactions)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "InteractionKit"
        view.contentLabel.text = "Collects information on application usage and device specifications. Cannot be disabled."
        view.isUserInteractionEnabled = false
        view.disableButton.isSelected = true
        return view
    }()
    
    var behaviorKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Behavior)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "BehaviorKit"
        view.contentLabel.text = "Analyzes user interactions and device data to draw conclusions about person- and application-related information as well as application-related usability issues.l."
        view.disableButton.isSelected = true
        return view
    }()
    
    var noteKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Notes)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "NoteKit"
        view.contentLabel.text = "Enables textual feedback by shaking the device."
        view.disableButton.isSelected = true
        return view
    }()
    
    var thinkingAloudKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .ThinkingAloud)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "ThinkingAloudKit"
        view.contentLabel.text = "Enables verbal feedback for specific features using the Thinking Aloud method."
        view.disableButton.isSelected = false
        return view
    }()
    
    var emotionKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Emotions)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "EmotionKit"
        view.contentLabel.text = "Derives emotions based on facial expressions to draw conclusions about the usage of a feature."
        view.disableButton.isSelected = false
        return view
    }()
    
    var personaKitView : CUUStartOptionView = {
        let view = CUUStartOptionView(frame: .zero, option: .Personas)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "PersonaKit"
        view.contentLabel.text = "Information on application usage and device specifications."
        view.disableButton.isSelected = false
        return view
    }()
    
    var goButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapGoButton), for: .touchUpInside)
        button.setTitle("Continue", for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.07676978277, green: 0.378797845, blue: 0.8541600571, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 15.0, left: 35.0, bottom: 15.0, right: 35.0)
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
            if !selectedOptions.contains(option) && allowedOptions.contains(option) {
                selectedOptions.append(option)
            }
        } else {
            if selectedOptions.contains(option) && allowedOptions.contains(option) {
                if let index = selectedOptions.index(of: option) {
                    selectedOptions.remove(at: index)
                }
            }
        }
    }
}
