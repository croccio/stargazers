//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift

class GitHubRepositoryImpl: GitHubApi {

    private let gitHubApi: GitHubApi
    
    init (gitHubApi: GitHubApi) {
        self.gitHubApi = gitHubApi
    }
    
    

}
