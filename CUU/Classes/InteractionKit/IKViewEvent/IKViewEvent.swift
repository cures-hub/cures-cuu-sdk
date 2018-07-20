/**
 *  Protocol for view events.
 **/
public protocol IKViewEvent: IKDataObject {
    
    /**
     *   The type of the view event.
     **/
    var type: String { set get }
    
    /**
     *   The title of the view controller.
     **/
    var viewControllerTitle: String { set get }
    
    /**
     *   The type of the view controller.
     **/
    var viewControllerType: String { set get }
    
    /**
     *   The specific instance of the view controller.
     **/
    var viewControllerInstance: String { set get }
    
    /**
     *   The width of the view.
     **/
    var viewWidth: Double { set get }
    
    /**
     *   The height of the view.
     **/
    var viewHeight: Double { set get }
    
    /**
     *   The origin x value of the view.
     **/
    var viewOriginX: Double { set get }
    
    /**
     *   The origin y value of the view.
     **/
    var viewOriginY: Double { set get }
    
    /**
     *   The global origin x value of the view.
     **/
    var globalViewOriginX: Double { set get }
    
    /**
     *   The global origin x value of the view.
     **/
    var globalViewOriginY: Double { set get }
    
    /**
     *   The amount of subviews.
     **/
    var subviewCount: Int { set get }
}
