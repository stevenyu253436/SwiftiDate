//
//  WhoLikedYouView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/22.
//

import Foundation
import SwiftUI

struct WhoLikedYouView: View {
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.yellow.opacity(0.2)) // Background circle
                    .frame(width: 60, height: 60)

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)

                Circle()
                    .stroke(Color.white, lineWidth: 4) // Outer white border
                    .frame(width: 68, height: 68)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .foregroundColor(.yellow)
                            .background(Circle().fill(Color.white))
                            .frame(width: 20, height: 20)
                            .offset(x: 20, y: 20)
                    )
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("看看誰喜歡你了！")
                    .font(.headline)
                    .foregroundColor(.black)
                Text("立即探索")
                    .font(.subheadline)
                    .foregroundColor(.yellow)
            }

            Spacer()

            Button(action: {
                // Action when '查看' button is pressed
            }) {
                Text("查看")
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
        .background(Color.white)
    }
}