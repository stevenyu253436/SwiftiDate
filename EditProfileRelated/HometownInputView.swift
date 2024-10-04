//
//  HometownInputView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/19.
//

import Foundation
import SwiftUI

struct HometownInputView: View {
    @Binding var selectedHometown: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("你的家鄉在哪？")
                .font(.headline)
                .padding()

            TextField("輸入你的家鄉", text: Binding(
                get: { selectedHometown ?? "" },
                set: { selectedHometown = $0.isEmpty ? nil : $0 }
            ))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Spacer()
            
            HStack {
                Button(action: {
                    selectedHometown = nil // 清空输入
                }) {
                    Text("清空")
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    // 確定並關閉頁面
                    // 在这里可以添加关闭页面的逻辑
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("確定")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
    }
}
