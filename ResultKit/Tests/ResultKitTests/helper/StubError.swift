//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation

struct StubError: Error, Equatable {
    let message: String
    init(_ message: String = "test.error") {
        self.message = message
    }
}
