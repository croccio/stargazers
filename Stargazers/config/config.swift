//
//  config.swift
//  Stargazers
//
//  Created by Antonio Scardigno on 05/09/21.
//

import Foundation
import github_service

let PAGINATION = 10

let gitHubRepository: GitHubRepository = GitHubRepositoryImpl(gitHubRestApi: GitHubApiImpl(), gitHubStorage: GitHubStorageImpl())
