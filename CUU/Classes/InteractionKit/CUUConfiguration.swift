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

    public var personaKitConfiguration: IKConfiguration {
        return PKDefaultConfiguration()
    }
    
}

