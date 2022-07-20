//
//  GitHubClientAppTests.swift
//  GitHubClientAppTests
//
//  Created by onakama on 2022/07/18.
//

import XCTest
@testable import GitHubClientApp

class RepoListViewModelTests: XCTestCase {

    func test_onAppear_正常系() async {
        let viewModel = await RepoListViewModel(repoRepository: MockRepoRepository_正常系(repos: [.mock1, .mock2]))
        
        await viewModel.onAppear()
        
        switch await viewModel.state {
        case let .loaded(repos):
            XCTAssertEqual(repos, [Repo.mock1, Repo.mock2])
        default:
            XCTFail()
        }
    }
    @MainActor func test_onAppear_異常系() async {
        let viewModel = RepoListViewModel(repoRepository: MockRepoRepository_異常系(repos: [],error: DummyError()))

        await viewModel.onAppear()

        switch viewModel.state {
        case let .failed(error):
            XCTAssert(error is DummyError)
        default:
            XCTFail()
        }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    //モック
    struct MockRepoRepository_正常系: RepoRepository {
        let repos: [Repo]
        
        init(repos: [Repo]) {
            self.repos = repos
        }
        
        func fetchRepos() async throws -> [Repo] {
            repos
        }
    }
    struct MockRepoRepository_異常系: RepoRepository {
        let repos: [Repo]
        let error: Error?
        
        init(repos: [Repo], error: Error) {
            self.repos = repos
            self.error = error
        }
        
        func fetchRepos() async throws -> [Repo] {
            if let error = error {
                throw error
            }
            return repos
        }
    }
}
