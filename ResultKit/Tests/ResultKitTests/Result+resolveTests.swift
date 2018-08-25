//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import XCTest
import ResultKit

class Result_resolveTests: XCTestCase {

    func test_whenSuccess_shouldReturnSuccessValue() throws {
        let sut = makeSuccessResult("a value")
        
        XCTAssertEqual(try sut.resolve(), "a value")
    }
    
    func test_whenFailure_shouldThrowError() {
        let expectedError = StubError()
        let sut = makeFailureResult(expectedError)

        do {
            let value = try sut.resolve()
            XCTFail("expected error, got success value \(value)")
        } catch let error as StubError {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("expected \(expectedError), got \(error)")
        }
    }

}

