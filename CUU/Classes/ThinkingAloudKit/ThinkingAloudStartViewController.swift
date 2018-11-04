//
//  ThinkingAloudStartViewController.swift
//  thinkingaloud
//
//  Created by Lara Marie Reimer on 20.05.18.
//  Copyright © 2018 Lara Marie Reimer. All rights reserved.
//

import UIKit
import Speech

protocol ThinkingAloudStartViewControllerDelegate : class {
    func thinkingAloudStartViewControllerDidPressStart()
}

class ThinkingAloudStartViewController: UIViewController, ThinkingAloudStartViewDelegate
{
    
    weak var delegate: ThinkingAloudStartViewControllerDelegate?
    
    var featureTitle : String = "" {
        didSet {
            thinkingAloudStartView.featureTitle = featureTitle
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thinkingAloudStartView.delegate = self
        
        view.addSubview(thinkingAloudStartView)
        
        let viewsDictionary = ["start": thinkingAloudStartView] as [String : Any]
        
        //position constraints
        let contentConstraint = NSLayoutConstraint.constraints(withVisualFormat: "|[start]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
        let contentVConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[start]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
        
        view.addConstraints(contentConstraint)
        view.addConstraints(contentVConstraint)
    }
    
    // MARK: - Getters
    
    var thinkingAloudStartView : ThinkingAloudStartView = {
        let view = ThinkingAloudStartView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func didPressGoButton(_: UIButton) {
        self.dismiss(animated: true)
        
        guard let delegate = delegate else { return }
        
        delegate.thinkingAloudStartViewControllerDidPressStart()
    }
    
    func didPressNoButton(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
