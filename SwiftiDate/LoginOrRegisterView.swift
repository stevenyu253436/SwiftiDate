//
//  LoginOrRegisterView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/4.
//

import Foundation
import SwiftUI

struct LoginOrRegisterView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("SwiftiDate")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                // Handle Register Action
            }) {
                Text("快速註冊新帳號")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Button(action: {
                // Handle Login Action
            }) {
                Text("我已有賬號")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Text("服務協議")
                Text("&")
                Text("隱私權政策")
            }
            .font(.footnote)
            .foregroundColor(.white.opacity(0.7))
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.5), Color.blue.opacity(0.5)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        )
    }
}

struct LoginOrRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOrRegisterView()
            .previewDevice("iPhone 15 Pro")  // You can choose a specific device for the preview
    }
}
