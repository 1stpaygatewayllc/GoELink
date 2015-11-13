//
//  ContactListTests.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/9/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import XCTest

class ContactListTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
     func testNothing() {
        XCTAssertTrue(true, "");
     }
    
//     func testInitializing() {
//        XCTAssertNil([[ArrayDataSource alloc] init], @"Should not be allowed.");
//        TableViewCellConfigureBlock block = ^(UIT *a, id b){};
//        id obj1 = [[ArrayDataSource alloc] initWithItems:@[]
//        cellIdentifier:@"foo"
//        configureCellBlock:block];
//        STAssertNotNil(obj1, @"");
//    }
    
}
