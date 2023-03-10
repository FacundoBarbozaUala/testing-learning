//
//  Async.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 07/07/22.
//

import Foundation

public extension Sequence {
    
    func asyncMap<T> (_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }
}
