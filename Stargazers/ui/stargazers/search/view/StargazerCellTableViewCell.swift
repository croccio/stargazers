//
//  StargazerCellTableViewCell.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import UIKit
import github_service
import RxSwift
import RxBinding

class StargazerCellTableViewCell: UITableViewCell {

    public static let identifier = "StargazerCellTableViewCell"
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(stargazer: Stargazer) {
        usernameLabel.text = stargazer.login
        
        avatarImageView.image = UIImage(named: "github")
        if let url = stargazer.avatarUrl{
            (ImageLoader.instance.imageFrom(stringUrl: url) ~> avatarImageView.rx.image).disposed(by: disposeBag)
        }
    }

}
