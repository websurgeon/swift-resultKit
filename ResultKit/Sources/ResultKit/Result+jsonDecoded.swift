//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation

extension Result where Value == Data {
    public func jsonDecoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }
}
