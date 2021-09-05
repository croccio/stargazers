//
// Created by Antonio Scardigno on 2019-06-22.
//
 
import Foundation
 
public protocol ViewControllerProtocol {
 
    associatedtype ViewModelType: ViewModelProtocol
    associatedtype PresenterType: PresenterProtocol
 
    var presenter: PresenterType? { get set }
    var viewModel: ViewModelType? { get set }
}
