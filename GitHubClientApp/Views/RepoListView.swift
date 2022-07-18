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
            Group {
                switch reposStore.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case .loaded([]):
                    Text("No repositories")
                        .bold()
                case let .loaded(repos):
                    List(repos) { repo in
                        NavigationLink(destination: RepoDetailView(repo: repo)) {
                            RepoRow(repo: repo)
                        }
                    }
                case .failed:
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load repositories")
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(action: {
                            Task {
                                await reposStore.loadRepos()
                            }
                        }) {
                            Text("Retry")
                                .bold()
                                .padding(.top, 8)
                        }
                    }
                }
            }
            .navigationTitle("Repositories")
        }
        .task {
            await reposStore.loadRepos()
        }
    }
}

enum Stateful<Value> {
    case idle // まだデータを取得しにいっていない
    case loading // 読み込み中
    case failed(Error) // 読み込み失敗、遭遇したエラーを保持
    case loaded(Value) // 読み込み完了、読み込まれたデータを保持
}


@MainActor
class ReposStore: ObservableObject {
    @Published private(set) var state: Stateful<[Repo]> = .idle

    func loadRepos() async {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        state = .loading
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData: [Repo] = try decorder.decode([Repo].self, from: data)
            state = .loaded(decodedData)
        } catch {
            state = .failed(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
