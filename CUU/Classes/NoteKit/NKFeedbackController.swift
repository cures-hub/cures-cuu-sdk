//
//  NoteKitViewController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 22.09.18.
//

import Foundation

class NKFeedbackController {
    
    static func promptForFeedback() {
        let alertVC = UIAlertController(title: "You have Feedback?", message: "Give us a brief description!\nExample: “Button font too small”.", preferredStyle: .alert)
        alertVC.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alertVC] _ in
            guard let textFields = alertVC.textFields else { return }
            
            if textFields.count > 0 {
                let answer = textFields[0].text
                
                if let answer = answer {
                    // Send answer
                    let feedback = NKDefaultFeedback(content: answer)
                    feedback.send()
                }
            }
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(submitAction)
        
        guard let currentVC = CUUUtils.getTopViewController() else { return }
        currentVC.present(alertVC, animated: true)
    }
}
