//
//  ProfileScreen.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/20/24.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack {
            ProfileImage {
                print("Profile Image Tapped")
            }
            .frame(width: 225, height: 225)
            
            // TODO: Update all these text objects with the updates from AboutChurchScreen
            Text("Brett Chapin")
                .themeStyle(.header)
                .foregroundStyle(.textPrimary)
            
            Text("Joined: June 20, 2024 | Birthday: October 32, 1989")
                .foregroundStyle(.textPrimary)
                .font(.caption)
                .italic()
            
            Text("Phone #: (260) 555-5555")
                .themeStyle(.body)
            
            Text("Address:")
                .themeStyle(.body)
            
            Text("123 Somewhere Ave.")
                .themeStyle(.body)
            
            Text("RandomVille, UT 12345")
                .themeStyle(.body)
            
            Button {
                
            } label: {
                Text("Check In History")
            }
            .buttonStyle(RoundedRectangleButtonStyle(type: .neutral))
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            
            Button {
                
            } label: {
                Text("Tithe History")
            }
            .buttonStyle(RoundedRectangleButtonStyle(type: .neutral))
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
            
            Button {
                
            } label: {
                Label(
                    title: { Text("Delete") },
                    icon: { Image(systemName: "trash") }
                )
            }
            .buttonStyle(RoundedRectangleButtonStyle(type: .destructive))
            .padding(.horizontal, 25)
            .padding(.vertical, 10)

        }
    }
}

#Preview {
    ProfileScreen()
}
