//
//  ContentView.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import SwiftUI


struct RepoListView: View {
    @StateObject private var viewModel: RepoListViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: RepoListViewModel())
    }
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case .loaded([]):
                    Text("No Repositories")
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
                                await viewModel.onRetryButtonTapped()
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
        .navigationViewStyle(StackNavigationViewStyle())
        .task {
            await viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
