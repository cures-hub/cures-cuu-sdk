//
//  ThinkingAloudController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.05.18.
//  Copyright © 2018 Lara Marie Reimer. All rights reserved.
//

import Foundation
import UIKit

class ThinkingAloudController : ThinkingAloudStartViewControllerDelegate, ThinkingAloudSessionIndicatorDelegate {
    
    var recognitionManagers = [RecognitionManager]()
    
    var indicatorView : ThinkingAloudSessionIndicator = {
        let indicator = ThinkingAloudSessionIndicator()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var indicatorTopConstraint = NSLayoutConstraint()
    
    var currentFeature: CUUFeature?
    
    var isActive = false
    
    var previousCrumbId: String?
    
    // MARK: - Lifecycle
    
    init() {
        // Register observer for feature crumbs.
        NotificationCenter.default.addObserver(self, selector: #selector(crumbReceived(notification:)), name: .didTriggerCrumb, object: nil)
    }
    
    // MARK: - Thinking Aloud Run Controlling
    
    @objc func crumbReceived(notification: NSNotification) {
        if !ThinkingAloudKit.isActive { return }
        
        let payload = notification.userInfo
        
        let featureArray = CUUUserManager.sharedManager.completedThinkingAloudFeatures
        if let payload = payload,
            let feature = payload["feature"] as? CUUFeature,
            let isFirst = payload["isFirst"] as? Bool,
            let isLast = payload["isLast"] as? Bool,
            let crumbId = payload["crumbId"] as? String {
            if (!featureArray.contains(String(feature.id))) {
                if !isActive && isFirst && !isLast {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.currentFeature = feature
                        self.previousCrumbId = crumbId
                        self.start()
                    }
                } else {
                    if let currentFeature = currentFeature {
                        if feature.id == currentFeature.id {
                            guard let id = previousCrumbId else { return }
                            stopRecording(isLast: false, for: id)
                            previousCrumbId = crumbId
                            startRecording()
                            
                            if (isLast) {
                                stop(for: crumbId)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func start() {
        guard let feature = currentFeature else { return }
        
        let startVC = ThinkingAloudStartViewController()
        startVC.modalPresentationStyle = .overFullScreen
        startVC.delegate = self
        startVC.featureTitle = feature.name
        let currentVC = CUUUtils.getTopViewController()
        currentVC?.present(startVC, animated: true, completion: nil)
        
        isActive = true
    }
    
    func stop(for crumb: String) {
        // Give the tester 5 seconds to finish their feedback.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.stopRecording(isLast: true, for: crumb)
            
            self.isActive = false
            
            // Store it in user defaults
            if let id = self.currentFeature?.id {
                var featureArray = CUUUserManager.sharedManager.completedThinkingAloudFeatures
                featureArray.append(String(id))
                UserDefaults.standard.set(featureArray, forKey: CUUConstants.CUUUserDefaultsKeys.thinkingAloudFeaturesKey)
            }
        }
    }
    
    func startRecording() {
        let manager = RecognitionManager()
        if let id = previousCrumbId {
            manager.previousCrumbId = id
        }
        // Add it to managers array.
        self.recognitionManagers.append(manager)
        DispatchQueue.global().async {
            manager.recordAndRecognizeSpeech()
        }
    }
    
    func stopRecording(isLast: Bool, for crumb: String) {
        print(crumb)
        for manager in recognitionManagers {
            if manager.previousCrumbId == crumb {
                manager.stopRecording(isLast: isLast, with: { (result, analyzedResult) in
                    DispatchQueue.main.async {
                        if let feature = self.currentFeature {
                            let dataObject = DefaultThinkingAloudRecognition(featureId: String(feature.id), previousCrumbId: crumb, content: result, analysis: analyzedResult)
                            dataObject.send()
                        }
                        
                        if isLast {
                            let alert = UIAlertController(title: "Du bist fertig!", message: "Danke für dein Feedback!", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                                self.animateInOut(animateIn: false)
                            }))
                            
                            if let currentVC = CUUUtils.getTopViewController() {
                                currentVC.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    // Remove manager from array.
                    self.recognitionManagers = self.recognitionManagers.filter({ $0.previousCrumbId != crumb })
                })
                break
            }
        }
    }
    
    // MARK: - UI
    func showSessionIndicator() {
        guard let topVC = CUUUtils.getTopViewController(), let window = topVC.view.window else { return }
        
        indicatorView.delegate = self
        
        window.addSubview(indicatorView)
        
        //position constraints
        let viewsDictionary = ["indicator": indicatorView] as [String : Any]
        
        let hConstraintsIndicator = NSLayoutConstraint.constraints(withVisualFormat: "H:|[indicator]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),metrics: nil, views: viewsDictionary)
        indicatorTopConstraint = NSLayoutConstraint(item: indicatorView, attribute: .bottom, relatedBy:.equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        window.addConstraints(hConstraintsIndicator)
        window.addConstraint(indicatorTopConstraint)
        
        window.setNeedsUpdateConstraints();
        window.setNeedsLayout();
        window.layoutIfNeeded();
        
        animateInOut(animateIn: true)
    }
    
    func animateInOut(animateIn: Bool) {
        guard let topVC = CUUUtils.getTopViewController(), let window = topVC.view.window else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3, animations: {
                let height = self.indicatorView.frame.height
                
                self.indicatorTopConstraint.constant = animateIn ? CGFloat(height) : 0.0
                
                window.setNeedsUpdateConstraints()
                window.setNeedsLayout()
                window.layoutIfNeeded()
            }, completion: { (completed) in
                if completed && !animateIn {
                    self.indicatorView.removeFromSuperview()
                }
            })
        }
    }
    
    // MARK: - ThinkingAloudStartViewControllerDelegate
    
    func thinkingAloudStartViewControllerDidPressStart() {
        RecognitionManager.checkAuthorizationAndStart { (granted) in
            if granted {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.showSessionIndicator()
                }
                self.startRecording()
            }
        }
    }
    
    // MARK: - ThinkingAloudSessionIndicatorDelegate
    
    func thinkingAloudIndicatorDidAbortSession() {
        guard let topVC = CUUUtils.getTopViewController() else { return }
        
        let alert = UIAlertController(title: "Session abbrechen", message: "Willst du die aktuelle Feedback Session wirklich abbrechen?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            // Do nothing.
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            if let previousCrumbId = self.previousCrumbId {
                self.stop(for: previousCrumbId)
            }
        }))
        topVC.present(alert, animated: true, completion: nil)
    }
}
