//
//  DataStructuresAndAlgorithmsTests.swift
//  DataStructuresAndAlgorithmsTests
//
//  Created by David Sadler on 6/14/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import XCTest
@testable import DataStructuresAndAlgorithms

class DataStructuresAndAlgorithmsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - List Unit Tests
    
    /// Tests for the proper calculation of the "last" property of a List.
    func testListLastProperty() {
        XCTAssertEqual(List(1,2,3,4,5)?.last, 5, "The last value in the list (1,2,3,4,5) should be 5")
        XCTAssertEqual(List(1,3,4)?.last, 4, "The last value in the list (1,3,4) should be 4")
        XCTAssertEqual(List(1.0)?.last, 1.0, "The last value in the list (1.0) should be 1.0")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.last, Character("c"), "The last value in the list ('a','b','c') should be the character 'c'")
    }
    
    /// Tests for the proper calculation of the "pennultimate" property of a List.
    func testListPennultimateProperty() {
        XCTAssertEqual(List(1,2,3,4,5)?.pennultimate, 4, "The pennultimate value in the list (1,2,3,4,5) should be 4")
        XCTAssertEqual(List(1,3,4)?.pennultimate, 3, "The pennultimate value in the list (1,3,4) should be 3")
        XCTAssertEqual(List(1.0)?.pennultimate, nil, "The pennultimate value in the list (1.0) should be nil")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.pennultimate, Character("b"), "The pennultimate value in the list ('a','b','c') should be the character 'b'")
    }
    
    /// Tests for the proper calculation of the subscripting method of a List.
    func testListSubscriptingMethod() {
        XCTAssertEqual(List(1,2,3,4,5)?[0], 1, "Given the list (1,2,3,4,5) the value at index 1 should be 2")
        XCTAssertEqual(List(1,3,4)?[2], 4, "Given the list (1,3,4) the value at index 2 should be 4")
        XCTAssertEqual(List(1.0)?[1], nil, "Given the list (1.0) The value at index 1 should be nil")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?[1], Character("b"), "Given the list ('a','b','c') The value at index 1 should be the character 'b'")
    }
    
    /// Tests for the proper calculation of the "length" property of a List.
    func testListLengthProperty() {
        XCTAssertEqual(List(1,2,3,4,5)?.length, 5, "The length of the list (1,2,3,4,5) should be 5")
        XCTAssertEqual(List(1,2,3)?.length, 3, "The length of the list (1,2,3) should be 3")
        XCTAssertEqual(List(1.0)?.length, 1, "The length of the list (1.0 should be 1")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.length, 3, "The length of the list ('a','b','c') should be 3")
    }
    
    /// Tests for the proper reversing of the List.
    func testListReverseMethod() {
        XCTAssertEqual(List(1,2,3,4,5)?.reverse()[1], 4, "Given (1,2,3,4,5); The second value in the reversed list should be 4")
        XCTAssertEqual(List(1,2,3)?.reverse()[0], 3, "Given (1,2,3); the first value in the reversed list should be 3")
        XCTAssertEqual(List(1.0)?.reverse()[0], 1.0, "Given (1.0); the first/only value in the reversed list should be 1.0")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.reverse()[2], Character("a"), "Given (a,b,c); the last value of the revered list should be 'a'")
    }
    
    /// Tests for the proper checking if a list is a palindrome.
    func testListPalindromeMethod() {
        XCTAssertEqual(List(1,2,3,2,1)?.isPalindrome(), true, "Given (1,2,3,2,1); The list reads the same front to back IE should be true")
        XCTAssertEqual(List(1,2,3,4,5)?.isPalindrome(), false, "Given (1,2,3,4,5); The list doesn't read the same front to back IE should be false")
        XCTAssertEqual(List(1.0)?.isPalindrome(), true, "Given (1.0); The list automatically reads the same front to back IE should be true")
        XCTAssertEqual(List(Character("r"),Character("a"), Character("c"),Character("e"), Character("c"),Character("a"), Character("r"))?.isPalindrome(), true, "Given (r,a,c,e,c,a,r); The list reads the same front to back IE should be true")
    }
    
    func testFlattenMethod() {
       XCTAssertEqual(List(1,2,3,2,1)?.flatten()[2], 3, "Given (1,2,3,2,1); The list contains no sublists, so the value at index 2 should be 3.")
        // CANT REALLY CHECK OTHER LISTS WITH CHILD LISTS -- SINCE I HAVE TO USE LIST<ANY>
        // BUT I DID MAKE SURE IT DOES SOLVE THE EXAMPLE ON THE SITE.
    }
    
    func testCompressMethod() {
        let listOne = List(1,1,2,3,1,1)!
        listOne.compress()
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        listTwo.compress()
        XCTAssertEqual(listOne[3], 1, "Given (1,1,2,3,1,1); The 4th value in the list should be 1")
        XCTAssertEqual(listTwo.length, 6, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The compressed length should be 6")
        XCTAssertEqual(listTwo[4], "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 5th value of compressed length should be d")
    }
    
    
    
    
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
