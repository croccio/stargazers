//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation

public struct GitHubApiConfig {

    static let BASE_URL = "https://api.github.com"

    public struct StargazersService: BaseService {
        public var type: ServiceType = .GET
        public var url: String = "\(BASE_URL)/repos/%@/%@/stargazers"
            .appending("?page=%d")
            .appending("&per_page=%d")
        public var body: String? = nil
        
        init(owner: String, repo: String, perPage: Int, page: Int) {
            url = String(format: url, owner, repo, page, perPage)
        }
        
        
    }
    
}

public protocol BaseService {
    var type: ServiceType { get }
    var url: String { get }
    var body: String? { get }
}

public enum ServiceType: String {
    case GET = "GET",
         POST = "POST",
         PUT = "PUT",
         PATCH = "PATCH",
         DELETE = "DELETE"
}

public class GitHubApiRequest {

    public static func getRequest(service: BaseService) -> URLRequest {
        let url = URL(string: service.url)!
        var request = URLRequest(url: url)
        request.httpMethod = service.type.rawValue

        if let body = service.body {
            request.httpBody = body.data(using: .utf8)
        }

        return request
    }
}
