//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation

extension Result: Equatable where Value:Equatable, Error: Equatable {
    public static func ==(lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.success(let valueA), .success(let valueB)):
            return valueA == valueB
        case (.failure(let errorA), .failure(let errorB)):
            return errorA == errorB
        case (.success, .failure):
            return false
        case (.failure, .success):
            return false
        }
    }
}
