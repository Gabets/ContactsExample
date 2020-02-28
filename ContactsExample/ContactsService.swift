//
//  ContactsService.swift
//  ContactsExample
//
//  Created by Alex Gabets on 2/7/20.
//  Copyright © 2020 Alex Gabets. All rights reserved.
//

import Contacts

class Contacts {
    let store = CNContactStore()
    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey, CNContactThumbnailImageDataKey]
    var fetchedData: [ContactModel] = []
    var i = 0

   
    func getContacts() -> [ContactModel] {
        
        do {
            try store.enumerateContacts(with: CNContactFetchRequest.init(keysToFetch: keysToFetch as [CNKeyDescriptor]), usingBlock: self.handleContact)
        } catch {
            print("something wrong happened")
        }
        
        let contactModelIOS = ContactModelIOS(contactModels: fetchedData)
        let jsonData = try! JSONEncoder().encode(contactModelIOS)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        return fetchedData
    }
    
    
    func getContactsJSON() -> String {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey, CNContactNicknameKey,  CNContactThumbnailImageDataKey]
        var fetchedData: [ContactModel] = []
        var i = 0
        
        do {
            try store.enumerateContacts(with: CNContactFetchRequest.init(keysToFetch: keysToFetch as [CNKeyDescriptor]), usingBlock: {(contact, pointer) -> Void in
                print("contact \(i) = ","\(contact)")
                 var names: [String] = []
                 
                 if !contact.givenName.isEmpty {
                     names.append("\(contact.givenName.unicodeScalars)")
                 }
                 
                 if !contact.middleName.isEmpty {
                     names.append("\(contact.middleName.unicodeScalars)")
                 }
                 
                 if !contact.familyName.isEmpty {
                     names.append("\(contact.familyName.unicodeScalars)")
                 }

                 let fullName = names.joined(separator: " ")
                 print("fullName = \(fullName)")
                 print("nickName = \(contact.nickname.unicodeScalars)")
                 
                 var phoneNumbers: [String] = []
                 if !contact.phoneNumbers.isEmpty {
                     contact.phoneNumbers.forEach({
                         phoneNumbers.append($0.value.stringValue)
                     })
                 }
                 
                 phoneNumbers.forEach({
                     print("phone = \($0)")
                 })
                
                var avatarIconString = ""
                
                if !(contact.thumbnailImageData?.isEmpty ?? true) {
                    avatarIconString = contact.thumbnailImageData?.base64EncodedString() ?? ""
                }
                 
                 let contactModel = ContactModel(id: i, fullName: fullName, nickName: "\(contact.nickname.unicodeScalars)", phoneNumbers: phoneNumbers, avatarIconString: avatarIconString)
                 let jsonData = try! JSONEncoder().encode(contactModel)
                 let jsonString = String(data: jsonData, encoding: .utf8)!
                 print(jsonString)
                 print()
                 
                 fetchedData.append(contactModel)

                i += 1
            })
        } catch {
            print("something wrong happened")
        }
        
        let contactModelIOS = ContactModelIOS(contactModels: fetchedData)
        let jsonData = try! JSONEncoder().encode(contactModelIOS)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        return jsonString
    }
    
    func handleContact(_ contact: CNContact, _ pointer: UnsafeMutablePointer<ObjCBool>) {
        
        print("contact \(i) = ","\(contact)")
        var names: [String] = []
        
        if !contact.givenName.isEmpty {
            names.append("\(contact.givenName.unicodeScalars)")
        }
        
        if !contact.middleName.isEmpty {
            names.append("\(contact.middleName.unicodeScalars)")
        }
        
        if !contact.familyName.isEmpty {
            names.append("\(contact.familyName.unicodeScalars)")
        }

        let fullName = names.joined(separator: " ")
        print("fullName = \(fullName)")
        print("nickName = \(contact.nickname.unicodeScalars)")
        
        var phoneNumbers: [String] = []
        if !contact.phoneNumbers.isEmpty {
            contact.phoneNumbers.forEach({
                phoneNumbers.append($0.value.stringValue)
            })
        }
        
        phoneNumbers.forEach({
            print("phone = \($0)")
        })
        
        var avatarIconString = ""
        
        if !(contact.thumbnailImageData?.isEmpty ?? true) {
            avatarIconString = contact.thumbnailImageData?.base64EncodedString() ?? ""
        }
  
        let contactModel = ContactModel(id: i, fullName: fullName, nickName: "\(contact.nickname.unicodeScalars)", phoneNumbers: phoneNumbers, avatarIconString: avatarIconString)
        let jsonData = try! JSONEncoder().encode(contactModel)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        print()
        
        fetchedData.append(contactModel)

       i += 1
    }
        
}
