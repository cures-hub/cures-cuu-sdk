//
//  InteractionKit.swift
//  InteractionKit
//
//  Created by Lara Marie Reimer on 26/08/2017.
//  Copyright © 2018 CURES. All rights reserved.
//

import UIKit

/**
 *  The class to handle the initialization and lifecycle of InteractionKit.
 **/
public class InteractionKit {
    
    static public let shared = InteractionKit()
    
    private(set) var isActive: Bool = false
    private(set) var configuration: IKConfiguration?
    
    public func configure(with configuration: IKConfiguration) {
        let shouldRestart = isActive
        stop()
        
        self.configuration = configuration
        
        if shouldRestart {
            start()
        }
    }
    
    
    public func start() {
        guard !isActive else { return }
        
        guard let configuration = configuration else {
            return
        }
        
        for interceptor in configuration.interceptors {
            interceptor.start()
        }
        
        isActive = true
    }
    
    public func stop() {
        guard isActive else { return }
        
        guard let configuration = configuration else {
            return
        }
        
        
        for interceptor in configuration.interceptors {
            
            interceptor.stop()
        }
        
        isActive = false
    }
    
    public func fetch<T: IKCharacteristics>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKCharacteristics>)->Void) {
        
        if let storage = configuration?.storage {
            storage.fetch(type, predicate: predicate, completion: completion)
        } else{
            completion([])
        }
    }
    
    public func fetch<T: IKInteraction>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKInteraction>)->Void) {
        
        if let storage = configuration?.storage {
            storage.fetch(type, predicate: predicate, completion: completion)
        } else{
            completion([])
        }
    }
}

extension InteractionKit: IKInterceptionDelegate {
    
    public func interceptor(_ interceptor: IKInterceptor, captured dataObject: IKCharacteristics, crumb: IKInteraction)  {
        configuration?.storage.commit(dataObject, completion: nil)
        configuration?.storage.commit(crumb, completion: nil)
    }
}

extension InteractionKit {
    public static func event(_ title: String, parameter: [String:String]? = nil) {
        IKEventInterceptor.log(title: title, parameter: parameter)
    }
}
