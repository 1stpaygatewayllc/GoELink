//
//  PersonTests.swift
//  GoELink
//
//  Created by GER OSULLIVAN on 8/9/15.
//  Copyright © 2015 GoEmerchant. All rights reserved.
//

import XCTest
@testable import GoELink

class PersonTests: XCTestCase {
    
    var person:Person!
    let firstName:String = "firstName";
    let surName:String = "surName";
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        person = Person(firstName:firstName, surName:surName)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
        person = nil
        
    }
    
    //    func testShowFirstNameFollowedBySurName() {
    //        // This is an example of a functional test case.
    //        let viewModelPerson :PersonViewModel = PersonViewModel(person:person)
    //        XCTAssertEqual(viewModelPerson.fullNameText, firstName + " " + surName, "Displays first name after last name")
    //    }
    
    func testShowSurNameFollowedByFirstNameForContactDetail() {
        // This is an example of a functional test case.
        let viewModelPerson :ContactDetailViewModel = ContactDetailViewModel(contact: person)
        XCTAssertEqual(viewModelPerson.fullNameText, surName + ", " + firstName, "Displays surname before first name")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
}