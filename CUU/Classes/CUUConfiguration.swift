//
//  CUUConfiguration.swift
//  CUU
//
//  Created by Lara Marie Reimer on 04.02.18.
//

/**
 *  Class for defining a configuration for InteractionKit within CUU.
 **/
public class CUUConfiguration {
    
    public var interactionKitConfiguration: IKConfiguration {
        return IKDefaultConfiguration(forUser: CUUUserManager.sharedManager.userId)
    }
    
    /**
     * The configuration for BehaviorKit.
     */
    var behaviorKitConfiguration: BKConfiguration {
        return BKDefaultConfiguration(forUser: CUUUserManager.sharedManager.userId)
    }
    
    /**
     * The configuration for PersonaKit.
     */
    var personaKitConfiguration: PKConfiguration {
        return PKDefaultConfiguration()
    }
}

