//
//  ContentView.swift
//  ContactsExample
//
//  Created by Alex Gabets on 2/7/20.
//  Copyright © 2020 Alex Gabets. All rights reserved.
//

import SwiftUI

struct ContactsList: View {
    @EnvironmentObject var contactOData: ContactOData

    var body: some View {
        VStack {
            if contactOData.contacts.isEmpty {
                Button(action: {
                    self.contactOData.contacts = Contacts().getContacts()
                }) {
                    Text("Get Contacts")
                }
            } else {
                Text("Contacts")
                    .font(.title)
                    .fontWeight(.bold)
                List(contactOData.contacts) { contact in
                    ContactRow(contact: contact)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsList()
        .environmentObject(ContactOData())
    }
}
