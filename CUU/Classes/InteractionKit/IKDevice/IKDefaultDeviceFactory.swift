class IKDefaultDeviceFactory: IKDeviceFactory {
    
    func device() -> IKDevice {
        let device = IKDefaultDevice()
        return populate(device)
    }
    
}

