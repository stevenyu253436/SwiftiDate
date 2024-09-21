//
//  CrushPurchaseView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import Foundation
import SwiftUI

struct CrushPurchaseView: View {
    @Environment(\.presentationMode) var presentationMode // Environment variable to control view dismissal

    var body: some View {
        VStack {
            // Add the "X" button with more padding
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
            Image("crush_header") // Replace with your actual image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .padding()
            
            Text("使用 Crush 魅力無窮")
                .font(.headline)
                .padding(.top)
            
            Text("送出 Crush，讓對方可以馬上看見你！")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer()
            
            // Crush options
            HStack(spacing: 10) {
                CrushOptionView(title: "60 Crushes", price: "NT$34/個", discount: "省 48%")
                CrushOptionView(title: "30 Crushes", price: "NT$43/個", discount: "省 33%")
                CrushOptionView(title: "5 Crushes", price: "NT$64/個", discount: "")
            }
            .padding(.horizontal)
            
            // Purchase button
            Button(action: {
                print("立即擁有 clicked")
                // Handle the purchase logic here
            }) {
                Text("立即擁有")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Text("獲得後隨時用，永遠不會過期")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
        }
        .navigationTitle("Crush")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CrushOptionView: View {
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
        .background(Color.green.opacity(0.1))
        .cornerRadius(10)
    }
}

struct CrushPurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        CrushPurchaseView()
    }
}
