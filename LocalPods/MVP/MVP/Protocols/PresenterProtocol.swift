//
// Created by Antonio Scardigno on 2019-06-22.
//
 
import Foundation
 
public protocol PresenterProtocol: AnyObject {
 
    associatedtype ViewModelType: ViewModelProtocol
 
    init(viewModel: ViewModelType?)
 
    var viewModel: ViewModelType? { get }
 
}
