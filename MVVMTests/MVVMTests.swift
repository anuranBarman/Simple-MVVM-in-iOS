//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Anuran Barman on 8/27/18.
//  Copyright © 2018 Anuran Barman. All rights reserved.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {
    

    var sut: RepoTableViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = RepoTableViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    
    
    func test_create_cell_view_model() {
        // Given
        let repos = StubGenerator().stubPhotos()
        mockAPIService.completeRepos = repos
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableViewClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.initFetch()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of photos
        XCTAssertEqual( sut.numberOfCells, repos.count )
        XCTAssertEqual(sut.numberOfCells, 1)
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
    
    
    func test_cell_view_model() {
        let repo = Repo(name: "MVVM", url: "www.mvvm.com", desc: "MVVM", starCount: 0, forkCount: 0)
        let repoWithStar100 = Repo(name: "MVVM", url: "www.mvvm.com", desc: "MVVM", starCount: 100, forkCount: 0)
        let repoWithoutDesc = Repo(name: "MVVM", url: "www.mvvm.com", desc: "", starCount: 0, forkCount: 0)
        
        
        let cellViewModel = sut!.createCellViewModel( repo:repo )
        let cellViewModelWithStar100 = sut!.createCellViewModel( repo: repoWithStar100 )
        let cellViewModelWithoutDesc = sut!.createCellViewModel( repo: repoWithoutDesc )
        
        XCTAssertEqual( repo.name, cellViewModel.name )
        XCTAssertEqual( repo.url, cellViewModel.url )
        
        XCTAssertEqual(cellViewModel.name, "\(repo.name)" )
        XCTAssertEqual(cellViewModelWithoutDesc.desc!, repoWithoutDesc.desc! )
        XCTAssertEqual(cellViewModelWithStar100.starCount, 100)
        
        
    }
    
}

class MockApiService: ApiService {
    
    var isFetchRepoCalled = false
    
    var completeRepos: [Repo] = [Repo]()
    var completeClosure: ((Int, [Repo], String) -> ())!
    
    override
    func fetchAllRepo(onResult: @escaping (Int, [Repo], String) -> ()) {
        isFetchRepoCalled = true
        completeClosure = onResult
        
    }
    
    func fetchSuccess() {
        completeClosure( 0, completeRepos, "" )
    }
    
    func fetchFail(error:String) {
        completeClosure( 0, completeRepos, error )
    }
    
}

class StubGenerator {
    func stubPhotos() -> [Repo] {
        var repos:[Repo] = []
        repos.append(Repo(name: "MVVM", url: "www.mvvm.com", desc: "MVVM", starCount: 0, forkCount: 0))
        return repos
    }
}
