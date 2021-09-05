//
//  StargazerError.swift
//  github-service
//
//  Created by Antonio Scardigno on 03/09/21.
//

import UIKit

public struct GetStargazersError: Codable {

    public var message: String?
    public var documentation_url: String?
    
    init(message: String) {
        self.message = message
    }
    
}
