//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import XCTest
import Foundation
import ResultKit

extension XCTestCase {
    
    func makeFailureResult(_ error: StubError = StubError()) -> Result<String, StubError> {
        return .failure(error)
    }
    
}
