//
//  CUUViewControllers.swift
//  CUU
//
//  Created by Lara Marie Reimer on 07.07.18.
//

import UIKit

// MARK: - CUUViewController

open class CUUViewController: UIViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUTableViewController

open class CUUTableViewController: UITableViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUCollectionViewController

open class CUUCollectionViewController: UICollectionViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUPageViewController

open class CUUPageViewController: UIPageViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUSplitViewController

open class CUUSplitViewController: UISplitViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUNavigationController

open class CUUNavigationController: UINavigationController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUTabBarController

open class CUUTabBarController: UITabBarController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUSearchContainerViewController

open class CUUSearchContainerViewController: UISearchContainerViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUSearchController

open class CUUSearchController: UISearchController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUImagePickerController

open class CUUImagePickerController: UIImagePickerController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUVideoEditorController

open class CUUVideoEditorController: UIVideoEditorController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUDocumentBrowserViewController

@available(iOS 11.0, *)
open class CUUDocumentBrowserViewController: UIDocumentBrowserViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUDocumentPickerViewController

open class CUUDocumentPickerViewController: UIDocumentPickerViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUCloudSharingController

open class CUUCloudSharingController: UICloudSharingController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUActivityViewController

open class CUUActivityViewController: UIActivityViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}

// MARK: - CUUReferenceLibraryViewController

open class CUUReferenceLibraryViewController: UIReferenceLibraryViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}
