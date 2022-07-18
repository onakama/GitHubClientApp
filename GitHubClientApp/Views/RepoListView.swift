//
//  ContentView.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import SwiftUI

struct RepoListView: View {
    @StateObject var reposStore = ReposStore()
    
    var body: some View {
        NavigationView {
            if reposStore.repos.isEmpty {
                ProgressView("loading...")
            } else {
                List(reposStore.repos) { repo in
                    NavigationLink(destination: RepoDetailView(repo: repo)) {
                        RepoRow(repo: repo)
                    }
                }
                .navigationTitle("Repositories")
            }
        }
        .task {
            await reposStore.loadRepos()
        }
    }
}

@MainActor
class ReposStore: ObservableObject {
    @Published private(set) var repos = [Repo]()

    func loadRepos() async {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        let (data, _) = try! await URLSession.shared.data(for: request)
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData: [Repo] = try! decorder.decode([Repo].self, from: data)
        repos = decodedData
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}


struct Rep: Identifiable, Codable {
    var id: Int
}
