//  Copyright © 2017 CNBC. All rights reserved.
//

import Foundation


/// A simple key value wrapper around the Keychain. This code was borrowed from https://github.com/dagostini/DAKeychain/blob/master/DAKeychain/Classes/DAKeychain.swift (MIT License)
open class Keychain {
    
    
    /// Enables or disables keychain logging
    open var loggingEnabled = false
    
    fileprivate init() {}
    
    fileprivate static var _shared: Keychain?
    
    /// Returns the shared Keychain instance
    open static var shared: Keychain {
        get {
            if _shared == nil {
                DispatchQueue.global().sync(flags: .barrier) {
                    if _shared == nil {
                        _shared = Keychain()
                    }
                }
            }
            return _shared!
        }
    }
    
    open subscript(key: String) -> String? {
        get {
            return load(withKey: key)
        } set {
            DispatchQueue.global().sync(flags: .barrier) {
                self.save(newValue, forKey: key)
            }
        }
    }
    
    fileprivate func save(_ string: String?, forKey key: String) {
        let query = keychainQuery(withKey: key)
        let objectData: Data? = string?.data(using: .utf8, allowLossyConversion: false)
        
        if SecItemCopyMatching(query, nil) == noErr {
            if let dictData = objectData {
                let status = SecItemUpdate(query, NSDictionary(dictionary: [kSecValueData: dictData]))
                logPrint("Update status: ", status)
            } else {
                let status = SecItemDelete(query)
                logPrint("Delete status: ", status)
            }
        } else {
            if let dictData = objectData {
                query.setValue(dictData, forKey: kSecValueData as String)
                let status = SecItemAdd(query, nil)
                logPrint("Update status: ", status)
            }
        }
    }
    
    fileprivate func load(withKey key: String) -> String? {
        let query = keychainQuery(withKey: key)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        guard
            let resultsDict = result as? NSDictionary,
            let resultsData = resultsDict.value(forKey: kSecValueData as String) as? Data,
            status == noErr
            else {
                logPrint("Load status: ", status)
                return nil
        }
        return String(data: resultsData, encoding: .utf8)
    }
    
    fileprivate func keychainQuery(withKey key: String) -> NSMutableDictionary {
        let result = NSMutableDictionary()
        result.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        result.setValue(key, forKey: kSecAttrService as String)
        result.setValue(kSecAttrAccessibleAlwaysThisDeviceOnly, forKey: kSecAttrAccessible as String)
        return result
    }
    
    fileprivate func logPrint(_ items: Any...) {
        if loggingEnabled {
            print(items)
        }
    }
}
