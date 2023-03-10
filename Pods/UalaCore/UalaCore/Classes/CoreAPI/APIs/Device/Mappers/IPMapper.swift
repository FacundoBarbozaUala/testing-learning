import Foundation

struct IPMapper: MappeableType {
    
    struct Result: Decodable {
        // swiftlint:disable next identifier_name
        var country_code: String
    }

    func map<T>(_ data: Data) -> T? {
        guard let code =  decode(data)?.country_code else { return nil }
        return CountryCode(rawValue: code) as? T
    }
}
