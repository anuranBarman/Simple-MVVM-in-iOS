//
//  ApiServiceTest.swift
//  MVVMTests
//
//  Created by Anuran Barman on 8/27/18.
//  Copyright © 2018 Anuran Barman. All rights reserved.
//

import XCTest
@testable import MVVM

class ApiServiceTest: XCTestCase {

    var apiService:ApiService?
    
    override func setUp() {
        super.setUp()
        apiService=ApiService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService=nil
        super.tearDown()
    }
    
    func testApiService(){
        // Given A apiservice
        let aS = self.apiService!
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        
        
        aS.fetchAllRepo { (success, repos, error) in
            expect.fulfill()
            XCTAssertEqual( repos.count, 30)
            for repo in repos {
                XCTAssertNotNil(repo.name)
            }
        }
        
        wait(for: [expect], timeout: 5.1)
    }
    
}
