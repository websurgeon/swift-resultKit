//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation

extension Result {
    public func resolve() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
