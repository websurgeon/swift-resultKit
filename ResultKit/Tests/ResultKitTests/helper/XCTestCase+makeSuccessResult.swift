//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import XCTest
import Foundation
import ResultKit

extension XCTestCase {

    func makeSuccessResult<T: Equatable>(_ value: T) -> Result<T, StubError> {
        return .success(value)
    }

}
