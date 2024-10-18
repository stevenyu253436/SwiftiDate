//
//  PremiumDetailsView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/18.
//

import Foundation
import SwiftUI

enum PremiumType: Identifiable {
    case premium
    case supreme
    
    var id: String {
        switch self {
        case .premium:
            return "premium"
        case .supreme:
            return "supreme"
        }
    }
}

struct PremiumDetailsView: View {
    @Binding var selectedTab: PremiumType // Use Binding to pass the state from parent
    @Environment(\.presentationMode) var presentationMode // Environment variable to dismiss the view

    var body: some View {
        VStack(spacing: 20) {
            // Close button at the top left
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss the view when tapped
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer() // Push the close button to the left
            }
            
            // Custom Tab Selector
            HStack {
                Button(action: {
                    selectedTab = .premium
                }) {
                    Text("Premium")
                        .font(.title2)
                        .fontWeight(.bold)
                        .italic() // Make the text italic
                        .foregroundColor(selectedTab == .premium ? .yellow : .platinum)
                        .underline(selectedTab == .premium, color: .yellow)
                        .padding(.horizontal)
                }
                
                Rectangle()
                    .frame(width: 1, height: 30)
                    .foregroundColor(.gold) // Use your custom gold color
                    .padding(.horizontal)
                
                Button(action: {
                    selectedTab = .supreme
                }) {
                    Text("Supreme")
                        .font(.title2)
                        .fontWeight(.bold)
                        .italic() // Make the text italic
                        .foregroundColor(selectedTab == .supreme ? .gold : .black)
                        .underline(selectedTab == .supreme, color: .gold)
                        .padding(.horizontal)
                }
            }
            
            // Display different content based on the type
            if selectedTab == .premium {
                Image(systemName: "crown.fill")
                    .resizable()
                    .frame(width: 40, height: 40) // Adjust the width and height to match the size of the large title
                    .foregroundColor(.yellow) // Set the color to gold
                Text("開通 SwiftiDate Premium 看看誰喜歡你，與對方立即配對聊天！")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                SubscriptionScrollView(subscriptionType: .premium) // For Premium subscription
                    .padding()
                
                // Common content
                Spacer()
                Text("Enjoy your subscription and have a great experience with SwiftiDate!")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()

            } else if selectedTab == .supreme {
                Image(systemName: "crown.fill")
                    .resizable()
                    .frame(width: 40, height: 40) // Adjust the width and height to match the size of the large title
                    .foregroundColor(.gold) // Set the color to gold
                Text("開通 SwiftiDate Supreme 看看誰喜歡你，與對方立即配對聊天！")
                    .font(.headline)
                    .foregroundColor(.gold) // Use the custom gold color
                    .multilineTextAlignment(.center)
                    .padding()

                SubscriptionScrollView(subscriptionType: .supreme) // For Supreme subscription
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
        .background(selectedTab == .premium ? Color.yellow.opacity(0.1) : Color.black) // Set background color
        .edgesIgnoringSafeArea(.all) // Extend the background to cover the entire view
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
