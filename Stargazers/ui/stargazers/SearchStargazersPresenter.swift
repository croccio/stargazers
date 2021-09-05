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
    private let disposeBag = DisposeBag()
    
    required init(viewModel: SearchStargazersViewModel?) {
        super.init(viewModel: viewModel)
        
        guard let viewModel = viewModel else { return }
        
        Observable.combineLatest(
            viewModel.owner.distinctUntilChanged(),
            viewModel.repository.distinctUntilChanged()
        )
        .subscribe { _ in
            viewModel.stargazers.accept([])
        }.disposed(by: disposeBag)
    }
    
    public func fetchStargazers(refresh: Bool? = false) -> Disposable? {
        
        if (viewModel?.loading.value == true) {
            return nil
        }
        
        guard let owner = viewModel?.owner.value, owner.count > 0 else {
            viewModel?.error?(SearchStargazersError(message: "error_insert_owner"))
            return nil
        }
        
        guard let repository = viewModel?.repository.value, repository.count > 0 else {
            viewModel?.error?(SearchStargazersError(message: "error_inser_repository"))
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
