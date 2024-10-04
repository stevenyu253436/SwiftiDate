//
//  DegreePicker.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI

struct DegreePicker: View {
    @Binding var selectedDegree: String?
    let degrees: [String]

    @Environment(\.presentationMode) var presentationMode  // 用于关闭 sheet
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()  // 点击关闭按钮时关闭 sheet
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                        .padding()
                }
                Spacer()
            }
            
            Text("你的教育程度是？")
                .font(.headline)
                .padding()

            ForEach(degrees, id: \.self) { degree in
                Button(action: {
                    selectedDegree = degree
                }) {
                    Text(degree)
                        .foregroundColor(selectedDegree == degree ? .white : .primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedDegree == degree ? Color.green : Color.clear)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }

            Spacer()

            HStack {
                Button(action: {
                    selectedDegree = nil
                }) {
                    Text("取消")
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                .padding(.leading)

                Spacer()
            }
            .padding(.bottom)
        }
        .padding()
    }
}

struct DegreePicker_Previews: PreviewProvider {
    static var previews: some View {
        DegreePicker(selectedDegree: .constant(nil), degrees: ["高中", "職校/專科", "學士", "碩士及以上", "其他學歷"])
    }
}
