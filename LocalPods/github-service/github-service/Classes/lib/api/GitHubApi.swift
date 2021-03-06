//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift


public protocol GitHubApi {

    func getStargazers(serviceConfig: GitHubApiConfig.StargazersService) -> Observable<GetStargazersSuccess>
    
}
