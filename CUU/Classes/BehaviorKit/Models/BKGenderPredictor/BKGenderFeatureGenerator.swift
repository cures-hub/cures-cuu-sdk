class BKGenderFeatureGenerator {
    
    @available(iOS 11.0, *)
    @available(iOS 11.0, *)
    func features(completion: (GenderContextInput?)->Void ) {
        
        let lock = NSLock()
        var openTasks = 1
        
        let windowSize: TimeInterval = 20
        let stepSize: TimeInterval = 2
        let predicate = NSPredicate(format: "startDate > %@", Date(timeIntervalSinceNow: -windowSize) as CVarArg)
        
        
        var numberOfViewDidAppearEvents: Double = 0
        var numberOfViewDidDisappearEvents: Double = 0
        var numberOfFullScreenViewDidAppearEvents: Double = 0
        var numberOfFullScreenViewDidDisappearEvents: Double = 0
        var numberOfPresentedSubViews: Double = 0
        var averageTimeOnView: Double = 0
        var numberOfLoops: Double = 0
        var maxNumberOfViewControllerAppearances: Double = 0
        
        
        // ViewEvents
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
                    return completion(GenderContextInput(numberOfViewDidAppearEvents: numberOfViewDidAppearEvents,
                                                         numberOfViewDidDisappearEvents: numberOfViewDidDisappearEvents,
                                                         numberOfFullScreenViewDidAppearEvents: numberOfFullScreenViewDidAppearEvents,
                                                         numberOfFullScreenViewDidDisappearEvents: numberOfFullScreenViewDidDisappearEvents,
                                                         numberOfPresentedSubViews: numberOfPresentedSubViews,
                                                         averageTimeOnView: averageTimeOnView,
                                                         numberOfLoops: numberOfLoops,
                                                         maxNumberOfViewControllerAppearances: maxNumberOfViewControllerAppearances
                    ))
                }
                lock.unlock()
                
            }
        })

    }
    
    
}

