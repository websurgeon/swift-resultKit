//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import XCTest
import ResultKit

class Result_jsonEncoded: XCTestCase {
    
    func test_whenFailureResult_shouldThrowError() {
        let expectedError = NSError(domain: "test.error", code: 123, userInfo: nil)
        let sut = Result<EncodableTestValue, NSError>.failure(expectedError)
        
        do {
            let encodedData = try sut.jsonEncoded()
            XCTFail("expected failure, got encoded data \(encodedData)")
        } catch let error as NSError {
            XCTAssertEqual(error, expectedError)
        }
    }

    func test_whenSuccessResult_shouldReturnEncodedValue() {
        let value = EncodableTestValue("a message")
        let sut = Result<EncodableTestValue, NSError>.success(value)
        
        do {
            let encodedData = try sut.jsonEncoded()

            XCTAssertEqual(encodedData, expectedEncodedData(for: value))
        } catch {
            XCTFail("expected encoded data, got error \(error)")
        }
    }

}

private func expectedEncodedData(for value: EncodableTestValue) -> Data {
    return try! JSONEncoder().encode(value)
}

private struct EncodableTestValue: Encodable {
    let value: String
    init(_ value: String) {
        self.value = value
    }
}
