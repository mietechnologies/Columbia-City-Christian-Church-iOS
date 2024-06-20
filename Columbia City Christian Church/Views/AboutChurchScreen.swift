//
//  AboutChurchView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/19/24.
//

import SwiftUI

struct AboutChurchScreen: View {
    
    let introduction: String = "We welcome you to worship Jesus with us as we gather in the presence of fellow believers. " +
    "Service starts at 10 am or arrive early to enjoy coffee and donuts with us!"
    
    var body: some View {
        ScrollView(.vertical) {
            Text(introduction)
                .themeStyle(.body, lineSpacing: 3)
                .padding(.bottom, 10)
                .padding(.top, 15)
            
            // TODO: Update with an event cell
            VStack(spacing: 5) {
                HStack {
                    Text("Sunday")
                        .themeStyle(.mediumHeader)
                    
                    Spacer()
                }
                
                HStack {
                    Text("10:00 AM")
                        .themeStyle(.body2)
                    
                    Spacer(minLength: 0)
                    
                    Text("Worship Service")
                        .themeStyle(.body2)
                }
            }
            .padding(.vertical, 10)
            
//            Divider()
//                .background(.white)
            
            ContactInfoView(
                name: "Columbia City Christian Church",
                streetPrimary: "270 Frontage Rd.",
                streetSecondary: "Columbia City, IN 46725",
                phoneNumber: "(260) 244-6709"
            )
            
            LocationMapView()
                .padding(.top, 10)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 15)
        .background(.baseBackground)
    }
}

#Preview {
    AboutChurchScreen()
}
