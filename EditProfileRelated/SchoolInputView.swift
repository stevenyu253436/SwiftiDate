//
//  SchoolInputView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/19.
//

import Foundation
import SwiftUI

struct SchoolInputView: View {
    @Binding var selectedSchool: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("你的學校是？")
                .font(.headline)
                .padding()

            TextField("輸入你的學校名稱", text: Binding(
                get: { selectedSchool ?? "" },
                set: { selectedSchool = $0.isEmpty ? nil : $0 }
            ))
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            Spacer()

            HStack {
                Button(action: {
                    selectedSchool = nil
                }) {
                    Text("清空")
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                .padding(.leading)
                
                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("確定")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .padding()
    }
}
