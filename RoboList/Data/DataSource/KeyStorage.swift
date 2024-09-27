//
//  KeyStorage.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import CryptoKit


class KeyStorage {
    static let keyTag = "com.chicohan.robolist.encryptionKey"
       
       static func getKey() -> SymmetricKey {
           
           if let existingKey = retrieveKey() {
               return existingKey
           } else {
               let newKey = SymmetricKey(size: .bits256)
               saveKey(key: newKey)
               return newKey
           }
       }
       
       static func saveKey(key: SymmetricKey) {
           let keyData = key.withUnsafeBytes { Data(Array($0)) }
           UserDefaults.standard.set(keyData, forKey: keyTag)
       }
       
       static func retrieveKey() -> SymmetricKey? {
           guard let keyData = UserDefaults.standard.data(forKey: keyTag) else {
               return nil
           }
           return SymmetricKey(data: keyData)
       }
}
