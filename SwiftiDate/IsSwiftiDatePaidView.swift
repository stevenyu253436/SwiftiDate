//
//  IsSwiftiDatePaidView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI

struct IsSwiftiDatePaidView: View {
    @Binding var isSwiftiDatePaid: Bool // Binding to control the dismissal of IsSwiftiDatePaidView

    var body: some View {
        VStack(alignment: .leading) {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    isSwiftiDatePaid = false // Dismiss IsSwiftiDatePaidView and return to HelpView
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                
                Text("SwiftiDate 幫助")
                    .font(.headline)
                    .padding(.leading, 5)
                
                Spacer()
            }
            .padding()
            
            Divider()
            
            // Detailed content of IsSwiftiDatePaidView
            Text("SwiftiDate 需要付費使用嗎？")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Image("is_swiftidate_paid") // Replace this with your actual image name
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity) // Center the image horizontally
            
            Text("""
            SwiftiDate 提供免費和付費兩種使用方式。免費用戶可以享受基本的配對和聊天功能，但可能會有部分限制，例如每日的喜歡次數。

            付費用戶可以訂閱我們的 Premium 或 Supreme 會員，解鎖更多功能，例如無限次的喜歡、使用 Crush、Turbo，並享有更高的配對機會。此外，付費用戶還可以使用更多高級篩選功能，享受更優質的交友體驗。
            
            請選擇適合您的方案，讓 SwiftiDate 幫助您更快找到理想的另一半！
            """)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

// Preview for IsSwiftiDatePaidView
struct IsSwiftiDatePaidView_Previews: PreviewProvider {
    @State static var isSwiftiDatePaid = true // Provide a sample state variable for the preview

    static var previews: some View {
        IsSwiftiDatePaidView(isSwiftiDatePaid: $isSwiftiDatePaid) // Use the binding variable in the preview
    }
}
