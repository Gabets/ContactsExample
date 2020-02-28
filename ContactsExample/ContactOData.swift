//
//  ContactData.swift
//  ContactsExample
//
//  Created by Alex Gabets on 2/11/20.
//  Copyright © 2020 Alex Gabets. All rights reserved.
//

import Combine
import SwiftUI

final class ContactOData: ObservableObject {
    @Published var contacts: [ContactModel] = []
}
