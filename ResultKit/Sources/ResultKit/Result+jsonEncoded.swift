//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation

extension Result where Value: Encodable {
    public func jsonEncoded() throws -> Data {
        let encoder = JSONEncoder()
        let value = try resolve()
        return try encoder.encode(value)
    }
}
