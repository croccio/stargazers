//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift
import RxCocoa

class GetStargazersException: Error {
    
    let getStargazersError: GetStargazersError?
    
    init(getStargazersError: GetStargazersError) {
        self.getStargazersError = getStargazersError
    }
    
}
