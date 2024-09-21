//
//  PraisePurchaseView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import Foundation
import SwiftUI

struct PraisePurchaseView: View {
    @Environment(\.presentationMode) var presentationMode // Environment variable to control view dismissal

    var body: some View {
        VStack {
            // Add the "X" button with padding
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
            
            // Mockup header with the image
            Image("praise_header") // Replace with your actual image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .padding()
            
            Text("想使用更多次的讚美嗎？")
                .font(.headline)
                .padding(.top)
            
            Text("一鍵讚美心儀對象，你的喜歡無需等待")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer()
            
            // Praise options
            HStack(spacing: 10) {
                PraiseOptionView(title: "60次讚美", price: "NT$34/次", discount: "省 52%")
                PraiseOptionView(title: "30次讚美", price: "NT$42/次", discount: "省 40%")
                PraiseOptionView(title: "5次讚美", price: "NT$70/次", discount: "")
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
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Text("獲得後隨時用，永遠不會過期")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .navigationTitle("讚美")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PraiseOptionView: View {
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
        .background(Color.orange.opacity(0.1))
        .cornerRadius(10)
    }
}

struct PraisePurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PraisePurchaseView()
    }
}
