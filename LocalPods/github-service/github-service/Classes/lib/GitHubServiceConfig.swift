//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation

public struct GitHubServiceConfig {

    static let BASE_URL = "https://api.github.com"

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

public class GitHubRequest {

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
