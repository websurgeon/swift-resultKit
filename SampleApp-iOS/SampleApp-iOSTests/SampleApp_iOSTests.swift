//
//  Copyright © 2018 Peter Barclay. All rights reserved.
//

import XCTest
import ResultKit
import SampleApp_iOS

let anyError = NSError(domain: "test.anyError", code: 123, userInfo: nil)

class SampleApp_iOSTests: XCTestCase {
    typealias TestResult = Result<String, NSError>
    
    func test_resolve_whenFailureResult_shouldThrowError()  {
        let exp = expectation(description: "wait for result")
        var capturedResult: TestResult!
        simulateAsyncFailureResult { result in
            capturedResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertThrowsError(try capturedResult.resolve())
    }
    
    func test_resolve_whenFailureResult_doCatchError()  {
        let expectedError = NSError(domain: "test.error", code: 666, userInfo: nil)
        let exp = expectation(description: "wait for result")
        var capturedResult: TestResult!
        simulateAsyncFailureResult(with: expectedError) { result in
            capturedResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        do {
            _ = try capturedResult.resolve()
            XCTFail("expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func test_resolve_whenSuccessResult_shouldReturnValue()  {
        let exp = expectation(description: "wait for result")
        var capturedResult: TestResult!
        simulateAsyncSuccessResult(with: "a value") { result in
            capturedResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(try? capturedResult.resolve(), "a value")
    }
    

    private func simulateAsyncFailureResult(with error: Error = anyError,
                                            callback: @escaping (TestResult) -> Void) {
        DispatchQueue.global().async {
            callback(TestResult.failure(error as NSError))
        }
    }
    
    private func simulateAsyncSuccessResult(with value: String,
                                            callback: @escaping (TestResult) -> Void) {
        DispatchQueue.global().async {
            callback(TestResult.success(value))
        }
    }
}
