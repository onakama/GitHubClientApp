//
//  Repo.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import Foundation

struct Repo: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var owner: User
    var description: String?
    var stargazersCount: Int
}
