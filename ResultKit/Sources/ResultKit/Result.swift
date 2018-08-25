//
//  Created by Peter Barclay. Copyright (c) 2018 . All rights reserved.
//

import Foundation

public enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}
