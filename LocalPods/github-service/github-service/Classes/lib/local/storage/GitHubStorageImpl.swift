//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

public class GitHubStorageImpl: GitHubStorage {
    
    let localStorage = try! Realm()
    
    public init() { }
    
    public func getStargazers(repo: Repo, page: Int, perPage: Int) -> Observable<Array<Stargazer>> {
        
        let stargazers = Array(localStorage.objects(Stargazer.self).filter { stargazer in
            stargazer.repo?.repo == repo.repo
        })
        
        let startIndex = (page - 1) * perPage
        var endIndex = perPage * page
        
        if (endIndex > stargazers.count) {
            endIndex = stargazers.count
        }
        
        return Observable.just(Array(stargazers[startIndex..<endIndex]))
        
    }
    
    public func addStargazer(stargazer: Stargazer) -> Observable<Stargazer> {
        
        do {
            try localStorage.write {
                localStorage.add(stargazer, update: .modified)
            }
        }catch {
            return Observable.error(StargazerNotSavedException())
        }
        
        if let stargazerAdded = localStorage.objects(Stargazer.self).first(where: { strg in
            strg.primaryKey == stargazer.primaryKey
        }) {
            return Observable.just(stargazerAdded)
        }
        
        return Observable.error(StargazerNotSavedException())
        
    }
    
    public func addStargazers(stargazers: Array<Stargazer>) -> Observable<Array<Stargazer>> {
        do {
            try localStorage.write {
                localStorage.add(stargazers, update: .modified)
            }
        }catch {
            return Observable.error(StargazerNotSavedException())
        }
        
        return Observable.just(stargazers)
    }

}
