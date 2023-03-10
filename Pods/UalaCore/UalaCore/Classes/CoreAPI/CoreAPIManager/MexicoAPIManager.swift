import Foundation

struct MexicoAPIManager: APIManager {
  
    public init() { }
    public var card: CardRouteable = MexCardRouter()
    public var regions: RegionsRouteable = RegionRouter()
    public var account: AccountRouteable = MexicoAccountRouter()
    public var virtualKey: VirtualKeyRouteable = VirtualKeyRouter()
    public var acquiringAccount: AcquiringAccountRoutable = AcquiringAccountRouter()
    var updateProfileMFA: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}
