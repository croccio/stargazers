//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift

class StargazersRepositoryImpl: StargazersApi {

    private let stargazersApi: StargazersApi
    
    init (stargazersApi: StargazersApi) {
        self.stargazersApi = stargazersApi
    }
    
    

}
