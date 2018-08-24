//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation
import XCTest
import ResultKit

class ResultKitTests: XCTestCase {

    func test_something() {
        let sut = TemplateValue()
        
        XCTAssertEqual(sut.hello, "world")
    }

}
