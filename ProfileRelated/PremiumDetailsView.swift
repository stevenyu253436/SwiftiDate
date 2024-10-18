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

struct FeatureView: View {
    var iconName: String
    var text: String
    var color: Color
    var description: String? = nil // Make description optional
    var subscriptionType: SubscriptionType // Add subscription type to determine the text color

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(color)
            VStack(alignment: .leading) {
                Text(text)
                    .font(.headline)
                    .foregroundColor(textColor()) // Use the textColor function to set the color
                if let description = description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
    
    // Helper function to determine text color based on subscription type
    private func textColor() -> Color {
        switch subscriptionType {
        case .premium:
            return .black
        case .supreme:
            return .gold
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
                
                // Scrollable list of features
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Title for the features section
                        Text("SwiftiDate Premium 專屬特權")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.bottom, 10) // Add some padding below the title
                        
                        FeatureView(iconName: "flame.fill", text: "無限右滑", color: .orange, subscriptionType: .premium)
                        FeatureView(iconName: "heart.fill", text: "看看誰喜歡你", color: .pink, subscriptionType: .premium)
                        FeatureView(iconName: "arrow.uturn.left", text: "無限反悔", color: .orange, subscriptionType: .premium)
                        FeatureView(iconName: "bolt.fill", text: "每月1次免費Turbo", color: .purple, subscriptionType: .premium)
                        FeatureView(iconName: "gift.fill", text: "每天 5 個免費Crush", color: .green, subscriptionType: .premium)
                        FeatureView(iconName: "envelope.open.fill", text: "已讀回執", color: .blue, subscriptionType: .premium)
                        FeatureView(iconName: "repeat.circle.fill", text: "配對恢復", color: .cyan, description: "重新與你取消配對的人再次配對", subscriptionType: .premium)
                        FeatureView(iconName: "list.bullet", text: "開啟心動列表", color: .orange, description: "查看你右滑過的人，等不到回應時可以馬上送出Crush", subscriptionType: .premium)
                        FeatureView(iconName: "star.fill", text: "尊貴專屬標識", color: .yellow, description: "幫你提升2.5倍的配對成功率，還可以低調隱藏。", subscriptionType: .premium)
                        FeatureView(iconName: "smiley.fill", text: "不限次數的「緣分合盤」解讀", color: .purple, description: "看看你們的緣分到底有多深", subscriptionType: .premium)
                        // Add more features as needed
                    }
                    .padding()
                }
                .frame(maxHeight: 250) // Limit the height of the scroll view
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                
                Spacer()
                
                // Continue button
                Button(action: {
                    // Handle the continue action here
                    print("繼續 button tapped")
                }) {
                    Text("繼續")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

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
                
                // Scrollable list of features
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Title for the features section
                        Text("SwiftiDate Supreme 專屬特權")
                            .font(.headline)
                            .foregroundColor(.gold)
                            .padding(.bottom, 10) // Add some padding below the title
                        
                        // Feature 1
                        FeatureView(
                            iconName: "location.fill",
                            text: "解鎖附近的人",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )
                        
                        // Feature 2
                        FeatureView(
                            iconName: "star.circle.fill",
                            text: "無限次使用高級篩選",
                            color: .gold,
                            description: "一次篩選出最符合你興趣偏好的人，馬上開始聊天！",
                            subscriptionType: .supreme
                        )
                        
                        // Feature 3
                        FeatureView(
                            iconName: "message.fill",
                            text: "每日 3 次讚美機會",
                            color: .gold,
                            description: "遇到心儀的對象，可以直接按讚美對方，無需配對",
                            subscriptionType: .supreme
                        )
                        
                        // Feature 4
                        FeatureView(
                            iconName: "heart.circle.fill",
                            text: "每日精選",
                            color: .gold,
                            description: "給優質用戶發送按讚，快速配對",
                            subscriptionType: .supreme
                        )
                        
                        // Feature 5
                        FeatureView(
                            iconName: "eye.slash.fill",
                            text: "隱身模式",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )
                        
                        // Feature 6
                        FeatureView(
                            iconName: "headphones.circle.fill",
                            text: "24小時專屬客服",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )
                        
                        // Feature 7
                        FeatureView(
                            iconName: "heart.fill",
                            text: "看看誰喜歡你",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )

                        // Feature 8
                        FeatureView(
                            iconName: "flame.fill",
                            text: "無限右滑",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )

                        // Feature 9
                        FeatureView(
                            iconName: "bolt.fill",
                            text: "每天 5 個免費 Crush",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )

                        // Feature 10
                        FeatureView(
                            iconName: "envelope.open.fill",
                            text: "已讀回執",
                            color: .gold,
                            description: nil,
                            subscriptionType: .supreme
                        )
                        
                        // Feature 11
                        FeatureView(
                            iconName: "arrow.2.squarepath",
                            text: "配對恢復",
                            color: .gold,
                            description: "重新與你取消配對的人再一次配對",
                            subscriptionType: .supreme
                        )
                        
                        // Feature 12
                        FeatureView(
                            iconName: "text.badge.plus",
                            text: "開啟心動列表",
                            color: .gold,
                            description: "查看你右滑過的人，等不到回應時可以馬上送出 Crush",
                            subscriptionType: .supreme
                        )
                        
                        // Feature 13
                        FeatureView(
                            iconName: "crown.fill",
                            text: "尊貴專屬標識",
                            color: .gold,
                            description: "幫你提升 2.5 倍的配對成功率，還可以低調隱藏",
                            subscriptionType: .supreme
                        )
                        
                        // Feature 14
                        FeatureView(
                            iconName: "eye.fill",
                            text: "不限次數的「緣分合盤」解讀",
                            color: .gold,
                            description: "看看你們的緣分到底有多深",
                            subscriptionType: .supreme
                        )

                        // Add more features as needed
                    }
                    .padding()
                }
                .frame(maxHeight: 250) // Limit the height of the scroll view
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gold.opacity(0.5), lineWidth: 2)
                )
                
                Spacer()
                
                // Continue button
                Button(action: {
                    // Handle the continue action here
                    print("繼續 button tapped")
                }) {
                    Text("繼續")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
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
