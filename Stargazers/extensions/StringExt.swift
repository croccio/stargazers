//
//  StringExt.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
