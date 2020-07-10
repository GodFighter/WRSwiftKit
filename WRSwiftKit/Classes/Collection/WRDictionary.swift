//
//  WRDictionary.swift
//  Pods-WRSwiftKit_Example
//
//  Created by 项辉 on 2020/7/8.
//

import UIKit

//MARK:- WRDictionaryProtocol
public protocol WRDictionaryProtocol{

}

extension Dictionary: WRDictionaryProtocol
{
    public var wr: WRDictionaryExtension<Key, Value>
    {
        return WRDictionaryExtension(self)
    }
}

//MARK:- WRDictionaryExtension
public class WRDictionaryExtension<Key, Value> where Key: Hashable, Value: Any
{
    fileprivate var _dictionary: Dictionary<Key, Value>

    fileprivate init(_ value: Dictionary<Key, Value>)
    {
        _dictionary = value
    }
}

//MARK:- Public
fileprivate typealias WRDictionaryExtension_Public = WRDictionaryExtension
public extension WRDictionaryExtension_Public
{
    /**字典交换Key*/
    /**
    */
    /// - parameter fromKey: 原key
    /// - parameter toKey: 新key
    /// - returns: 交换后的字典
    func exchange(fromKey:Key, toKey:Key) -> Dictionary<Key, Value>
    {
        if let value = _dictionary.removeValue(forKey: fromKey)
        {
            _dictionary[toKey] = value
        }
        return _dictionary
    }
    
    /**删除，依据keys数组*/
    /**
    */
    /// - parameter keys: keys数组
    /// - returns: 交换后的字典
    func removeAll<S: Sequence>(keys: S) -> Dictionary<Key, Value> where S.Element == Key
    {
        keys.forEach { _dictionary.removeValue(forKey: $0) }
        return _dictionary
    }
}

//MARK:- Json
fileprivate typealias WRDictionaryExtension_Json = WRDictionaryExtension
public extension WRDictionaryExtension_Json where Key == String
{
    /**json数据*/
    var jsonData: Data? {
        guard JSONSerialization.isValidJSONObject(_dictionary) else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: _dictionary, options: .prettyPrinted)
    }
    
    /**json字符串*/
    var jsonStirng: String? {
        guard let data = _dictionary.wr.jsonData else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

//MARK:- ValueEquatable
fileprivate typealias WRDictionaryExtension_ValueEquatable = WRDictionaryExtension
public extension WRDictionaryExtension_ValueEquatable where Value: Equatable {
    /**Value的Key数组*/
    /**
    */
    /// - parameter value: 值
    /// - returns: Key数组
    func keys(forValue value: Value) -> [Key] {
        return _dictionary.keys.filter { _dictionary[$0] == value }
    }
}

//MARK:- ValueHashable
fileprivate typealias WRDictionaryExtension_ValueHashable = WRDictionaryExtension
public extension WRDictionaryExtension_ValueHashable where Value : Hashable
{
    /**Key Value互换*/
    /**
    let dict = [1 : "a", 2 : "b", 3 : "c", 4 : "d", 5 : "e"]
    let newDict = dict.wr.swapKeyValues()
    print(newDict)
    /// ["a" : 1, "b" : 2, "c" : 3, "d" : 4, "e" : 5]
     */
    /// - returns: 交换后的字典
    func swapKeyValues() -> Dictionary<Value, Key>
    {
        assert(Set(_dictionary.values).count == _dictionary.keys.count, "Values must be unique")
        var newDict = [Value : Key]()
        for (key, value) in _dictionary
        {
            newDict[value] = key
        }
        return newDict
    }
}



