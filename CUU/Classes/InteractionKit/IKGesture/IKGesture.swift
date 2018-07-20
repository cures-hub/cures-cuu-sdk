/**
 *  Protocol for gestures.
 **/
public protocol IKGesture: IKDataObject {
    
    /**
    *   The type of the gesture.
    **/
    var type: String { get set }

    /**
     *   The amount of touches.
     **/
    var touchCount: Int {set get}
    
    /**
     *   The location X value of the gesture.
     **/
    var locationX: Double { set get }
    
    /**
     *   The location Y value of the gesture.
     **/
    var locationY: Double { set get }

    /**
     *   The scale of the gesture.
     **/
    var scale: Double { set get }
    
    /**
     *   The scale velocity of the gesture.
     **/
    var scaleVelocity: Double { set get }
    
    /**
     *   The rotation of the gesture.
     **/
    var rotation: Double { set get }
    
    /**
     *   The rotation velocity of the gesture.
     **/
    var rotationVelocity: Double { set get }
    
    /**
     *   The direction of the gesture.
     **/
    var direction: String { set get }
    
    /**
     *   The translation X value of the gesture.
     **/
    var translationX: Double { set get }
    
    /**
     *   The translation Y value of the gesture.
     **/
    var translationY: Double { set get }
    
    /**
     *   The velocity X value of the gesture.
     **/
    var velocityX: Double { set get }
    
    /**
     *   The velocity Y value of the gesture.
     **/
    var velocityY: Double { set get }
    
}


