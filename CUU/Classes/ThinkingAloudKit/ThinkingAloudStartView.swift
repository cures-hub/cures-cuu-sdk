//
//  ThinkingAloudStartScreen.swift
//  thinkingaloud
//
//  Created by Lara Marie Reimer on 20.05.18.
//  Copyright © 2018 Lara Marie Reimer. All rights reserved.
//

import Foundation
import UIKit

protocol ThinkingAloudStartViewDelegate : class {
    func didPressGoButton(_: UIButton) -> Void
    func didPressNoButton(_: UIButton) -> Void
}

class ThinkingAloudStartView: UIView {
    
    // MARK: Properties
    
    var featureTitle: String = "" {
        didSet {
            contentLabel.text = "Du hast unser Feature \"\(featureTitle)\" gestartet.\n\n Wir freuen uns immer über Feedback. Möchtest du jetzt einen \"Thinking Aloud\" Feedback Run starten?"
        }
    }
    
    var didSetupConstraints = false
    
    weak var delegate : ThinkingAloudStartViewDelegate?
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.withAlphaComponent(UIColor.black)(0.5)
        
        self.addSubview(backgroundView)
        self.backgroundView.addSubview(titleLabel)
        self.backgroundView.addSubview(imageView)
        self.backgroundView.addSubview(contentLabel)
        self.backgroundView.addSubview(goButton)
        self.backgroundView.addSubview(denyButton)
        
        goButton.addTarget(self, action: #selector(didTapGoButton), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(didTapDenyButton), for: .touchUpInside)
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
            let viewsDictionary = ["background": backgroundView, "title": titleLabel, "image": imageView, "content": contentLabel, "deny": denyButton, "go": goButton] as [String : Any]
            
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[background]-40-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let centerContentY = NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy:.equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 1.0)
            let centerTitleX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[title]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let centerImageX = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy:.equal, toItem: backgroundView, attribute: .centerX, multiplier: 1.0, constant: 1.0)
            let widthImage = NSLayoutConstraint.constraints(withVisualFormat: "H:[image(51)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let centerContentX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[content]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let hConstraintsButton = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[deny]-(>=10@750)-[go]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[title]-20-[image(51)]-20-[content]-30-[deny]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let vConstraintsGo = NSLayoutConstraint.constraints(withVisualFormat: "V:[go]-20-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            
            addConstraints(hConstraints)
            addConstraint(centerContentY)
            addConstraints(centerTitleX)
            addConstraint(centerImageX)
            addConstraints(widthImage)
            addConstraints(centerContentX)
            addConstraints(hConstraintsButton)
            addConstraints(vConstraints)
            addConstraints(vConstraintsGo)
        }
        super.updateConstraints()
    }
    
    // MARK: - Getters
    
    var backgroundView : UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.white
        background.layer.cornerRadius = 15.0
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Hey!"
        return label
    }()
    
    var imageView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25.5
        
        let image = UIImageView()
        image.backgroundColor = UIColor.clear
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let bundle = Bundle(for: ThinkingAloudStartView.self)
        image.image = UIImage(named: "voice-recorder.png", in: bundle, compatibleWith: nil)
        
        view.addSubview(image)
        
        let viewsDictionary = ["image": image] as [String : Any]
        
        //position constraints
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(35)]-|",options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(35)]-|",options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
        
        view.addConstraints(hConstraints)
        view.addConstraints(vConstraints)
        
        return view
    }()
    
    var contentLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var goButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Los gehts!", for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.2084427476, green: 0.4629764557, blue: 0.8655824065, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 35.0, bottom: 10.0, right: 35.0)
        return button
    }()
    
    var denyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Nein, danke", for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        return button
    }()
    
    
    // MARK : - Button Actions
    
    @objc func didTapGoButton(sender: UIButton) {
        guard let delegate = self.delegate else { return }
        delegate.didPressGoButton(sender)
    }
    
    @objc func didTapDenyButton(sender: UIButton) {
        guard let delegate = self.delegate else { return }
        delegate.didPressNoButton(sender)
    }
}
