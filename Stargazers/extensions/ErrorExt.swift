//
//  ErrorExt.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import Foundation
import github_service

extension Error {
    
    func errorMessage() -> String {
        
        let defaulMessage = "error_general_message".localized()
        
        if let error = self as? GetStargazersException {
            return error.getStargazersError?.message ?? defaulMessage
        } else if let _ = self as? StargazerNotSavedException {
            return "error_stargazer_not_saved_exception".localized()
        } else if let _ = self as? NotCachedStargazerException {
            return "error_stargazer_not_cached_exception".localized()
        } else if let error = self as? SearchStargazersError {
            return error.message
        } else {
            return localizedDescription
        }
        
    }
    
}
