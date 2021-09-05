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

class GitHubStorageTests: XCTestCase {
    
    let gitHubStorage: GitHubStorage = GitHubStorageImpl()
    
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        
        let _ = gitHubStorage.addStargazers(stargazers:
            (0...3).map({ index in
                Stargazer(avatarUrl: "url\(index)", login: "login\(index)", repo: Repo(owner: "owner\(index % 2)", repo: "repo\(index % 2)"))
            }))
            .toBlocking()
    }
    
    func test_getStargazers_perPageParam() {
        
        let owner = "owner0"
        let repo = "repo0"
        let perPage = 3
        let page = 1
        
        let stargazers = try! gitHubStorage
            .getStargazers(repo: Repo(owner: owner, repo: repo), page: page, perPage: perPage)
            .toBlocking()
            .first()
        
        assert(stargazers?.count == perPage, "perPage doesn't work correctly")
        
        
    }
    
    func test_getStargazers_pageParam() {
        
        let owner = "owner0"
        let repo = "repo0"
        let perPage = 3
        
        var page = 1
        
        let stargazersPage1 = try? gitHubStorage
            .getStargazers(repo: Repo(owner: owner, repo: repo), page: page, perPage: perPage)
            .toBlocking()
            .first()
        
        page = 2
        
        let stargazersPage2 = try? gitHubStorage
            .getStargazers(repo: Repo(owner: owner, repo: repo), page: page, perPage: perPage)
            .toBlocking()
            .first()
        
        assert(stargazersPage1 != stargazersPage2, "page queryParams doesn't work correctly")
        assert(stargazersPage1?.count == 3, "page queryParams doesn't work correctly (Page 1)")
        assert(stargazersPage2?.count == 4, "page queryParams doesn't work correctly (Page 2)")
        
    }
    
    func test_addStargazer_single() {
        let owner = "owner0"
        let repo = "repo0"
        let avatarUrl = "avatarUrl"
        let login = "login"
        
        let stargazerToAdd = Stargazer(avatarUrl: avatarUrl, login: login, repo: Repo(owner: owner, repo: repo))
        
        let addedStargazer = try? gitHubStorage
            .addStargazer(stargazer: Stargazer(avatarUrl: avatarUrl, login: login, repo: Repo(owner: owner, repo: repo)))
            .toBlocking()
            .first()
        
        assert(addedStargazer == stargazerToAdd, "Stargazer didn't add correctly")
        
    }
    
    func test_addStargazer_multiple() {
        
        let stargazerToAdd = (0...5).map({ index in
                                Stargazer(avatarUrl: "url\(index)", login: "login\(index)", repo: Repo(owner: "owner\(index % 2)", repo: "repo\(index % 2)"))
                            })
        
        let addedStargazer = try? gitHubStorage
            .addStargazers(stargazers: stargazerToAdd)
            .toBlocking()
            .first()
        
        assert(addedStargazer == stargazerToAdd, "Stargazer didn't add correctly")
        
    }

}
