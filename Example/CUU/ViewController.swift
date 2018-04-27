//
//  ViewController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12/30/2017.
//  Copyright (c) 2017 Lara Marie Reimer. All rights reserved.
//

import UIKit
import CUU

class ViewController: UIViewController {
    @IBAction func didTapTryFeatureKitButton(_ sender: UIButton) {
        FeatureKit.seed(name: "TryFeatureKitButtonTapAction")
    }
    
}

