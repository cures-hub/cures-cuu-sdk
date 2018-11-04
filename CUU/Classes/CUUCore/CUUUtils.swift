//
//  CUUUtils.swift
//  CUU
//
//  Created by Lara Marie Reimer on 17.06.18.
//

import UIKit

public class CUUUtils {
    static func getTopViewController() -> UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        var currentVC = rootViewController
        
        while let presentedVC = currentVC.presentedViewController {
            currentVC = presentedVC
        }
        
        return currentVC
    }
}

extension Notification.Name {
    static let didTriggerCrumb = Notification.Name("de.tum.in.ase.cuu.featurekit.didTriggerFeatureCrumb")
}
