//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift
import RxCocoa

public protocol GitHubRepository {
    
    func getStargazers(owner: String, repo: String, page: Int, perPage: Int) -> Observable<Array<Stargazer>>

}
