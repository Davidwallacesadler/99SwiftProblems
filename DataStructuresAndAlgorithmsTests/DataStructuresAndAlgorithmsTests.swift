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
    
    // 1.
    /// Tests for the proper calculation of the "last" property of a List.
    func testListLastProperty() {
        XCTAssertEqual(List(1,2,3,4,5)?.last, 5, "The last value in the list (1,2,3,4,5) should be 5")
        XCTAssertEqual(List(1,3,4)?.last, 4, "The last value in the list (1,3,4) should be 4")
        XCTAssertEqual(List(1.0)?.last, 1.0, "The last value in the list (1.0) should be 1.0")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.last, Character("c"), "The last value in the list ('a','b','c') should be the character 'c'")
    }
    
    // 2.
    /// Tests for the proper calculation of the "pennultimate" property of a List.
    func testListPennultimateProperty() {
        XCTAssertEqual(List(1,2,3,4,5)?.pennultimate, 4, "The pennultimate value in the list (1,2,3,4,5) should be 4")
        XCTAssertEqual(List(1,3,4)?.pennultimate, 3, "The pennultimate value in the list (1,3,4) should be 3")
        XCTAssertEqual(List(1.0)?.pennultimate, nil, "The pennultimate value in the list (1.0) should be nil")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.pennultimate, Character("b"), "The pennultimate value in the list ('a','b','c') should be the character 'b'")
    }
    
    // 3.
    /// Tests for the proper calculation of the subscripting method of a List.
    func testListSubscriptingMethod() {
        XCTAssertEqual(List(1,2,3,4,5)?[0], 1, "Given the list (1,2,3,4,5) the value at index 1 should be 2")
        XCTAssertEqual(List(1,3,4)?[2], 4, "Given the list (1,3,4) the value at index 2 should be 4")
        XCTAssertEqual(List(1.0)?[1], nil, "Given the list (1.0) The value at index 1 should be nil")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?[1], Character("b"), "Given the list ('a','b','c') The value at index 1 should be the character 'b'")
    }
    
    // 4.
    /// Tests for the proper calculation of the "length" property of a List.
    func testListLengthProperty() {
        XCTAssertEqual(List(1,2,3,4,5)?.length, 5, "The length of the list (1,2,3,4,5) should be 5")
        XCTAssertEqual(List(1,2,3)?.length, 3, "The length of the list (1,2,3) should be 3")
        XCTAssertEqual(List(1.0)?.length, 1, "The length of the list (1.0 should be 1")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.length, 3, "The length of the list ('a','b','c') should be 3")
    }
    
    // 5.
    /// Tests for the proper reversing of the List.
    func testListReverseMethod() {
        XCTAssertEqual(List(1,2,3,4,5)?.reverse()[1], 4, "Given (1,2,3,4,5); The second value in the reversed list should be 4")
        XCTAssertEqual(List(1,2,3)?.reverse()[0], 3, "Given (1,2,3); the first value in the reversed list should be 3")
        XCTAssertEqual(List(1.0)?.reverse()[0], 1.0, "Given (1.0); the first/only value in the reversed list should be 1.0")
        XCTAssertEqual(List(Character("a"),Character("b"), Character("c"))?.reverse()[2], Character("a"), "Given (a,b,c); the last value of the revered list should be 'a'")
    }
    
    // 6.
    /// Tests for the proper checking if a list is a palindrome.
    func testListPalindromeMethod() {
        XCTAssertEqual(List(1,2,3,2,1)?.isPalindrome(), true, "Given (1,2,3,2,1); The list reads the same front to back IE should be true")
        XCTAssertEqual(List(1,2,3,4,5)?.isPalindrome(), false, "Given (1,2,3,4,5); The list doesn't read the same front to back IE should be false")
        XCTAssertEqual(List(1.0)?.isPalindrome(), true, "Given (1.0); The list automatically reads the same front to back IE should be true")
        XCTAssertEqual(List(Character("r"),Character("a"), Character("c"),Character("e"), Character("c"),Character("a"), Character("r"))?.isPalindrome(), true, "Given (r,a,c,e,c,a,r); The list reads the same front to back IE should be true")
    }
     
    // 7.
    func testFlattenMethod() {
       XCTAssertEqual(List(1,2,3,2,1)?.flatten()[2], 3, "Given (1,2,3,2,1); The list contains no sublists, so the value at index 2 should be 3.")
        // CANT REALLY CHECK OTHER LISTS WITH CHILD LISTS -- SINCE I HAVE TO USE LIST<ANY>
        // BUT I DID MAKE SURE IT DOES SOLVE THE EXAMPLE ON THE SITE.
    }
    
    // 8.
    func testCompressMethod() {
        let listOne = List(1,1,2,3,1,1)!
        listOne.compress()
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        listTwo.compress()
        XCTAssertEqual(listOne[3], 1, "Given (1,1,2,3,1,1); The 4th value in the list should be 1")
        XCTAssertEqual(listTwo.length, 6, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The compressed length should be 6")
        XCTAssertEqual(listTwo[4], "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 5th value of compressed length should be d")
    }
    
    // 9.
    func testPackMethod() {
        let listOne = List(1,1,15,15,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        XCTAssertEqual(listOne.pack()[0]![1], 1, "Given (1,1,2,3,1,1); The 2nd value in the first subList should be 1")
        XCTAssertEqual(listOne.pack()[2]![0], 2, "Given (1,1,2,3,1,1); The 1st value in the third subList should be 2")
        XCTAssertEqual(listTwo.pack()[0]![3], "a", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 4th value in the first subList should be a")
        XCTAssertEqual(listTwo.pack()[4]![0], "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 1st value in the first subList should be e")
    }
    
    // 10.
    func testEncodeMethod() {
        let listOne = List(1,1,15,15,2,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        XCTAssertEqual(listOne.encode()[0]!.0, 2, "Given (1,1,2,3,1,1); The frequency value in the first tuple should be 2")
        XCTAssertEqual(listOne.encode()[2]!.0, 3, "Given (1,1,2,3,1,1); The freqeuncy value in the third tuple should be 3")
        XCTAssertEqual(listTwo.encode()[0]!.0, 4, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The frequency value in the first tuple should be 4")
        XCTAssertEqual(listTwo.encode()[4]!.1, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The value in the 5th tuple should be d")
    }
    
    // 11.
    func testModifiedEncoding() {
        let listOne = List(1,1,15,15,2,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listOneTuple = listOne.encodeModified()[0]! as! (Int,Int)
        let listOneValue = listOne.encodeModified()[3]! as! Int
        let listTwoTuple = listTwo.encodeModified()[2]! as! (Int,String)
        let listTwoValue = listTwo.encodeModified()[4]! as! String
        XCTAssertEqual(listOneTuple.0, 2, "Given (1,1,2,3,1,1); The frequency value in the first tuple should be 2")
        XCTAssertEqual(listOneValue, 1, "Given (1,1,2,3,1,1); The final value in the list 3")
        XCTAssertEqual(listTwoTuple.0, 2, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The frequency value in the 3rd tuple should be 2")
        XCTAssertEqual(listTwoValue, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 5th value in the list should be d")
    }
    
    // 12.
    func testDecodeMethod() {
        let listOne = List("z","z","zoo","zoo","a","b")!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listOneEncoded = listOne.encodeModified()
        let listTwoEncoded = listTwo.encodeModified()
        let listOneDecoded = listOneEncoded.decode()
        let listTwoDecoded = listTwoEncoded.decode()
        XCTAssertEqual(listOneDecoded[4]!, "a", "Given (z,z,zoo,zoo,a,b); The 5th value in the list should be a")
        XCTAssertEqual(listOneDecoded[1]!, "z", "Given (z,z,zoo,zoo,a,b); The second value in the list z")
        XCTAssertEqual(listTwoDecoded[8]!, "a", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 9th value in the list should be a")
        XCTAssertEqual(listTwoDecoded[9]!, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 11th value in the list should be d")
    }
    
    // 13.
    func testEncodeDirectMethod() {
        let listOne = List(1,1,15,15,2,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listOneEncoded = listOne.encodeDirect()
        let listTwoEncoded = listTwo.encodeDirect()
        XCTAssertEqual(listOneEncoded[2]!.0, 3, "Given (1,1,15,15,2,2,2,1); The frequency value in the 3rd tuple should be 3")
        XCTAssertEqual(listOneEncoded[3]!.0, 1, "Given (1,1,15,15,2,2,2,1); The frequency value in the 4th tuple should be 1")
        XCTAssertEqual(listTwoEncoded[5]!.1, "e", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The counted value in the 6th tuple should be a")
        XCTAssertEqual(listTwoEncoded[4]!.0, 1, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The frequency value in the 5th tuple should be 1")
    }
    
    // 14.
    func testDuplicateMethod() {
        let listOne = List(1,1,15,15,2,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listOneDuplicated = listOne.duplicate()
        let listTwoDuplicated = listTwo.duplicate()
        XCTAssertEqual(listOneDuplicated[7]!, 15, "Given (1,1,15,15,2,2,2,1); The 8th value in the duplicated list should be 15")
        XCTAssertEqual(listOneDuplicated.length, 16, "Given (1,1,15,15,2,2,2,1); The length of the duplicated list should be 16")
        XCTAssertEqual(listTwoDuplicated.length, 28, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The length of the duplicated list should be 28")
        XCTAssertEqual(listTwoDuplicated[19]!, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 21st value in the duplicated list should be d")
    }
    
    // 15.
    func testNDuplicateMethod() {
        let listOne = List(1,1,15,15,2,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listOneDuplicated = listOne.duplicate(times: 3)
        let listTwoDuplicated = listTwo.duplicate(times: 2)
        XCTAssertEqual(listOneDuplicated[7]!, 15, "Given (1,1,15,15,2,2,2,1); The 8th value in the duplicated list should be 15")
        XCTAssertEqual(listOneDuplicated.length, 24, "Given (1,1,15,15,2,2,2,1); The length of the duplicated list should be 24")
        XCTAssertEqual(listTwoDuplicated.length, 28, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The length of the duplicated list should be 28")
        XCTAssertEqual(listTwoDuplicated[19]!, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 21st value in the duplicated list should be d")
    }
    
    // 16.
    func testDropMethod() {
        let listOne = List(1,1,15,15,2,2,2,1)!
        let listTwo = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listOneDropped = listOne.drop(every: 2)
        let listTwoDropped = listTwo.drop(every: 7)
        XCTAssertEqual(listOneDropped!.last, 2, "Given (1,1,15,15,2,2,2,1); The last value in the dropped list should be 2")
        XCTAssertEqual(listOneDropped!.length, 4, "Given (1,1,15,15,2,2,2,1); The length of the dropped list should be 4")
        XCTAssertEqual(listTwoDropped!.length, 12, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The length of the dropped list should be 26")
        XCTAssertEqual(listTwoDropped![7]!, "a", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 8th value in the dropped list should be c")
    }
    
    
    // 17.
    func testSplitMethod() {
        let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let splitList = list.split(leftLength: 5)
        let splitListLeft = splitList.left
        let splitListRight = splitList.right
        XCTAssertEqual(splitListLeft.last!, "b", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The left split list last value should be 2")
        XCTAssertEqual(splitListLeft.length, 5, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The length of the left split list should be 5")
        XCTAssertEqual(splitListRight[4], "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 4th value of right split list should be d")
        XCTAssertEqual(splitListRight.length, 9, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The length of the right split list should be 8")

    }
    
    // 18.
    func testSliceMethod() {
        let list = List("a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e")!
        let listSliced = list.slice(from: 4, 10)
        XCTAssertEqual(listSliced.last!, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The last value in the sliced list should be d")
        XCTAssertEqual(listSliced.length, 6, "Given (a,a,a,a,b,c,c,a,a,d,e,e); The length of the sliced list should be 5")
        XCTAssertEqual(listSliced[1]!, "c", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 2nd value of sliced list should be c")
        XCTAssertEqual(listSliced[5]!, "d", "Given (a,a,a,a,b,c,c,a,a,d,e,e); The 6th value of the sliced list should be d")
    }
    
    // 19.
    func testRotateMethod() {
        let list = List("a","b","c","d","e","f","g","h","i","j","k")!
        let postiveRotatation = list.rotate(amount: 3)
        let negativeRotation = list.rotate(amount: -2)
        XCTAssertEqual(postiveRotatation.last!, "c", "Given (a,b,c,d,e,f,g,h,i,j,k); The last value in the rotated list should be c")
        XCTAssertEqual(postiveRotatation[7]!, "k", "Given (a,b,c,d,e,f,g,h,i,j,k); The 8th value in the rotated list should be k")
        XCTAssertEqual(negativeRotation.last!, "i", "Given (a,b,c,d,e,f,g,h,i,j,k); The last value in the rotated list should be i")
        XCTAssertEqual(negativeRotation[4]!, "c", "Given (a,b,c,d,e,f,g,h,i,j,k); The 5th value in the rotated list should be c")
    }
    
    // 20.
    func testRemoveMethod() {
        let listOne = List("a","b","c","d","e","f","g","h","i","j","k")!
        let listTwo = List(1,1,15,15,2,2,2,1)!
        let listOneRemoved = listOne.removeAt(position: 5)
        let listTwoRemoved = listTwo.removeAt(position: 0)
        XCTAssertEqual(listOneRemoved.rest![5], "g", "Given (a,b,c,d,e,f,g,h,i,j,k); The 6th value in the removed list should be e")
        XCTAssertEqual(listOneRemoved.removed!, "f", "Given (a,b,c,d,e,f,g,h,i,j,k); The removed value should be f")
        XCTAssertEqual(listTwoRemoved.rest![3], 2, "Given (1,1,15,15,2,2,2,1); The 4th value in the removed list should be 15")
        XCTAssertEqual(listTwoRemoved.removed!, 1, "Given (1,1,15,15,2,2,2,1); The removed value should be 15")
    }
}

