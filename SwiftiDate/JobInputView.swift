//
//  JobInputView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/19.
//

import Foundation
import SwiftUI

struct JobInputView: View {
    @Binding var selectedJob: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("你的職業是？")
                .font(.headline)
                .padding()

            TextField("輸入你的職業", text: Binding(
                get: { selectedJob ?? "" },
                set: { selectedJob = $0.isEmpty ? nil : $0 }
            ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()
            
            HStack {
                Button(action: {
                    selectedJob = nil // 清空输入
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
                    // 你可以选择在这里关闭页面
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("確定")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.trailing)
        }
        .padding()
    }
}
