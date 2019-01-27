//
//  ViewController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12/30/2017.
//  Copyright (c) 2017 Lara Marie Reimer. All rights reserved.
//

import UIKit
import CUU

class ViewController: CUUViewController {
    @IBAction func didTapTryFeatureKitButton(_ sender: UIButton) {
        // Notify the FeatureKit component of CUU that a step of a feature was triggered.
        CUU.seed(name: "TryFeatureKitButtonTapAction")
    }
    
    @IBAction func didTapTryAgainButton(_ sender: UIButton) {
        CUU.seed(name: "TryAgain")
    }
}

