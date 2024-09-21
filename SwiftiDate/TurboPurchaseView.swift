//
//  TurboPurchaseView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import Foundation
import SwiftUI

struct TurboPurchaseView: View {
    @Environment(\.presentationMode) var presentationMode // Environment variable to control view dismissal
    
    var body: some View {
        VStack {
            // Add the "X" button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss the view
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.gray)
                        .padding(16) // Add padding to give more space around the X button
                }
                Spacer()
            }
            .padding(.top, 16) // Adjust top padding to avoid overlapping with the status bar
            
            // Mockup header with the phone image
            Image("turbo_header") // Replace with your actual image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .padding()
            
            Text("收穫更多喜歡")
                .font(.headline)
                .padding(.top)
            
            Text("開啟Turbo期間，你的資料將直接置頂到所有人的前面！輕鬆提升10倍配對成功率")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer()
            
            // Turbo options
            HStack(spacing: 10) {
                TurboOptionView(title: "10 Turbo", price: "NT$99 /次", discount: "省 34%")
                TurboOptionView(title: "5 Turbo", price: "NT$138 /次", discount: "省 8%")
                TurboOptionView(title: "1 Turbo", price: "NT$150 /次", discount: "")
            }
            .padding(.horizontal)
            
            // Purchase button
            Button(action: {
                print("立即獲取 clicked")
                // Handle the purchase logic here
            }) {
                Text("立即獲取")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Text("獲得後隨時用，永遠不會過期")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .navigationTitle("Turbo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TurboOptionView: View {
    var title: String
    var price: String
    var discount: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            
            if !discount.isEmpty {
                Text(discount)
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding(3)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(5)
            }
            
            Text(price)
                .font(.subheadline)
        }
        .frame(width: 100, height: 120)
        .background(Color.purple.opacity(0.1))
        .cornerRadius(10)
    }
}

struct TurboPurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        TurboPurchaseView()
    }
}
