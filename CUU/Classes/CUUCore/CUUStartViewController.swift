//
//  CUUStartViewController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 13.07.18.
//

import Foundation
import UIKit

class CUUStartViewController: UIViewController, CUUStartViewDelegate {
    
    let cuuStartView: CUUStartView
    
    init(with options: [CUUStartOption]) {
        self.cuuStartView = CUUStartView(frame: CGRect.zero, options: options)
        cuuStartView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cuuStartView.delegate = self
        
        view.addSubview(cuuStartView)
        
        let viewsDictionary = ["start": cuuStartView] as [String : Any]
        
        //position constraints

        let contentConstraint = NSLayoutConstraint.constraints(withVisualFormat: "|[start]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let contentVConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[start]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        view.addConstraints(contentConstraint)
        view.addConstraints(contentVConstraint)
    }
    

    func didPressContinueButton(with selection: [CUUStartOption]) {
        // Activate the kits
        CUU.startKits(with: selection)
        
        // Delete old state
        UserDefaults.standard.removeObject(forKey: CUUConstants.CUUUserDefaultsKeys.optionsKey)
        
        // Persist state
        let rawValues = selection.map({ $0.rawValue })
        UserDefaults.standard.set(rawValues, forKey: CUUConstants.CUUUserDefaultsKeys.optionsKey)
        self.dismiss(animated: true, completion: nil)
    }
}
