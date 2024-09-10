//
//  InterestsView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI

struct InterestsView: View {
    let interests: [String]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),  // 第一列
        GridItem(.flexible(), spacing: 10)   // 第二列
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // 把 "興趣" Title 放在白色框框外
            Text("興趣")
                .font(.headline)
                .padding(.bottom, 5)
                .padding(.horizontal) // 添加水平间距，使标题与内容对齐

            // 將整個白色背景區塊都包裹在 NavigationLink 中
            NavigationLink(destination: InterestSelectionView()) {
                VStack {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(interests, id: \.self) { interest in
                            Text(interest)
                                .font(.subheadline)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.pink.opacity(0.1))
                                .cornerRadius(20)
                                .foregroundColor(.primary) // 確保文字顏色不會變
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle()) // 移除 NavigationLink 的默认按钮样式，避免顯示點擊效果
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}
