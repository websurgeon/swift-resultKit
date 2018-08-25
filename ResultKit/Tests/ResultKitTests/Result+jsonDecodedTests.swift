//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import XCTest
import ResultKit

class Result_jsonDecoded: XCTestCase {
    
    func test_whenFailureResult_shouldThrowError() {
        let expectedError = NSError(domain: "test.error", code: 123, userInfo: nil)
        let sut = Result<Data, NSError>.failure(expectedError)
        
        do {
            let decoded: DecodableTestValue = try sut.jsonDecoded()
            XCTFail("expected failure, got decoded value \(decoded)")
        } catch let error as NSError {
            XCTAssertEqual(error, expectedError)
        }
    }
    
    func test_whenSuccessResult_shouldReturnDecodedValue() {
        let expectedValue = DecodableTestValue("a message")
        let encodedValue = jsonEncodeTestValue(expectedValue)
        let sut = Result<Data, NSError>.success(encodedValue)
        
        do {
            let decoded: DecodableTestValue = try sut.jsonDecoded()
            
            XCTAssertEqual(decoded, expectedValue)
        } catch {
            XCTFail("expected decoded value \(expectedValue), got error \(error)")
        }
    }
    
}

private func jsonEncodeTestValue(_ value: DecodableTestValue) -> Data {
    return try! JSONEncoder().encode(value)
}

private struct DecodableTestValue: Decodable, Encodable, Equatable {
    let value: String
    init(_ value: String) {
        self.value = value
    }
}
