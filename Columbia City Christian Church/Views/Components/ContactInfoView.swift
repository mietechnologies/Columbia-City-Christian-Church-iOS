//
//  AddressView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/19/24.
//

import SwiftUI

struct ContactInfoView: View {
    
    let name: String
    let streetPrimary: String
    let streetSecondary: String
    let phoneNumber: String
    
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
                    .font(.body)
                    .foregroundStyle(.blue)
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
