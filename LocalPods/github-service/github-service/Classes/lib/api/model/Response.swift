//
//  Response.swift
//  github-service
//
//  Created by Antonio Scardigno on 03/09/21.
//

import UIKit

public struct Response<SUCCESS, ERROR> {

    public var success: SUCCESS?
    public var error: ERROR?
    
    public func isSuccess() -> Bool {
        return success != nil
    }
    
}
