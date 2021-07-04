//
//  AboutViewModelTests.swift
//  CreativityTrialTests
//
//  Created by Olajide Osho on 04/07/2021.
//

@testable import CreativityTrial
import XCTest

class AboutViewModelTests: XCTestCase {

    var viewModel: AboutViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = AboutViewModel(AboutViewController())
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_is_valid_post() {
        XCTAssertTrue(viewModel.postRequestIsValid(PostRequest(id: 1, title: "New Post", body: "New Body")))
    }
    
    func test_get_posts_returns_greater_than_zero(){
        XCTAssertTrue(viewModel.retreivePostsFromDatabase("").count > 0)
    }
}
