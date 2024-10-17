//
//  PremiumCardTabView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/17.
//

import Foundation
import SwiftUI

struct PremiumCardView: View {
    var title: String
    var subtitle: String
    var buttonText: String
    var backgroundColor: Color
    var buttonAction: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.gold)
                        .font(.system(size: 18))
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.gold)
                        .fontWeight(.bold)
                }
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gold)
                
                Spacer()
            }
            .padding(.vertical, 20)
            .frame(maxWidth: UIScreen.main.bounds.width - 80, alignment: .leading)
            .padding(.horizontal)
            
            // "開啟" Button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: buttonAction) {
                        Text(buttonText)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.orange)
                            .cornerRadius(20)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.bottom, 20)
            }
        }
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

struct PremiumCardTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // First Card
            PremiumCardView(
                title: "SwiftiDate Premium",
                subtitle: "[未開啟] 10 項尊貴特權",
                buttonText: "開啟",
                backgroundColor: Color.yellow.opacity(0.3),
                buttonAction: {
                    print("Open SwiftiDate Premium")
                }
            )
            .tag(0)
            
            // Second Card (SwiftiDate Supreme)
            PremiumCardView(
                title: "SwiftiDate Supreme",
                subtitle: "已開啟 SwiftiDate 所有特權",
                buttonText: "已啟用",
                backgroundColor: Color.black,
                buttonAction: {
                    print("SwiftiDate Supreme Activated")
                }
            )
            .tag(1)
            
            // Additional cards can be added here
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 120)
        .padding(.horizontal)
    }
}
