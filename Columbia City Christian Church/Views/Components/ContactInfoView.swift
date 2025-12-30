//
//  ContactInfoView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct ContactInfoView: View {
    
    let name: String
    let streetPrimary: String
    let streetSecondary: String
    let phoneNumber: String
    
    init(name: String, streetPrimary: String, streetSecondary: String, phoneNumber: String) {
        self.name = name
        self.streetPrimary = streetPrimary
        self.streetSecondary = streetSecondary
        self.phoneNumber = phoneNumber
    }
    
    init(_ contactInfo: ContactInfo) {
        self.init(
            name: contactInfo.name,
            streetPrimary: contactInfo.streetPrimary,
            streetSecondary: contactInfo.streetSecondary,
            phoneNumber: contactInfo.phoneNumber
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
                .themeStyle(.mediumHeader)
                .fontWeight(.semibold)
            
            Text(streetPrimary)
                .themeStyle(.body)
                .padding(.top, 5)
            
            Text(streetSecondary)
                .themeStyle(.body)
            
            Button {
                // TODO: Open phone app with phone number prefilled
            } label: {
                Text(phoneNumber)
                    .themeStyle(.body, fontColor: .blue)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ContactInfoView(
        name: "Columbia City Christian Church",
        streetPrimary: "270 Frontage Rd.",
        streetSecondary: "Columbia City, IN 46725",
        phoneNumber: "(260) 244-6709"
    )
    .padding(.horizontal)
}
