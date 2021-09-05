//
//  ImageLoader.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import Foundation
import RxSwift

class ImageLoader  {
    
    public static let instance = ImageLoader()
    
    private var cache = Dictionary<String, UIImage>()
    
    private init() {}
    
    public func imageFrom(stringUrl: String) -> Observable<UIImage?> {
        
        if let url = URL(string: stringUrl) {
            return URLSession
                .shared
                .rx
                .response(request: URLRequest(url: url))
                .observe(on: MainScheduler.instance)
                .map { (response: HTTPURLResponse, data: Data) in
                    return UIImage(data: data)
                }
                .do(onNext: { image in
                    self.cache[stringUrl] = image
                })
                .startWith(cache[stringUrl] ?? UIImage(named: "github"))
        }
        return Observable.just(UIImage(named: "github"))
    }
    
}
