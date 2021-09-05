//
// Created by Antonio Scardigno on 2019-06-22.
//
 
import Foundation
 
public class ViewModelProvider {
 
    static private var viewModelMap = NSMapTable<NSString, AnyObject>(keyOptions: [.strongMemory],
                                                                      valueOptions: [.weakMemory])
 
    static private var tempViewModelMap: [String: AnyObject] = [:]
 
    public static func cleanUp() {
        viewModelMap = NSMapTable<NSString, AnyObject>(keyOptions: [.strongMemory],
                                                       valueOptions: [.weakMemory])
 
        tempViewModelMap = [:]
    }
 
    public static func get<T>() -> T where T: ViewModelProtocol {
        let viewModelClassName = NSString(string: String(describing: T.self).components(separatedBy: ".").last!)
 
        guard ViewModelProvider.viewModelMap.object(forKey: viewModelClassName) == nil else {
            return ViewModelProvider.viewModelMap.object(forKey: viewModelClassName) as! T
        }
 
        var obj = T()
 
        if let vm = ViewModelProvider.tempViewModelMap[String(viewModelClassName)] {
            ViewModelProvider.tempViewModelMap.removeValue(forKey: String(viewModelClassName))
            obj = vm as! T
        }
 
        ViewModelProvider.viewModelMap.setObject(obj, forKey: viewModelClassName)
        return obj
    }
 
    public static func set(_ vm: ViewModelProtocol) {
        let viewModelClassName = NSStringFromClass(type(of: vm)).components(separatedBy: ".").last!
 
        ViewModelProvider.tempViewModelMap[viewModelClassName] = vm
 
        ViewModelProvider.viewModelMap.removeObject(forKey: viewModelClassName as NSString)
 
    }
}
