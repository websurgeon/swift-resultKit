//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import XCTest
import ResultKit

class Result_Equatable: XCTestCase {

    func test_whenNotSameValue_shouldNotBeEqual() {
        let lhs = makeSuccessResult("a value")
        let rhs = makeSuccessResult("another value")

        XCTAssertNotEqual(lhs, rhs)
    }

    func test_whenSameValue_shouldBeEqual() {
        let lhs = makeSuccessResult("a value")
        let rhs = makeSuccessResult("a value")
        
        XCTAssertEqual(lhs, rhs)
    }

    func test_whenNotSameError_shouldNotBeEqual() {
        let lhs = makeFailureResult(StubError("an error"))
        let rhs = makeFailureResult(StubError("another error"))
        
        XCTAssertNotEqual(lhs, rhs)
    }

    func test_whenSameError_shouldBeEqual() {
        let lhs = makeFailureResult()
        let rhs = makeFailureResult()

        XCTAssertEqual(lhs, rhs)
    }

    func test_whenSuccessAndFailure_shouldNotBeEqual() {
        let lhs = makeSuccessResult("any value")
        let rhs = makeFailureResult()
        
        XCTAssertNotEqual(lhs, rhs)
    }
    
    func test_whenFailureAndSuccess_shouldNotBeEqual() {
        let lhs = makeFailureResult()
        let rhs = makeSuccessResult("any value")
        
        XCTAssertNotEqual(lhs, rhs)
    }

}
