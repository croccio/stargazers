//
// Created by Antonio Scardigno on 2019-06-22.
//
 
import UIKit
 
open class MVPViewController<VM: ViewModelProtocol, P: BasePresenter<VM>>: UIViewController {
 
    public typealias ViewModelType = VM
    public typealias PresenterType = P
 
    public private(set) var viewModel: ViewModelType = ViewModelProvider.get()
    public private(set) var presenter: PresenterType?
 
    open override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PresenterProvider.get(viewModel: viewModel)
    }
}
