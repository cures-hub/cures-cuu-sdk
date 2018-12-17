//
//  ThinkingAloudSessionIndicator.swift
//  thinkingaloud
//
//  Created by Lara Marie Reimer on 27.05.18.
//  Copyright © 2018 Lara Marie Reimer. All rights reserved.
//

import UIKit

protocol ThinkingAloudSessionIndicatorDelegate : class {
    func thinkingAloudIndicatorDidAbortSession()
}

class ThinkingAloudSessionIndicator : UIView {
    
    var didSetupConstraints = false
    
    weak var delegate: ThinkingAloudSessionIndicatorDelegate?
    
    var indicator : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return view
    }()
    
    var image : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        let bundle = Bundle(for: ThinkingAloudSessionIndicator.self)
        if let url = bundle.url(forResource: "CUU",
                                withExtension: "bundle"), let bundle = Bundle(url: url) {
            imageView.image = UIImage(named: "voice-recorder.png", in: bundle, compatibleWith: nil)
        }
        return imageView
    }()
    
    var text : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.text = "Recording..."
        return label
    }()
    
    var abort : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let bundle = Bundle(for: ThinkingAloudSessionIndicator.self)
        button.setImage(UIImage(named: "cancel.png", in: bundle, compatibleWith:nil), for: .normal)
        button.addTarget(self, action: #selector(didTapAbort(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        
        self.addSubview(indicator)
        self.indicator.addSubview(image)
        self.indicator.addSubview(text)
        self.indicator.addSubview(abort)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Autolayout
    
    override func updateConstraints() {
        if(!didSetupConstraints) {
            // AutoLayout constraints
            didSetupConstraints = true
            
            var topSafeArea = CGFloat(17)
            
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                if let top = window?.safeAreaInsets.top {
                    if top > CGFloat(0.0) {
                        topSafeArea = top - 10
                    }
                }
            }
            
            //position constraints
            let viewsDictionary = ["background": indicator, "image": image, "text": text, "abort": abort] as [String : Any]
            let metrics = ["top": topSafeArea] as [String : Any]
            
            let hConstraintsBackground = NSLayoutConstraint.constraints(withVisualFormat: "H:|[background]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            let vConstraintsBackground = NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
            let hConstraintsContent = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[image(17)]-(>=10)-[text]-(>=10)-[abort(17)]-10-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
            let heightImage = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[image(17)]-4-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewsDictionary)
            let heightButton = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[abort(17)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: viewsDictionary)
            let centerTextX = NSLayoutConstraint(item: text, attribute: .centerX, relatedBy:.equal, toItem: indicator, attribute: .centerX, multiplier: 1.0, constant: 1.0)
            let centerTextY = NSLayoutConstraint(item: text, attribute: .centerY, relatedBy:.equal, toItem: abort, attribute: .centerY, multiplier: 1.0, constant: 1.0)
            
            addConstraints(hConstraintsBackground)
            addConstraints(vConstraintsBackground)
            addConstraints(hConstraintsContent)
            addConstraint(centerTextX)
            addConstraint(centerTextY)
            addConstraints(heightImage)
            addConstraints(heightButton)
        }
        super.updateConstraints()
    }
    
    @objc func didTapAbort(sender: UIButton) {
        guard let delegate = delegate else { return }
        delegate.thinkingAloudIndicatorDidAbortSession()
    }
}
