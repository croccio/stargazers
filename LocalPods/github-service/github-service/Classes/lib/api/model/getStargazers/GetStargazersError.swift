//
//  StargazerError.swift
//  github-service
//
//  Created by Antonio Scardigno on 03/09/21.
//

import UIKit

struct GetStargazersError: Codable {

    var message: String?
    var documentation_url: String?
    
    init(message: String) {
        self.message = message
    }
    
}
