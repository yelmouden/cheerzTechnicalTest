//
//  File.swift
//  
//
//  Created by Yassin El Mouden on 17/03/2024.
//

@dynamicMemberLookup
public protocol DictionaryDynamicLookup {
    associatedtype Key
    associatedtype Value
    subscript(key: Key) -> Value? { get }
}

public extension DictionaryDynamicLookup where Key == String {
    subscript(dynamicMember member: String) -> Value? {
        return self[member]
    }
}

extension Dictionary: DictionaryDynamicLookup {}
