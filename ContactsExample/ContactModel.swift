//
//  ContactModel.swift
//  ContactsExample
//
//  Created by Alex Gabets on 2/7/20.
//  Copyright © 2020 Alex Gabets. All rights reserved.
//

import SwiftUI

struct ContactModelIOS: Codable {
    var iosType: Bool = true
    var contactModels: [ContactModel]
}

struct ContactModel: Identifiable, Codable {
    var id: Int
    var fullName: String
    var nickName: String
    var phoneNumbers: [String]
    var avatarIconString: String
}
