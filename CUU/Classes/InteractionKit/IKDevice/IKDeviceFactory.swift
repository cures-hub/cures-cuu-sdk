public protocol IKDeviceFactory {
    
    func device() -> IKDevice
    
}

extension IKDeviceFactory {
    
    public func populate(_ device: IKDevice) -> IKDevice {
        var device = device
        
        device.title = "IKDevice"
        device.commonDeviceName = UIDevice.current.localizedModel
        device.deviceModel = UIDevice.current.modelName
        device.deviceName = UIDevice.current.model
        device.systemName = UIDevice.current.systemName
        device.systemVersion = UIDevice.current.systemVersion
        device.screenSize =  screenSizeInInches()
        device.screenScale = Double(UIScreen.main.scale)
        device.screenWidth = Double(UIScreen.main.bounds.width)
        device.screenHeight = Double(UIScreen.main.bounds.height)
        device.screenNativeWidth = Double(UIScreen.main.nativeBounds.width)
        device.screenNativeHeight = Double(UIScreen.main.nativeBounds.height)
        if #available(iOS 11.0, *) {
            device.fontScale = Double(UIFontMetrics.default.scaledValue(for: 1))
        }
        
        return device
    }
    
    private func screenSizeInInches() -> Double {
        
        let height = UIScreen.main.bounds.height
        let scale = UIScreen.main.scale
        
        switch (height, scale) {
        case (480, _): return 3.5
        case (568, _): return 4.0
        case (667, 3.0), (736, _): return 5.5
        case (667, 1.0), (667, 2.0): return 4.7
        //            case (1024, _): return ipadSize1024()
        case (1112, _): return 10.5
        case (1366, _): return 12.9
        default: return 0
        }
    }

    func characteristics(from: IKDevice) -> IKDeviceCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKDeviceCharacteristics(context: context, device: from)
    }
    
    func crumb(with characteristics: IKDeviceCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKDevice",
                             characteristics: characteristics)
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return String(bytes: Data(bytes: &systemInfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
}

