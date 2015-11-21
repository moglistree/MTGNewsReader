//
//  DefaultFeedItemTests.swift
//  MTGNewsReader
//
//  Created by Martin on 11/10/15.
//  Copyright © 2015 Martin. All rights reserved.
//

import XCTest
@testable import MTGNewsReader

class DefaultFeedItemTests: XCTestCase {
    
    var item : DefaultFeedItem? = nil
    
    override func setUp() {
        super.setUp()
        item = DefaultFeedItem()
        item?.title = "Test Title"
        item?.creator = "John Doe"
        item?.desc = "New Description"
        item?.setURL(fromString: "http://www.channelfireball.com/articles/modern-krark-clan-ironworks/")
        item?.setPublictionDate(fromString: "Sat, 21 Nov 2015 05:00:27 +0000")
    }
    
    func testThatDefaultFeedItemExists() {
        XCTAssertNotNil(item, "should be able to create a item instance")

    }
    
    func testThatItemCanHaveTitle(){
        XCTAssertEqual("Test Title", item?.title, "The item should have the title i gave it")
    }
    
    func testThatItemCanHaveCreator(){
        XCTAssertEqual("John Doe", item?.creator, "The item should have the creator i gave it")
    }
    
    func testThatItemCanHaveDescription(){
        XCTAssertEqual("New Description", item?.desc, "The item should have the description i gave it")
    }
    
    func testDateCanBeSetFromString(){
        XCTAssertNotNil(item?.getPublicationDate(), "Date should be set when valid string is set")
    }
    
    func testThatItemCanHaveLingUrl(){
        let str = "http://www.channelfireball.com/articles/modern-krark-clan-ironworks/"
        XCTAssertEqual(NSURL(string: str), item?.getURL(), "The item should have the link url i gave it")
    }
    
    func testInvalidLinkUrl(){
        item?.setURL(fromString: "Invalid URL")
        XCTAssertNil(item?.getURL(), "When link URL is invalid value should be nil")
    }
    
    func testDateSetInvalidString(){
        item?.setPublictionDate(fromString: "Invalid string")
        XCTAssertNil(item?.getPublicationDate(), "nil expected when invalid string is set")
    }
    
    override func tearDown() {
        item = nil
        super.tearDown()
    }
    
}
