//
//  UIViewController+EventTracking.swift
//  CUU
//
//  Created by Lara Marie Reimer on 04.03.18.
//

import UIKit

/**
 *  Extension for unifying the logging for view events and for enabling future method calls in view controllers.
 **/
extension UIViewController {
    func logViewDidAppearEvent() {
        IKViewEventInterceptor.log(self, type: .didAppear)
    }
    
    func logViewDidDisappearEvent() {
        IKViewEventInterceptor.log(self, type: .didDisappear)
    }
}
