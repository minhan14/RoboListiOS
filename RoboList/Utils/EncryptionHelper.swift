import Foundation
import CryptoKit

class EncryptionHelper {
    
    //AES-GCM algorithm

    static func encrypt(data: String) -> String {
       
        let secretKey = KeyStorage.getKey()
        
        let dataToEncrypt = Data(data.utf8)
        
        let sealedBox = try! AES.GCM.seal(dataToEncrypt, using: secretKey)
    
        return sealedBox.combined!.base64EncodedString()
    }
    
    static func decrypt(data: String) throws -> String {
        let secretKey = KeyStorage.getKey()
        
        guard let encryptedData = Data(base64Encoded: data) else {
            throw NSError(domain: "Invalid Base64 string", code: 1, userInfo: nil)
        }
        
        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
        
        let decryptedData = try AES.GCM.open(sealedBox, using: secretKey)
        
        guard let decryptedString = String(data: decryptedData, encoding: .utf8) else {
            throw NSError(domain: "Decryption failed", code: 2, userInfo: nil)
        }
        
        return decryptedString
    }
}
