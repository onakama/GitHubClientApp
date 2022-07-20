//
//  GitHubClientAppApp.swift
//  GitHubClientApp
//
//  Created by onakama on 2022/07/18.
//

import SwiftUI

@main
struct GitHubClientAppApp: App {
    var body: some Scene {
        WindowGroup {
            RepoListView(viewModel: RepoListViewModel())
        }
    }
}
