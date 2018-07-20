//
//  CUUViewControllers.swift
//  CUU
//
//  Created by Lara Marie Reimer on 07.07.18.
//

import UIKit

// MARK: - CUUViewController

open class CUUViewController: UIViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUTableViewController

open class CUUTableViewController: UITableViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUCollectionViewController

open class CUUCollectionViewController: UICollectionViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUPageViewController

open class CUUPageViewController: UIPageViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUSplitViewController

open class CUUSplitViewController: UISplitViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUNavigationwController

open class CUUNavigationwController: UINavigationController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUTabBarController

open class CUUTabBarController: UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUSearchContainerViewController

open class CUUSearchContainerViewController: UISearchContainerViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUSearchController

open class CUUSearchController: UISearchController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUImagePickerController

open class CUUImagePickerController: UIImagePickerController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUVideoEditorController

open class CUUVideoEditorController: UIVideoEditorController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUDocumentBrowserViewController

@available(iOS 11.0, *)
open class CUUDocumentBrowserViewController: UIDocumentBrowserViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUDocumentPickerViewController

open class CUUDocumentPickerViewController: UIDocumentPickerViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUCloudSharingController

open class CUUCloudSharingController: UICloudSharingController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUActivityViewController

open class CUUActivityViewController: UIActivityViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}

// MARK: - CUUReferenceLibraryViewController

open class CUUReferenceLibraryViewController: UIReferenceLibraryViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
}
