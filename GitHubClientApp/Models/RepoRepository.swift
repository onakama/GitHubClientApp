//
//  RepoRepository.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/19.
//

import Foundation

struct RepoRepository {
    func fetchRepos() async throws -> [Repo] {
        try await RepoAPIClient().getRepos()
    }
}

struct RepoAPIClient {
    func getRepos() async throws -> [Repo] {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData: [Repo] = try decorder.decode([Repo].self, from: data)
            return decodedData
        } catch {
            throw URLError(.badServerResponse)
        }
    }
}
