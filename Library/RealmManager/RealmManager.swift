//
//  RealmManager.swift
//  Rocket
//
//  Created by Thongpak on 7/11/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    static let sharedInstance = RealmManager()
    private let currentSchemaVersion: UInt64 = 0
    
    public func getRealm() -> Realm {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            encryptionKey: getKey(), schemaVersion: currentSchemaVersion,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        do {
            let realm = try Realm()
            return realm
        } catch {
            try! FileManager().removeItem(at: config.fileURL!)
            let realm = try! Realm(configuration: config)
            return realm
        }
    }
    
    private func getKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.realm.encryptionKeyForRocket"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }
        
        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, UnsafeMutableRawPointer(keyData.mutableBytes))
        assert(result == 0, "Failed to get random bytes")
        
        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]
        
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return keyData as Data
    }
    
    func deleteAll() {
        let realm = getRealm()
        try! realm.write() {
            realm.deleteAll()
        }
    }
    
    func insert(object: Object) {
        let realm = getRealm()
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func delete(primaryKey: String, object: Object.Type) {
        let realm = getRealm()
        DispatchQueue.main.async {
            try! realm.write() {
                let a = realm.object(ofType: object, forPrimaryKey: primaryKey)
                realm.delete(a!)
            }
        }
    }
    
    func getData(formType Object: Object.Type) -> [Object] {
        let realm = getRealm()
        return realm.objects(Object.self).toArray(ofType: Object.self)
    }
}

extension Results {
    public func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
