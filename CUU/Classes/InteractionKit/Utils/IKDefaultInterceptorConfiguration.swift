//
//  InteractionKitConfiguration.swift
//  CUU
//
//  Created by Lara Marie Reimer on 04.02.18.
//

import Foundation

public class IKDefaultInterceptorConfiguration {
    public static func provideDefaultInterceptors() -> [IKInterceptor] {
        let appDelegate = UIApplication.shared.delegate as! IKAppDelegate
        
        var interceptors: [IKInterceptor] = []
        
        interceptors.append(IKEventInterceptor(interceptionDelegate: InteractionKit.shared, eventFactory: IKDefaultEventFactory()))
        
        interceptors.append(IKViewEventInterceptor(interceptionDelegate: InteractionKit.shared, viewEventFactory: IKDefaultViewEventFactory()))
        
        interceptors.append(IKAppEventInterceptor(interceptionDelegate: InteractionKit.shared, appEventFactory: IKDefaultAppEventFactory()))
        
        interceptors.append(IKDeviceInterceptor(interceptionDelegate: InteractionKit.shared, deviceFactory: IKDefaultDeviceFactory()))
        
        interceptors.append(IKTouchInterceptor(window: appDelegate.window!, interceptionDelegate: InteractionKit.shared, touchFactory: IKDefaultTouchFactory()))
        
        interceptors.append(IKGestureInterceptor(window: appDelegate.window!, interceptionDelegate: InteractionKit.shared, gestureFactory: IKDefaultGestureFactory(), gestureTypes: IKGestureType.all))
        
        interceptors.append(IKMotionInterceptor(interceptionDelegate: InteractionKit.shared, motionFactory: IKDefaultMotionFactory()))
        
        interceptors.append(IKSensorInterceptor(interceptionDelegate: InteractionKit.shared, sensorFactory: IKDefaultSensorFactory(), sensorTypes: IKSensorType.all))
        
        
        return interceptors
    }
}
