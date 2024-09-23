//
//  TurboView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI

struct TurboView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            // Top Tab Selection
            HStack {
                Spacer()
                
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("喜歡我的人")
                        .font(.headline)
                        .foregroundColor(selectedTab == 0 ? .green : .gray)
                }
                
                Spacer()
                Spacer()
                
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("我的心動對象")
                        .font(.headline)
                        .foregroundColor(selectedTab == 1 ? .green : .gray) // Corrected logic
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)

            // The selected line
            HStack(spacing: 0) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width / 2, height: 2) // Set the width to half the screen size
                    .foregroundColor(.green)
                    .alignmentGuide(.leading) { d in
                        selectedTab == 0 ? 0 : -UIScreen.main.bounds.width / 2 // Align the Rectangle to either the left or right side
                    }
            }
            .frame(width: UIScreen.main.bounds.width, alignment: selectedTab == 0 ? .leading : .trailing) // Align HStack based on the selected tab

            Spacer().frame(height: 20)

            // The featured card section (每日精選)
            FeaturedCardView()

            Spacer().frame(height: 20)
            
            // Main image
            Image("header_image") // Replace with your image asset name
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            // Description text
            Text("開啟Turbo，將你直接置頂到所有人的前面！輕鬆提升10倍配對成功率")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            // Action button
            Button(action: {
                // Action for starting Turbo
            }) {
                Text("馬上開始")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
            }
            .padding(.vertical, 20)

            Spacer()
            
            // Floating Turbo button
            HStack {
                Spacer()
                
                Button(action: {
                    // Action for the floating button
                }) {
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - TurboView Preview
struct TurboView_Previews: PreviewProvider {
    static var previews: some View {
        TurboView()
            .previewDevice("iPhone 15 Pro") // You can replace this with the device you want to preview on
    }
}
