//
//  Stargazer.swift
//  github-service
//
//  Created by Antonio Scardigno on 02/09/21.
//

import UIKit
import RealmSwift

public class Repo: Object {

    @Persisted var primaryKey: String?
    
    @Persisted var owner: String?
    @Persisted var repo: String?
    
    public override init() {
        
    }
    
    public init(owner: String?, repo: String?) {
        super.init()
        self.repo = repo
        self.owner = owner
        self.primaryKey = "\(owner ?? "")\(repo ?? "")"
    }
    
    public override class func primaryKey() -> String? {
        return "primaryKey"
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        return object is Repo &&
            owner == (object as? Repo)?.owner
            && repo == (object as? Repo)?.repo
    }
    
}
