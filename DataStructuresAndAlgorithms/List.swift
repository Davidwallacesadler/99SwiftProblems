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

//7. A "Flatten" method that returns a single list from a declaration of a list with multiple sublists (nested lists). SOLVED!!! 1/12/2020
extension List {
    func flatten() -> List {
        func flatten(currentHead: List, currentIndex: Int, buildList: List?, childListIndex: List<Int>?) -> List {
            if currentIndex >= 0 {
                let valueAtCurrentIndex = currentHead[currentIndex]!
                if let valueAsList = valueAtCurrentIndex as? List {
                    if childListIndex != nil {
                        let newChildListIndex = List<Int>(currentIndex)!
                        newChildListIndex.nextItem = childListIndex
                        return flatten(currentHead: valueAsList, currentIndex: valueAsList.length - 1, buildList: buildList, childListIndex: newChildListIndex)
                    } else {
                         return flatten(currentHead: valueAsList, currentIndex: valueAsList.length - 1, buildList: buildList, childListIndex: List<Int>(currentIndex))
                    }
                } else {
                    if buildList != nil {
                        let build = List(valueAtCurrentIndex)!
                        build.nextItem = buildList
                        return flatten(currentHead: currentHead, currentIndex: currentIndex - 1, buildList: build, childListIndex: childListIndex)
                    } else {
                        let build = List(valueAtCurrentIndex)
                        return flatten(currentHead: currentHead, currentIndex: currentIndex - 1, buildList: build, childListIndex: childListIndex)
                    }
                }
            } else {
                if childListIndex != nil {
                    if childListIndex?.nextItem != nil {
                        let nextChildListIndex = childListIndex?.nextItem!
                        let childCounts = childListIndex!.length - 1
                        var newHead = self
                        for _ in 0..<childCounts {
                            for _ in 0..<childListIndex!.last!  {
                                newHead = newHead.nextItem!
                            }
                            newHead = newHead.value as! List
                        }
                        return flatten(currentHead: newHead, currentIndex: childListIndex!.value - 1, buildList: buildList, childListIndex: nextChildListIndex)
                    } else {
                        if childListIndex!.value == 0 {
                            return buildList!
                        } else {
                            return flatten(currentHead: self, currentIndex: childListIndex!.value - 1, buildList: buildList, childListIndex: nil)
                        }
                    }
                }
                return buildList!
            }
        }
        return flatten(currentHead: self, currentIndex: self.length - 1, buildList: nil, childListIndex: nil)
    }
}

// 8. A "Compress" method where consecutive elements are removed but the original order of values is maintained. SOLVED 1/13/2020
extension List where T: Equatable {
    func compress() {
        var currentIndex = self.length - 1
        var build: List?
        if currentIndex > 1 {
            while currentIndex >= 1 {
                let valueAtIndex = self[currentIndex]
                if let buildList = build {
                    if buildList.value != valueAtIndex {
                        let list = List(valueAtIndex!)
                        list?.nextItem = buildList
                        build = list
                    }
                } else {
                    let list = List(valueAtIndex!)
                    build = list
                }
                currentIndex -= 1
            }
            if self.value == build?.value {
                self.nextItem = build?.nextItem
            } else {
                self.nextItem = build
            }
        } else {
            return
        }
    }
}


// 9. A "Pack" method that will put consecutive duplocates into sub linked lists. Packs ALL the values in that a value will become a List containting the List that contains the value IE List(1,2,2).packed() -> List(List(1), List(2,2)). SOLVED 1/13/20
extension List where T: Equatable {
    func pack() -> List<List<T>> {
        var index = self.length - 1
        var build: List<List<T>>?
        while index >= 0 {
            let valueAtIndex = self[index]
            if build != nil {
                if let buildValueAsList = build?.value {
                    if buildValueAsList.value == valueAtIndex {
                        let appendList = List(valueAtIndex!)!
                        appendList.nextItem = buildValueAsList
                        build?.value = appendList
                    } else {
                        let newList = List<List<T>>(List(valueAtIndex!)!)!
                        newList.nextItem = build
                        build = newList
                    }
                }
            } else {
                let firstList = List(valueAtIndex!)
                build = List<List<T>>(firstList!)
            }
            index -= 1
        }
        return build!
    }
}

// 10. A "Run-Length Encoding" method that will return a list of tuples that count consecutive values. The tuple is of the form (N, E) where N is the count of the value frequency and E is the value being counted. SOLVED 1/13/20
extension List where T: Equatable {
    func encode() -> List<(Int, T)> {
        var build: List<(Int, T)>?
        let packedList = self.pack()
        var currentIndex = packedList.length - 1
        while currentIndex >= 0 {
            let listAtIndex = packedList[currentIndex]!
            if build != nil {
                let newList = List<(Int, T)>((listAtIndex.length, listAtIndex[0]!))!
                newList.nextItem = build
                build = newList
            } else {
                build = List<(Int, T)>((listAtIndex.length, listAtIndex[0]!))
            }
            currentIndex -= 1
        }
        return build!
    }
}

// 11. A "Modified Run-Length Encoding" method that will return the list of tuples that count consecutive values but in this method if a value is not repeated we will just add the value rather than a list contaning the value. SOLVED 1/13/20
extension List where T: Equatable {
    func encodeModified() -> List<Any> {
        var build: List<Any>?
        let packedList = self.pack()
        var currentIndex = packedList.length - 1
        while currentIndex >= 0 {
            let listAtIndex = packedList[currentIndex]!
            if build != nil {
                if listAtIndex.length == 1 {
                    let newList = List<Any>(listAtIndex[0]!)!
                    newList.nextItem = build
                    build = newList
                } else {
                    let newList = List<Any>((listAtIndex.length, listAtIndex[0]!))!
                    newList.nextItem = build
                    build = newList
                }
            } else {
                if listAtIndex.length == 1 {
                    build = List<Any>(listAtIndex[0]!)
                } else {
                    build = List<Any>((listAtIndex.length, listAtIndex[0]!))
                }
            }
            currentIndex -= 1
        }
        return build!
    }
}

// 12. A "Decode" method that will return a list that describes a run-length encoding list. SOLVED 1/14/20
extension List {
    func decode() -> List<String> {
        var build: List<String>?
        var currentIndex = self.length - 1
        while currentIndex >= 0 {
            if let valueAtIndexAsTuple = self[currentIndex] as? (Int, String) {
                for _ in 0..<valueAtIndexAsTuple.0 {
                    if build != nil {
                        let list = List<String>(valueAtIndexAsTuple.1)!
                        list.nextItem = build
                        build = list
                    } else {
                        build = List<String>(valueAtIndexAsTuple.1)!
                    }
                }
            }
            currentIndex -= 1
        }
        return build!
    }
}

// 13. A "Direct Run-length Encoding" method that doesn't use the .pack() method. SOLVED 1/14/20
extension List where T: Equatable {
    func encodeDirect() -> List<(Int, T)> {
        var build: List<(Int, T)>?
        var currentIndex = self.length - 1
        while currentIndex >= 0 {
            let valueAtIndex = self[currentIndex]!
            if build != nil {
                if build!.value.1 == valueAtIndex {
                    let updateTupleList = List<(Int, T)>((build!.value.0 + 1, valueAtIndex))!
                    updateTupleList.nextItem = build!.nextItem
                    build = updateTupleList
                } else {
                    let updateTupleList = List<(Int, T)>((1, valueAtIndex))!
                    updateTupleList.nextItem = build
                    build = updateTupleList
                }
            } else {
                build = List<(Int, T)>((1, valueAtIndex))
            }
            currentIndex -= 1
        }
        return build!
    }
}

// 14. A "Duplicate" method that duplicates all elements of a linked list in order. IE List(a,b,c).duplicate -> List(a,a,b,b,c,c). SOLVED 1/14/20
extension List {
    func duplicate() -> List {
        var build: List?
        var currentIndex = self.length - 1
        while currentIndex >= 0 {
            let valueAtIndex = self[currentIndex]!
            if build != nil {
                let list = List(valueAtIndex)!
                list.nextItem = build!
                let duplicate = List(valueAtIndex)!
                duplicate.nextItem = list
                build = duplicate
                
            } else {
                build = List(valueAtIndex)!
                build?.nextItem = List(valueAtIndex)!
            }
            currentIndex -= 1
        }
        return build!
    }
}

// 15. A "N-Duplicate" method that duplicates elements a given number of times. you get N - 1 copies. SOLVED 1/14/20
extension List {
    func duplicate(times: Int) -> List {
        var build: List?
        var currentIndex = self.length - 1
        while currentIndex >= 0 {
            let valueAtIndex = self[currentIndex]!
            if build != nil {
                for _ in 0..<times {
                    let list = List(valueAtIndex)!
                    list.nextItem = build
                    build = list
                }
            } else {
                for _ in 0..<times {
                    let list = List(valueAtIndex)!
                    if build != nil {
                        list.nextItem = build
                        build = list
                    } else {
                        build = list
                    }
                }
            }
            currentIndex -= 1
        }
        return build!
    }
}
