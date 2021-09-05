//
//  SearchStargazersViewController.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 01/09/21.
//

import UIKit
import MVP
import RxCocoa
import RxSwift
import RxBiBinding
import RxBinding

class SearchStargazersViewController: MVPViewController<SearchStargazersViewModel, SearchStargazersPresenter> {

    @IBOutlet weak var ownerInputText: UITextField!
    @IBOutlet weak var repositoryInputText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stargazersTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindRxComponent()
        bindRxAction()
        bindRxTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.error = { [weak self] error in
            guard let self = self else { return }
            let alert =  UIAlertController(
                title: "alert_title_error".localized(),
                message: error.errorMessage(),
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    private func bindRxComponent() {
        
        (ownerInputText.rx.text <-> viewModel.owner).disposed(by: disposeBag)
        
        (repositoryInputText.rx.text <-> viewModel.repository).disposed(by: disposeBag)
        
        (viewModel.loading ~> activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
    }
    
    private func bindRxAction() {
        searchButton
            .rx
            .tap
            .bind {
                self.fetchStargazers(refresh: true)
            }.disposed(by: disposeBag)
    }
    
    private func bindRxTableView() {
        
        viewModel
            .stargazers
            .bind(to: stargazersTableView.rx.items) { (tableView, row, stargazer) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "StargazerCellTableViewCell") as! StargazerCellTableViewCell
                
                cell.config(stargazer: stargazer)
                
                return cell
                
            }.disposed(by: disposeBag)
        
        stargazersTableView
            .rx
            .didScroll
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                let offSetY = self.stargazersTableView.contentOffset.y
                let contentHeight = self.stargazersTableView.contentSize.height
                
                let offsetRelativeToFrame = offSetY + self.stargazersTableView.frame.size.height
                let contentHeightRelativeToInset = contentHeight + self.stargazersTableView.contentInset.bottom
                
                if Int(offsetRelativeToFrame) == Int(contentHeightRelativeToInset + 1) {
                    self.fetchStargazers()
                }
                
            }.disposed(by: disposeBag)
        
        stargazersTableView
            .rx
            .willDisplayCell
            .subscribe { [weak self] cell, indexPath in
                guard let self = self else { return }
                let contentHeight = self.stargazersTableView.contentSize.height
                let frameSize = self.stargazersTableView.frame.size.height
                
                let totalRow = self.stargazersTableView.numberOfRows(inSection:indexPath.section)
                if indexPath.row == totalRow - 1 && contentHeight < frameSize  {
                    self.fetchStargazers()
                }
            }.disposed(by: disposeBag)
        
    }
    
    private func fetchStargazers(refresh: Bool = false) {
        self.presenter?.fetchStargazers(refresh: refresh)?.disposed(by: self.disposeBag)
    }


}

