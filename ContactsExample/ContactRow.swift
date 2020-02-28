//
//  ContactRow.swift
//  ContactsExample
//
//  Created by Alex Gabets on 2/7/20.
//  Copyright © 2020 Alex Gabets. All rights reserved.
//

import SwiftUI

struct ContactRow: View {
    var contact: ContactModel
    
    var body: some View {
        VStack {
            HStack {
                Text(contact.fullName)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10.0)
                Spacer()
                
                if !contact.avatarIconString.isEmpty {
                    Image(uiImage: getDecodedImage(dataString: contact.avatarIconString)!)
                }
            }
            .padding(.vertical, 10.0)
            
            HStack {
                Text(contact.nickName)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .padding(.horizontal, 10.0)
                Spacer()
                
                if !contact.phoneNumbers.isEmpty {
                    Text(contact.phoneNumbers[0])
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .padding(.horizontal, 10.0)
                }
            }
            
        }
    }
    
    private func getDecodedImage(dataString: String) -> UIImage? {
        
        if !dataString.isEmpty {
            let decodedData = Data(base64Encoded: dataString, options: [])
            if let data = decodedData {
                return UIImage(data: data)
            }
        }
        
        return nil
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: contactDataPreview[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
