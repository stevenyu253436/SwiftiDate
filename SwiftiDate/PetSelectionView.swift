//
//  PetSelectionView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/20.
//

import Foundation
import SwiftUI

struct PetSelectionView: View {
    @Binding var selectedPet: String?
    @Environment(\.presentationMode) var presentationMode // 用于控制视图的关闭
    
    let options = [
        "沒有寵物",
        "養貓",
        "養狗",
        "魚類",
        "爬蟲類",
        "兩棲類動物",
        "其他動物"
    ]
    
    var body: some View {
        VStack {
            Text("你有養寵物嗎？")
                .font(.headline)
                .padding()
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedPet = option
                    presentationMode.wrappedValue.dismiss() // 选择后关闭页面
                }) {
                    HStack {
                        Text(option)
                            .foregroundColor(selectedPet == option ? .white : .primary)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if selectedPet == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .background(selectedPet == option ? Color.green : Color.clear)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    selectedPet = nil // 清空选择
                    presentationMode.wrappedValue.dismiss() // 关闭页面
                }) {
                    Text("清空")
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // 确定并关闭页面
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
