//
//  User.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import Foundation

struct User: Codable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
