class BKSmartphoneExperienceFeatureGenerator {
    
    @available(iOS 11.0, *)
    @available(iOS 11.0, *)
    @available(iOS 11.0, *)
    func features(completion: (SmartphoneExperienceContextInput?)->Void ) {
        
        let lock = NSLock()
        var openTasks = 2
        
        let windowSize: TimeInterval = 30
        let stepSize: TimeInterval = 1
        let predicate = NSPredicate(format: "startDate > %@", Date(timeIntervalSinceNow: -windowSize) as CVarArg)
        
        
        var numberOfViewDidAppearEvents: Double = 0
        var numberOfViewDidDisappearEvents: Double = 0
        var numberOfFullScreenViewDidAppearEvents: Double = 0
        var numberOfFullScreenViewDidDisappearEvents: Double = 0
        var numberOfPresentedSubViews: Double = 0
        var averageTimeOnView: Double = 0
        var numberOfLoops: Double = 0
        var maxNumberOfViewControllerAppearances: Double = 0
        
        var numberOfTouchEvents: Double = 0
        var numberOfTouchesBegan: Double = 0
        var numberOfTouchesMoved: Double = 0
        var averageTouchForce: Double = 0
        var maxTouchForce: Double = 0
        var touchForceVariance: Double = 0
        
        // UKTouches
        InteractionKit.shared.fetch(IKTouchCharacteristics.self, predicate: predicate, completion: { results in
            
            if let touches = results as? Array<IKTouchCharacteristics> {
                
                var touchForces: [Double] = []
                
                for touch in touches {
                    numberOfTouchEvents += 1
                    touchForces.append(touch.force)
                    if touch.title == "touchBegan" {
                        numberOfTouchesBegan += 1
                    } else if touch.title == "touchesMoved" {
                        numberOfTouchesMoved += 1
                    }
                }
                
                averageTouchForce = Sigma.average(touchForces) ?? 0
                maxTouchForce = Sigma.max(touchForces) ?? 0
                touchForceVariance =  Sigma.varianceSample(touchForces) ?? 0
                
                lock.lock()
                openTasks -= 1
                if openTasks == 0 {
                    return completion(
                        SmartphoneExperienceContextInput(
                            numberOfFullScreenViewDidDisappearEvents: numberOfFullScreenViewDidDisappearEvents,
                            numberOfTouchesBegan: numberOfTouchesBegan,
                            averageTouchForce: averageTouchForce,
                            numberOfFullScreenViewDidAppearEvents: numberOfFullScreenViewDidAppearEvents,
                            numberOfPresentedSubViews: numberOfPresentedSubViews,
                            numberOfTouchEvents: numberOfTouchEvents,
                            numberOfTouchesMoved: numberOfTouchesMoved,
                            averageTimeOnView: averageTimeOnView,
                            numberOfViewDidAppearEvents: numberOfViewDidAppearEvents,
                            numberOfLoops: numberOfLoops,
                            maxNumberOfViewControllerAppearances: maxNumberOfViewControllerAppearances,
                            numberOfViewDidDisappearEvents: numberOfViewDidDisappearEvents,
                            maxTouchForce: maxTouchForce,
                            touchForceVariance: touchForceVariance
                        )
                    )
                }
                lock.unlock()
                
            }
        })
        
        
        // UKViewEvents
        InteractionKit.shared.fetch(IKViewEventCharacteristics.self, predicate: predicate, completion: { results in
            
            if let events = results as? Array<IKViewEventCharacteristics> {
                
                var appearancesPerViewController: [String: Int] = [:]
                
                for event in events {
                    if event.title == "didAppear" {
                        numberOfViewDidAppearEvents += 1
                        
                        if event.viewHeight > 500 && event.viewWidth >= 375 {
                            numberOfFullScreenViewDidAppearEvents += 1
                        }
                        
                        numberOfPresentedSubViews += Double(event.subviewCount)
                        appearancesPerViewController[event.type] = (appearancesPerViewController[event.type] ?? 0) + 1
                    } else if event.title == "didDisappear" {
                        numberOfViewDidDisappearEvents += 1
                        if event.viewHeight > 500 && event.viewWidth >= 375 {
                            numberOfFullScreenViewDidDisappearEvents += 1
                        }
                    }
                }
                
                averageTimeOnView = windowSize * stepSize * 1000.0 / (numberOfFullScreenViewDidAppearEvents + 1)
                numberOfLoops = 0
                maxNumberOfViewControllerAppearances = 0
                for (_, value) in appearancesPerViewController {
                    if value > 1 {
                        numberOfLoops += 1
                        maxNumberOfViewControllerAppearances = maxNumberOfViewControllerAppearances > Double(value) ? maxNumberOfViewControllerAppearances : Double(value)
                    }
                }
                
                lock.lock()
                openTasks -= 1
                if openTasks == 0 {
                    return completion(
                        SmartphoneExperienceContextInput(
                            numberOfFullScreenViewDidDisappearEvents: numberOfFullScreenViewDidDisappearEvents,
                            numberOfTouchesBegan: numberOfTouchesBegan,
                            averageTouchForce: averageTouchForce,
                            numberOfFullScreenViewDidAppearEvents: numberOfFullScreenViewDidAppearEvents,
                            numberOfPresentedSubViews: numberOfPresentedSubViews,
                            numberOfTouchEvents: numberOfTouchEvents,
                            numberOfTouchesMoved: numberOfTouchesMoved,
                            averageTimeOnView: averageTimeOnView,
                            numberOfViewDidAppearEvents: numberOfViewDidAppearEvents,
                            numberOfLoops: numberOfLoops,
                            maxNumberOfViewControllerAppearances: maxNumberOfViewControllerAppearances,
                            numberOfViewDidDisappearEvents: numberOfViewDidDisappearEvents,
                            maxTouchForce: maxTouchForce,
                            touchForceVariance: touchForceVariance
                        )
                    )
                }
                lock.unlock()
            }
        })
        
    }
    
    
}

