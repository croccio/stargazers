//
//  SearchStargazersPresenter.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import UIKit
import MVP
import github_service
import RxSwift

class SearchStargazersError: Error {
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
}

class SearchStargazersPresenter: BasePresenter<SearchStargazersViewModel> {
    
    private var getStargazerPage = 1
    
    public func fetchStargazers(refresh: Bool? = false) -> Disposable? {
        
        if (viewModel?.loading.value == true) {
            return nil
        }
        
        guard let owner = viewModel?.owner.value else {
            viewModel?.error?(SearchStargazersError(message: "Insert owner"))
            return nil
        }
        
        guard let repository = viewModel?.repository.value else {
            viewModel?.error?(SearchStargazersError(message: "Insert repository"))
            return nil
        }
        
        if (refresh == true) {
            getStargazerPage = 1
            self.viewModel?.stargazers.accept([])
        }
        
        viewModel?.loading.accept(true)
        
        return gitHubRepository
            .getStargazers(owner: owner, repo: repository, page: getStargazerPage, perPage: PAGINATION)
            .subscribe { newStargazers in
                var stargazers = self.viewModel?.stargazers.value ?? []
                stargazers.append(contentsOf: newStargazers)
                self.viewModel?.stargazers.accept(stargazers)
                
                if (newStargazers.count > 0 && newStargazers.count <= PAGINATION) {
                    self.getStargazerPage += 1
                }
                
                self.viewModel?.loading.accept(false)
                
            } onError: { error in
                self.viewModel?.stargazers.accept([])
                self.viewModel?.error?(error)
                self.viewModel?.loading.accept(false)
            }

        
    }

}
