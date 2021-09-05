//
//  Stargazer.swift
//  github-service
//
//  Created by Antonio Scardigno on 02/09/21.
//

import UIKit
import RealmSwift

public class Stargazer: Object {
    
    @Persisted var primaryKey: String?
    
    @Persisted public var avatarUrl: String?
    @Persisted public var login: String?
    @Persisted var repo: Repo?
    
    public override init() {
        
    }
    
    public init(avatarUrl: String?, login: String?, repo: Repo?) {
        self.avatarUrl = avatarUrl
        self.login = login
        self.repo = repo
        self.primaryKey = "\(login ?? String())\(repo?.primaryKey ?? String())"
    }
    
    public override class func primaryKey() -> String? {
        return "primaryKey"
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        return object is Stargazer &&
            avatarUrl == (object as? Stargazer)?.avatarUrl
            && login == (object as? Stargazer)?.login
            && repo == (object as? Stargazer)?.repo
    }
    
}
