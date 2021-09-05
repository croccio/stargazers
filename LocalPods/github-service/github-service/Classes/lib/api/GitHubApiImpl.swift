//
// Created by Antonio Scardigno on 2021-09-01.
//

import Foundation
import RxSwift
import StatusCodes

public class GitHubApiImpl: GitHubApi {
    
    public init() {}
    
    public func getStargazers(serviceConfig: GitHubApiConfig.StargazersService) -> Observable<GetStargazersSuccess> {
        return URLSession
            .shared
            .rx
            .response(request: GitHubApiRequest.getRequest(service: serviceConfig))
            .map { (httpUrlResponse: HTTPURLResponse, data: Data) in
                
                switch httpUrlResponse.statusCode {
                    case StatusCodes.Code200OK.code:
                        if let stargazers = try? JSONDecoder().decode(GetStargazersSuccess.self, from: data) {
                            return stargazers
                        } else {
                            throw GetStargazersException(getStargazersError: GetStargazersError(message: "Cannor parse response from server"))
                        }
                    case StatusCodes.Code404NotFound.code:
                        throw GetStargazersException(getStargazersError: try JSONDecoder().decode(GetStargazersError.self, from: data))
                    default:
                        throw GetStargazersException(getStargazersError: GetStargazersError(message: String(format: "Error %i. Please try again.".localizedCapitalized, httpUrlResponse.statusCode)))
                }
            }
        
    }

}
