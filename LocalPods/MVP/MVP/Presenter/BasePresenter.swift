//
// Created by Antonio Scardigno on 2019-06-22.
//
 
import Foundation
 
open class BasePresenter<VM: ViewModelProtocol>: NSObject, PresenterProtocol {
    public typealias ViewModelType = VM
 
    public private(set) weak var viewModel: VM?
 
    required public init(viewModel: VM?) {
        self.viewModel = viewModel
    }
 
}
