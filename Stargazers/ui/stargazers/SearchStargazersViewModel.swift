//
//  SearchStargazersViewModel.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import UIKit
import RxSwift
import RxCocoa
import MVP
import github_service

class SearchStargazersViewModel: NSObject, ViewModelProtocol {
    
    var error: ((Error) -> Void)?
    
    var loading = BehaviorRelay<Bool>(value: false)
    var owner = BehaviorRelay<String?>(value: "croccio")
    var repository = BehaviorRelay<String?>(value: "Android-Auto-Store")
    var stargazers = BehaviorRelay<Array<Stargazer>>(value: [])
    
    required override init() { }
    
}
