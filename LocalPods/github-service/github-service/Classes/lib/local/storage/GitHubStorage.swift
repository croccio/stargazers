//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift
import RxCocoa

public protocol GitHubStorage {
    
    func getStargazers(repo: Repo, page: Int, perPage: Int) -> Observable<Array<Stargazer>>
    
    func addStargazer(stargazer: Stargazer) -> Observable<Stargazer>
    
    func addStargazers(stargazers: Array<Stargazer>) -> Observable<Array<Stargazer>>

}
