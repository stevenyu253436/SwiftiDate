//
//  MeetWillingnessView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/8.
//

import Foundation
import SwiftUI

struct MeetWillingnessView: View {
    @Binding var isPresented: Bool // Binding variable to control dismissal
    @Binding var selectedOption: String?  // 傳遞選中的見面意願

    var body: some View {
        VStack {
            // 頂部顯示圖標和清空按鈕
            HStack {
                Button(action: {
                    // Dismiss the view when back button is tapped
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                    // 點擊清空按鈕的動作
                }) {
                    Text("清空")
                        .foregroundColor(.green)
                        .padding(.trailing)
                }
            }
            .padding()

            Spacer()

            // 見面意願選項
            Text("你想和 SwiftiDate 認識的朋友見面嗎？")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding()

            Text("告訴 SwiftiDate 你的見面意願，為你推薦更好的人～")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()

            // 各種選項按鈕
            VStack(spacing: 15) {
                meetOptionButton(icon: "😊", text: "期待立刻見面")
                meetOptionButton(icon: "👋", text: "先聊一下，再見面～")
                meetOptionButton(icon: "🤝", text: "熟悉彼此之後，再考慮見面～")
                meetOptionButton(icon: "❌", text: "不考慮見面")
            }

            Spacer()
        }
        .padding()
    }

    // 自定義按鈕組件
    func meetOptionButton(icon: String, text: String) -> some View {
        Button(action: {
            // 點擊按鈕後的操作：設置選中的按鈕
            selectedOption = text
        }) {
            HStack {
                Text(icon)
                    .font(.largeTitle)
                Text(text)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                // 如果這個按鈕被選中，顯示綠框框
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedOption == text ? Color.green : Color.clear, lineWidth: 3)
            )
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

// PreviewProvider to display the preview of the view
struct MeetWillingnessView_Previews: PreviewProvider {
    @State static var isPresented = true // Provide a sample @State variable for preview
    @State static var selectedOption: String? = nil // 需要為 preview 提供一個預設的 selectedOption

    static var previews: some View {
        MeetWillingnessView(isPresented: $isPresented, selectedOption: $selectedOption)
    }
}
