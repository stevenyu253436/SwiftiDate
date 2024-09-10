//
//  InterestDetailView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/8.
//

import Foundation
import SwiftUI

struct InterestDetailView: View {
    let interest: String  // 用於接收點擊時傳遞的興趣標籤

    var body: some View {
        VStack {
            Text(interest)  // 顯示點擊的興趣內容
                .font(.largeTitle)
                .padding()

            Spacer()  // 使用 Spacer 來使內容位於屏幕頂部

            Text("更多有關 \(interest) 的內容可以在這裡顯示")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            Spacer()  // 使用 Spacer 來使內容位於屏幕底部
        }
        .navigationTitle(interest)  // 將導航標題設置為興趣標籤
        .padding()
    }
}

struct InterestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InterestDetailView(interest: "Sample Interest")  // 預覽時顯示的示例
    }
}
