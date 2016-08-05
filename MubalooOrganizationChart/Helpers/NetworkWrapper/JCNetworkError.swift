//
//  Created by João Carreira on 24/01/16.
//  Copyright © 2016 jpcarreira. All rights reserved.
//

import Foundation

struct JCNetworkError {
    
    let errorCode: Int
    let errorDetails: Dictionary<NSObject, AnyObject>?
}

enum JCNetworkErrorCode: Int {
    
    case Unauthorized = 401
    case NotFound = 404
    case InternalServerError = 500
    case Other = 0
    case NoResponse = -1
}
