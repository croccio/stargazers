//
// Created by Antonio Scardigno on 2019-06-22.
//
 
import Foundation
 
public class PresenterProvider {
 
    static private var presenterMap = NSMapTable<NSString, AnyObject>(keyOptions: [.strongMemory],
                                                               valueOptions: [.weakMemory])
 
    public static func cleanUp() {
        presenterMap = NSMapTable<NSString, AnyObject>(keyOptions: [.strongMemory],
                                                       valueOptions: [.weakMemory])
    }
 
    static public func get<T>(viewModel: ViewModelProtocol? = nil) -> T where T: PresenterProtocol {
        let presenterClassName = NSString(string: String(describing: T.self))
 
        guard PresenterProvider.presenterMap.object(forKey: presenterClassName) == nil else {
            return PresenterProvider.presenterMap.object(forKey: presenterClassName) as! T
        }
        let obj = T(viewModel: viewModel as? T.ViewModelType)
        PresenterProvider.presenterMap.setObject(obj, forKey: presenterClassName)
        return obj
    }
}
