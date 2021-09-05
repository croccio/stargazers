//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift
import RxCocoa
import Network

public class GitHubRepositoryImpl: GitHubRepository {
    
    private let gitHubRestApi: GitHubApi
    private let gitHubStorage: GitHubStorage
    
    public init (gitHubRestApi: GitHubApi, gitHubStorage: GitHubStorage) {
        self.gitHubRestApi = gitHubRestApi
        self.gitHubStorage = gitHubStorage
    }
    
    public func getStargazers(owner: String, repo: String, page: Int, perPage: Int) -> Observable<Array<Stargazer>> {
        return gitHubRestApi
            .getStargazers(serviceConfig: GitHubApiConfig.StargazersService(owner: owner, repo: repo, perPage: perPage, page: page))
            .observe(on: MainScheduler.instance)
            .flatMap({ (stargazersApi: Array<StargazerApi>) -> Observable<Array<Stargazer>> in
                let localStargazers = stargazersApi.map { stargazerApi in
                    return Stargazer(avatarUrl: stargazerApi.avatar_url, login: stargazerApi.login, repo: Repo(owner: owner, repo: repo))
                }
                
                return self.gitHubStorage.addStargazers(stargazers: localStargazers)
            })
            .catch { error in
                
                if (isOfflineError(error: error)) {
                    return self.gitHubStorage.getStargazers(repo: Repo(owner: owner, repo: repo), page: page, perPage: perPage)
                } else {
                    throw error
                }
            }
        
    }
    

}
