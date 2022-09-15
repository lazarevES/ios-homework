//
//  PostCollectionViewCellTest.swift
//  NavigationTests
//
//  Created by Егор Лазарев on 15.09.2022.
//

import XCTest
@testable import Navigation

class PostCollectionViewCellTest: XCTestCase {
	
	var post: FeedPost?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
		post = FeedPost(id: 1,
						title: "1",
						author: "1",
						description: "1",
						image: "post1",
						likes: 1,
						views: 1,
						postType: .post)
		let controller =  PostCollectionViewCell()
		controller.setupPost(post!, isFavorite: false)
		controller.delegate = self
		controller.imageTapped()
    }
	
	func testExample2() throws {
		
		post = FeedPost(id: 1,
						title: "1",
						author: "1",
						description: "1",
						image: "post1",
						likes: 1,
						views: 1,
						postType: .post)
		let controller =  PostCollectionViewCell()
		controller.setupPost(post!, isFavorite: true)
		controller.delegate = self
		controller.imageDoubleTapped()
	}
}

extension PostCollectionViewCellTest: PostCollectionViewCellDelegate {
	func tapToPost(with post: FeedPost, isFavorite: Bool) {
		XCTAssertTrue(isFavorite)
	}
	
	func showPost(post: FeedPost) {
		XCTAssertEqual(post, self.post)
	}
}
