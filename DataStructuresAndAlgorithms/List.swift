//
//  List.swift
//  DataStructuresAndAlgorithms
//
//  Created by David Sadler on 6/14/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import Foundation

/*
 RULES:
 1 ) Individual methods or computed properties will be added to the List<T> class as extensions to solve each problem.
 
 2 )Consider instances of List as immutable. All methods should return new instances of linked lists (instead of modifying the current list).
 
 3 ) Using sequence types from the Swift Standard Library, like Array or Set is not allowed.
 */

// This is a generic Linked List: Each element points to the next one. This data structure consists of values with associated sublists referencing the rest of the structure. Think of the beginning of the list as the first value that has a sublist reference to the rest of the list, and so on...

// A list is either empty or composed of a first element (head) and a tail -- which is another list itself

class List<T> {
    var value: T
    var nextItem: List<T>?
    
    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        nextItem = List(Array(values.suffix(from: 1)))
    }
}

// 1. A "last" Property that returns the last value in the List (if there is one). Solved: 6/18/19
extension List {
    var last: T? {
        get {
            var currentList = self
            // Traverse the list until there is no nextItem:
            while currentList.nextItem != nil {
                currentList = currentList.nextItem!
            }
            return currentList.value
        }
    }
}

// 2. A "pennultimate" property that returns the second to last value of the list (if there is one). Solved: 6/18/19.
extension List {
    var pennultimate: T? {
        get {
            var currentList = self
            var value: T?
            while currentList.nextItem != nil {
                value = currentList.value
                currentList = currentList.nextItem!
            }
            return value
        }
    }
}

//3. A "subscripting" method that allows for the accessing of values by inputing an index in bracket notation after the list declaration (if there is a value at the passed in index). Solved 6/18/19.
extension List {
    subscript(index: Int) -> T? {
        var currentList = self
        var currentIndex = 0
        while currentIndex < index && currentList.nextItem != nil {
            currentList = currentList.nextItem!
            currentIndex += 1
        }
        if currentIndex == index {
            return currentList.value
        } else {
            return nil
        }
    }
}

//4. A "length" property that reflects the number of values contained in the List. Solved 6/18/19
extension List {
    var length: Int {
        get {
            var currentList = self
            var valueCount = 1
            while currentList.nextItem != nil {
                currentList = currentList.nextItem!
                valueCount += 1
            }
            return valueCount
        }
    }
}

//5. A "reverse" method that returns a list with values in reversed order. Solved 6/20/19
extension List {
    func reverse() -> List {
        // Need to use recursion / iteration here to adhear to the immutability requirement of the type.
        var current = self
        var future: List?
        var past: List?
        while current.nextItem != nil {
            future = current.nextItem
            current.nextItem = past
            past = current
            current = future!
        }
        current.nextItem = past
        return current
    }
}

//6. A "isPalindrome" method that returns true if the list values are the same backwards and forwards. Solved 6/20/19
extension List where T: Equatable {
    func isPalindrome() -> Bool {
        var truthValue = true
        let reversedList = self.reverse()
        var i = 0
        while i < self.length {
            if let forwardValue = self[i], let reverseValue = reversedList[i] {
                if forwardValue != reverseValue {
                    truthValue = false
                    break
                }
            }
            i += 1
        }
        return truthValue
    }
}

//7. A "Flatten" method that returns a single list from a declaration of a list with multiple sublists (nested lists).
extension List {
    func flatten() -> List {
        var superList = self
        var superListCurrentPosition = 0
        
        // Traverse through the top level of the list: (superList)
        while superList.nextItem != nil {
            // Helper Method to recusively flatten childLists
            func mergeChildren(childList: List, buildList: List?) -> List {
                let currentChildList = childList
                var returnList = buildList
                if currentChildList.nextItem != nil {
                    guard let currentValueAsList = currentChildList.value as? List else {
                        returnList?.value = currentChildList.value
                        returnList = buildList?.nextItem // This wont work!
                        return mergeChildren(childList: currentChildList.nextItem!, buildList: returnList)
                    }
                    return mergeChildren(childList: currentValueAsList, buildList: returnList)
                } else {
                    returnList?.nextItem = currentChildList
                    return returnList!
                }
            }
            // Check if the currentValue in the super list is a child List:
            if let currentSuperValueAsList = superList.value as? List {
                let mergedChildrenBranch = mergeChildren(childList: currentSuperValueAsList, buildList: superList)
                let superNextItem = superList.nextItem
                let lengthToMovePosition = mergedChildrenBranch.length - 1
                superListCurrentPosition += lengthToMovePosition
                superList.value = mergedChildrenBranch[0]!
                superList.ne
                
            }
            superList = superList.nextItem!
            superListCurrentPosition += 1
        }
    }
}
