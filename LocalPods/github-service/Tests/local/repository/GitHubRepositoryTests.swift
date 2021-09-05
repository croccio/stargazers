//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation

import RxSwift
import RxBlocking

import RealmSwift
import StatusCodes

import XCTest
@testable import github_service

class GitHubRepositoryTests: XCTestCase {
    
    let gitHubRepository: GitHubRepository = GitHubRepositoryImpl(gitHubRestApi: GitHubApiImpl(), gitHubStorage: GitHubStorageImpl())
    
    
    func test_getStargazers() {
        
        let owner = "croccio"
        let repo = "Android-Auto-Store"
        let perPage = 3
        let page = 1
        
        let stargazers = try! gitHubRepository
            .getStargazers(owner: owner, repo: repo, page: page, perPage: perPage)
            .toBlocking()
            .first()
        
        assert(stargazers?.count ?? 0 > 0, "getStargazer doesn't work")
        
    }
    

}
