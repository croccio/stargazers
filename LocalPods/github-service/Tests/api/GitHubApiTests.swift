//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation

import RxSwift
import RxBlocking

import StatusCodes

import XCTest
@testable import github_service

class GitHubApiTests: XCTestCase {
    
    let gitHubApi: GitHubApi = GitHubApiImpl()
    
    func test_getStargazers_perPageParam() {
        
        let owner = "croccio"
        let repo = "Android-Auto-Store"
        let perPage = 3
        let page = 1
        
        let stargazers = try? gitHubApi
            .getStargazers(serviceConfig: GitHubApiConfig.StargazersService(owner: owner, repo: repo, perPage: perPage, page: page))
            .toBlocking()
            .first()
        
        assert(stargazers?.count ?? 0 <= perPage, "perPage queryParams doesn't work correctly")
        
    }
    
    func test_getStargazers_pageParam() {
        
        let owner = "croccio"
        let repo = "Android-Auto-Store"
        let perPage = 3
        
        var page = 1
        
        let stargazersPage1 = try? gitHubApi
            .getStargazers(serviceConfig: GitHubApiConfig.StargazersService(owner: owner, repo: repo, perPage: perPage, page: page))
            .toBlocking()
            .first()
        
        page = 2
        
        let stargazersPage2 = try? gitHubApi
            .getStargazers(serviceConfig: GitHubApiConfig.StargazersService(owner: owner, repo: repo, perPage: perPage, page: page))
            .toBlocking()
            .first()
        
        assert(stargazersPage1 != stargazersPage2, "page queryParams doesn't work correctly")
        
    }
    
    func test_getStargazers_error() {
        
        let owner = "casualOwner"
        let repo = "fakeRepo"
        let perPage = 3
        let page = 1
        
        var stargazersError: Error?
        
        do {
            let _ = try gitHubApi
                .getStargazers(serviceConfig: GitHubApiConfig.StargazersService(owner: owner, repo: repo, perPage: perPage, page: page))
                .toBlocking()
                .first()
        } catch {
            stargazersError = error
        }
        
        assert(stargazersError != nil, "Error handling doesn't work correctly")
        
    }

}
