//
//  PremiumDetailsView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/18.
//

import Foundation
import SwiftUI

enum PremiumType {
    case premium
    case supreme
}

struct PremiumDetailsView: View {
    @Binding var selectedTab: PremiumType // Use Binding to pass the state from parent

    var body: some View {
        VStack(spacing: 20) {
            // Custom Tab Selector
            HStack {
                Button(action: {
                    selectedTab = .premium
                }) {
                    Text("Premium")
                        .font(.headline)
                        .fontWeight(selectedTab == .premium ? .bold : .regular)
                        .foregroundColor(selectedTab == .premium ? .yellow : .black)
                        .underline(selectedTab == .premium, color: .yellow)
                        .padding(.horizontal)
                }
                
                Divider()
                    .frame(height: 20)
                    .padding(.horizontal)
                
                Button(action: {
                    selectedTab = .supreme
                }) {
                    Text("Supreme")
                        .font(.headline)
                        .fontWeight(selectedTab == .supreme ? .bold : .regular)
                        .foregroundColor(selectedTab == .supreme ? .black : .gray)
                        .padding(.horizontal)
                }
            }
            
            // Display different content based on the type
            if selectedTab == .premium {
                Text("SwiftiDate Premium")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Unlock all the premium features, including unlimited swipes and more!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Common content
                Spacer()
                Text("Enjoy your subscription and have a great experience with SwiftiDate!")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()

                Spacer()
            } else if selectedTab == .supreme {
                Text("SwiftiDate Supreme")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Enjoy all the supreme features, including all premium features plus more exclusive benefits!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Common content
                Spacer()
                Text("Enjoy your subscription and have a great experience with SwiftiDate!")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()

                Spacer()
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct PremiumDetailsView_Previews: PreviewProvider {
    @State static var selectedTab: PremiumType = .premium

    static var previews: some View {
        Group {
            // Preview for Premium
            PremiumDetailsView(selectedTab: $selectedTab)
                .previewDisplayName("Premium Details")

            // Preview for Supreme
            PremiumDetailsView(selectedTab: .constant(.supreme)) // Using constant binding for Supreme
                .previewDisplayName("Supreme Details")
        }
    }
}
