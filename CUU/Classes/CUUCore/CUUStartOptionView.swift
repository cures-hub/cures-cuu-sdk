//
//  CUUStartOptionView.swift
//  CUU
//
//  Created by Lara Marie Reimer on 13.07.18.
//

import Foundation
import UIKit

protocol CUUStartViewOptionDelegate: class {
    func didPressDisableButton(enabled: Bool, option: CUUStartOption) -> Void
}

class CUUStartOptionView: UIView {
    
    // MARK: Properties
    
    var didSetupConstraints = false
    
    weak var delegate: CUUStartViewOptionDelegate?

    var option: CUUStartOption
    
    // MARK: Initialization
    
    init(frame: CGRect, option: CUUStartOption) {
        self.option = option
        
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(disableButton)
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
            let viewsDictionary = ["title": titleLabel, "content": contentLabel, "disable": disableButton] as [String : Any]
            
            let centerTitleX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[disable]-18-[title]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let centerContentX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[disable]-18-[content]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let hConstraintsButton = NSLayoutConstraint.constraints(withVisualFormat: "V:|[title]-2-[content]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            
            let centerButtonY = NSLayoutConstraint(item: disableButton,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .centerY,
                                                   multiplier: 1.0,
                                                   constant: 0.0)
            
            addConstraints(centerTitleX)
            addConstraints(centerContentX)
            addConstraints(hConstraintsButton)
            addConstraint(centerButtonY)
        }
        super.updateConstraints()
    }
    
    // MARK: - Getters
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var contentLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var disableButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDisableButton), for: .touchUpInside)
        
        let bundle = Bundle(for: CUUStartOptionView.self)
        button.setImage(UIImage(named: "Checked.png", in: bundle, compatibleWith: nil), for: .selected)
        button.setImage(UIImage(named: "Unchecked.png", in: bundle, compatibleWith: nil), for: .normal)
        
        return button
    }()
    
    // MARK : - Button Actions
    
    @objc func didTapDisableButton(sender: UIButton) {
        guard let delegate = self.delegate else { return }
        let isSelected = !sender.isSelected
        sender.isSelected = isSelected
        
        delegate.didPressDisableButton(enabled:isSelected, option: option)
    }
}
