public struct Revenue {
    public var type: String
    public var amount: String
    public var description: String?
    
    public init(type: String, amount: String, description: String?) {
        self.type = type
        self.amount = amount
        self.description = description
    }
    
    public func getCurrency() -> String {
        CoreEnvironment.shared.environment.currencyCode
    }
}

public struct RevenueCustom {
    public var name: String
    public var amountValue: Double
    public var tagAmount: String
    public var extraProperties: [String: Any]
    public var currencyCode: String = CoreEnvironment.shared.environment.currencyCode
    
    public init(name: String,
                tagAmount: String,
                amountValue: Double,
                extraProperties: [String: Any] = [:],
                currencyCode: String = CoreEnvironment.shared.environment.currencyCode) {
        self.name = name
        self.amountValue = amountValue
        self.tagAmount = tagAmount
        self.extraProperties = extraProperties
    }
}

public struct Attribute {
    public var name: String
    public var value: Any

    public init(key: String, value: Any) {
        name = key
        self.value = value
    }
}

public struct Event {
    public var name: String
    public var type: String?
    public var id: String?
    public var screen: String?
    public var customAtributes = [String: Any]()
    
    public init(name: String,
         type: String?,
         id: String?,
         screen: String?,
         customAtributes: [String: Any] = [String: Any]()) {
        
        self.id = id
        self.type = type
        self.name = name
        self.screen = screen
        self.customAtributes = customAtributes
    }
    
    public init(name: String) {
        self.name = name
    }
}

extension Event {
    public func params() -> [String: Any] {
        var attributes = [String: Any]()
        
        if let screen = screen {
            attributes["screen"] = screen
        }
        
        if let type = type {
            attributes["categoria"] = type
        }
        
        if let id = id {
            attributes["event_id"] = id
        }
        
        customAtributes.forEach { attributes[$0.key] = $0.value }
        
        return attributes
    }
}
