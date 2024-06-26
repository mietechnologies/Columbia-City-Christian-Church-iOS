//
//  ProfileScreen.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/20/24.
//

import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    var body: some View {
        VStack {
            ProfileImage {
                print("Profile Image Tapped")
            }
            .frame(width: 225, height: 225)
            
            // TODO: Update all these text objects with the updates from AboutChurchScreen
            Text("Brett Chapin")
                .themeStyle(.mediumHeader)
                .foregroundStyle(.textPrimary)
            
            Text("Joined: June 20, 2024 | Birthday: October 32, 1989")
                .foregroundStyle(.textPrimary)
                .font(.caption)
                .italic()
                .padding(.bottom, 10)
                .padding(.top, 5)
            
            Text("Phone #: (260) 555-5555")
                .themeStyle(.body)
                .padding(.bottom, 10)
            
            Text("Address:")
                .themeStyle(.body)
            
            Text("123 Somewhere Ave.")
                .themeStyle(.body)
            
            Text("RandomVille, UT 12345")
                .themeStyle(.body)
                .padding(.bottom, 10)
            
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
        .navigationTitle("User Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text("Edit")
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    ProfileScreen()
}
