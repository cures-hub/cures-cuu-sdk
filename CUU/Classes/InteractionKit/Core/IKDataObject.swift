import Foundation

/**
 *  Protocol for InteractionKit Data Objects.
 **/
public protocol IKDataObject: CustomStringConvertible {
    
    /**
    *   The current session ID.
    **/
    var _session: String { get set }
    
    /**
     *   The current user ID.
     **/
    var _user: String { get set }
    
    /**
     *   The start date of the interaction.
     **/
    var startDate: Date { get set }
    
    /**
     *   The end date of the interaction.
     **/
    var endDate: Date { get set }
    
    /**
     *   The title of the interaction.
     **/
    var title: String { get set }
    
    /**
     *   The description of the interaction.
     **/
    var description: String { get }
}

extension IKDataObject {
    
    public var description: String {
        return "InteractionKit fired :: \(title)"
    }
    
}

