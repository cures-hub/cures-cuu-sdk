//
//  IKViewController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 04.03.18.
//

import UIKit

// MARK: - IKViewController

open class IKViewController: UIViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKTableViewController

open class IKTableViewController: UITableViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKCollectionViewController

open class IKCollectionViewController: UICollectionViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

open class IKPageViewController: UIPageViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKSplitViewController

open class IKSplitViewController: UISplitViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKNavigationwController

open class IKNavigationController: UINavigationController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKTabBarController

open class IKTabBarController: UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKSearchContainerViewController

open class IKSearchContainerViewController: UISearchContainerViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKSearchController

open class IKSearchController: UISearchController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKImagePickerController

open class IKImagePickerController: UIImagePickerController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKVideoEditerController

open class IKVideoEditerController: UIVideoEditorController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKDocumentBrowserViewController

@available(iOS 11.0, *)
open class IKDocumentBrowserViewController: UIDocumentBrowserViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKDocumentPickerViewController

open class IKDocumentPickerViewController: UIDocumentPickerViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKCloudSharingController

open class IKCloudSharingController: UICloudSharingController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKActivityViewController

open class IKActivityViewController: UIActivityViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - IKReferenceLibraryViewController

open class IKReferenceLibraryViewController: UIReferenceLibraryViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}
