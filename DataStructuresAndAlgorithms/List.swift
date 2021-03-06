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

// 11. A "Modified Run-Length Encoding" method that will return the list of tuples that count consecutive values but in this method if a value is not repeated we will just add the value. SOLVED 1/13/20
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
            } else {
                if let valueAtIndexAsValue = self[currentIndex] as? String {
                    if build != nil {
                        let list = List<String>(valueAtIndexAsValue)!
                        list.nextItem = build
                        build = list
                    } else {
                        build = List<String>(valueAtIndexAsValue)!
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

// 16. A "Drop" method that drops every Nth element from a list. SOLVED 1/14/20
extension List {
    func drop(every: Int) -> List? {
        if every == 0 || every == 1 {
            return nil
        } else {
            var build: List?
            var currentIndex = self.length - 1
            while currentIndex >= 0 {
                let valueAtIndex = self[currentIndex]!
                if build != nil {
                    if (currentIndex + 1) % every != 0 || currentIndex == 0 {
                        let list = List(valueAtIndex)!
                        list.nextItem = build
                        build = list
                    }
                } else {
                    if (currentIndex + 1) % every != 0 {
                        build = List(valueAtIndex)
                    }
                }
                currentIndex -= 1
            }
             return build
        }
    }
}

// 17. A "Split" method to split a list into two parts at a given index.
// NOTE: I didn't know you could name your tuple coordinates in this way in the return signature!
extension List {
    func split(leftLength: Int) -> (left: List, right: List) {
        var rightBuildList: List?
        var leftBuildList: List?
        var currentIndex = self.length - 1
        while currentIndex >= 0 {
            let valueAtIndex = self[currentIndex]!
            if currentIndex >= leftLength {
                if rightBuildList != nil {
                    let next = List(valueAtIndex)
                    next?.nextItem = rightBuildList
                    rightBuildList = next
                } else {
                    rightBuildList = List(valueAtIndex)
                }
            } else {
                if leftBuildList != nil {
                    let next = List(valueAtIndex)
                    next?.nextItem = leftBuildList
                    leftBuildList = next
                } else {
                    leftBuildList = List(valueAtIndex)
                }
            }
            currentIndex -= 1
        }
        return (leftBuildList!, rightBuildList!)
    }
}

// 18. A "Slice" method that returns a slice such that given (I,K) the return list will be a slice from the values in the range I..<K.
extension List {
    func slice(from: Int, _ to: Int) -> List {
        var build: List?
        var currentIndex = to - 1
        while currentIndex >= from {
            if let valueAtIndex = self[currentIndex] {
                if build != nil {
                    let next = List(valueAtIndex)
                    next?.nextItem = build
                    build = next
                } else {
                    build = List(valueAtIndex)
                }
            }
            currentIndex -= 1
        }
        return build!
    }
}

// 19. A "Rotate" method that will return a list that is rotated N places to the left.
extension List {
    func rotate(amount: Int) -> List {
        var buildList: List?
        var buildLength = 0
        var fixedAmount = amount
        let length = self.length
        if amount == 0 {
            return self
        }
        if amount < 0 {
            fixedAmount = length + amount
        }
        var currentIndex = fixedAmount - 1
        while buildLength < length {
            if currentIndex == -1 {
                currentIndex = length - 1
            } else {
                let valueAtIndex = self[currentIndex]!
                if buildList != nil {
                    let next = List(valueAtIndex)
                    next?.nextItem = buildList
                    buildList = next
                    buildLength += 1
                } else {
                    buildList = List(valueAtIndex)
                    buildLength += 1
                }
                currentIndex -= 1
            }
        }
       return buildList!
    }
}

// 20. A "Remove" method that will remove the value at the Kth position and the rest of the list remains the same. This method will return the list after the value has been removed as well as the value removed.
extension List {
    func removeAt(position: Int) -> (rest: List?, removed: T?) {
        let length = self.length
        if (0..<length).contains(position) {
            var removed: T?
            var buildList: List?
            var currentIndex = length - 1
            while currentIndex >= 0 {
                let valueAtIndex = self[currentIndex]!
                if currentIndex == position {
                    removed = valueAtIndex
                } else {
                    if buildList != nil {
                        let next = List(valueAtIndex)
                        next?.nextItem = buildList
                        buildList = next
                    } else {
                        buildList = List(valueAtIndex)
                    }
                }
                currentIndex -= 1
            }
            return (buildList, removed)
        } else {
            return (nil,nil)
        }
    }
}

// 21. An "Insert" method that will insert the desired value at the target index -- after the addition of the value into the list it will be at the desired index.
extension List {
    func insert(index: Int, _ value: T) {
        var buildList: List?
        var currentIndex = self.length - 1
        while currentIndex >= 0 {
            let valueAtIndex = self[currentIndex]!
            if currentIndex == (index - 1) {
                if buildList != nil {
                    let next = List(value)
                    next?.nextItem = buildList
                    buildList = next
                } else {
                    buildList = List(value)
                }
            }
            if buildList != nil {
                let next = List(valueAtIndex)
                next?.nextItem = buildList
                buildList = next
            } else {
                buildList = List(valueAtIndex)
            }
            currentIndex -= 1
        }
        if index == 0 {
            self.value = value
            self.nextItem = buildList
        } else {
            self.nextItem = buildList?.nextItem
        }
    }
}

// 22. A "Range" method that will return a list of integers in a specified range. ** Note that this is a type method. All the methods written up to this point are instance methods -- methods that are called on an instance of a type. Type methods refer to the type itself rather than an instance of the type. This is almost the same as static func's -- the only difference is the class methods can allow subclasses to override this method. **
extension List {
    class func range(from: Int, _ to: Int) -> List<Int> {
        if from > to {
            return List<Int>(from)!
        }
        var buildList: List<Int>?
        var currentIndex = to
        while currentIndex >= from {
            if buildList != nil {
                let next = List<Int>(currentIndex)
                next?.nextItem = buildList
                buildList = next
            } else {
                buildList = List<Int>(currentIndex)
            }
            currentIndex -= 1
        }
        return buildList!
    }
}

// 23. A "Random Select" method that will return the specified number of random elements from the list. This is currently not an amazing solution -- possibility of going way over O(N) computations since randomElement could keep returning the same index that is already in the set. Not sure how to test this either.
extension List {
    func randomSelect(amount: Int) -> List {
        var buildList: List?
        let indexRange = 0..<self.length
        var randomIndexSet = Set<Int>()
        while randomIndexSet.count < amount {
            randomIndexSet.insert(indexRange.randomElement()!)
        }
        for index in randomIndexSet {
            if buildList != nil {
                let next = List(self[index]!)
                next?.nextItem = buildList
                buildList = next
            } else {
                buildList = List(self[index]!)
            }
        }
        return buildList!
    }
}

// 24. A "Lotto" methods that takes in (N,M) and returns a list consisting of N random integers from the range 1...M. Note: this is a type method.
extension List {
    class func lotto(numbers: Int,_ maximum: Int) -> List<Int> {
        var buildList: List<Int>?
        let valueRange = 1...maximum
        var randomNumberSet = Set<Int>()
        while randomNumberSet.count <= numbers {
            randomNumberSet.insert(valueRange.randomElement()!)
        }
        for value in randomNumberSet {
            if buildList != nil {
                let next = List<Int>(value)
                next?.nextItem = buildList
                buildList = next
            } else {
                buildList = List<Int>(value)
            }
        }
        return buildList!
    }
}

// 25. A "Random Permute" that permutes the given list's values and returns the permuted list.
extension List {
    func randomPermute() -> List {
        return self.randomSelect(amount: self.length)
    }
}
