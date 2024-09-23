//
//  HelpView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI

struct HelpView: View {
    @Binding var isHelpView: Bool // Binding to control the dismissal of HelpView
    @State private var isWhatIsSwiftiDate = false // State variable to control navigation to WhatIsSwiftiDateView

    // Extracting the data to separate properties
    private let chatTopics = [
        "如何與他人配對、聊天？",
        "我能查看誰喜歡了我嗎？",
        "為什麼我很難配對成功？",
        "如何解除配對？",
        "可以刪除傳出去的訊息嗎？",
        "如何檢舉用戶？"
    ]
    private let premiumTopics = [
        "什麼是 SwiftiDate Premium？",
        "如何使用「看看誰喜歡你」與「開啟心動列表」功能？",
        "「Crush」是什麼？如何使用？",
        "「Turbo」是什麼？如何使用？",
        "滑錯如何反悔？",
        "如何開啟 Premium 專屬標誌？",
        "如何購買 SwiftiDate Premium？",
        "如何取消自動續費？",
        "支付完成後，特權未生效怎麼辦？",
        "如果已經成功續訂 SwiftiDate Premium，還可以退款嗎？",
        "SwiftiDate Premium 的價格有優惠嗎？"
    ]
    
    private let supremeTopics = [
        "什麼是 SwiftiDate Supreme？",
        "如何使用「每日 3 次的讚美機會」功能？",
        "如何使用「高級篩選」功能？",
        "如何使用「隱身模式」功能？",
        "如何購買 SwiftiDate Supreme？"
    ]
    
    private let personalInfoTopics = [
        "如何編輯我的個人資料？",
        "如何更改我的照片？",
        "我需要上傳什麼樣的照片作為頭像？",
        "如何通過真人認證？",
        "如何更改我的搜尋偏好？",
        "如何修改備註名稱？",
        "如何搜尋配對好友？",
        "如何收到SwiftiDate的訊息提醒？",
        "如何註銷我的帳號"
    ]
    
    var body: some View {
        if isWhatIsSwiftiDate {
            WhatIsSwiftiDateView(isWhatIsSwiftiDate: $isWhatIsSwiftiDate) // Navigate to WhatIsSwiftiDateView
        } else {
            VStack {
                // Custom Navigation Bar
                HStack {
                    Button(action: {
                        isHelpView = false // Dismiss HelpView and return to SettingsView
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                    }
                    
                    Text("SwiftiDate 幫助")
                        .font(.headline)
                        .padding(.leading, 5)
                    
                    Spacer()
                }
                .padding()
                
                Divider()
                
                // Help content
                List {
                    Section(header: Text("SwiftiDate 概覽")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)) {
                        // Convert HStack to Button
                        Button(action: {
                            isWhatIsSwiftiDate = true // Set the state variable to true
                        }) {
                            HStack {
                                Text("SwiftiDate 是什麼？")
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .foregroundColor(.black) // Ensure the text color remains black
                        
                        HStack {
                            Text("SwiftiDate 需要付費使用嗎？")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section(header: Text("配對與聊天")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)) {
                        ForEach(chatTopics, id: \.self) { topic in
                            HStack {
                                Text(topic)
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    // Adding the SwiftiDate Premium section
                    Section(header: Text("SwiftiDate Premium")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)) {
                        ForEach(premiumTopics, id: \.self) { topic in
                            HStack {
                                Text(topic)
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    // Adding the SwiftiDate Supreme section
                    Section(header: Text("SwiftiDate Supreme")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)) {
                        ForEach(supremeTopics, id: \.self) { topic in
                            HStack {
                                Text(topic)
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    // Adding the Personal Information and Settings section
                    Section(header: Text("個人資訊與設定")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.vertical, 5)) {
                        ForEach(personalInfoTopics, id: \.self) { topic in
                            HStack {
                                Text(topic)
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle()) // To create the grouped appearance like in your image
            }
        }
    }
}

// Preview for HelpView
struct HelpView_Previews: PreviewProvider {
    @State static var isHelpView = true // Provide a sample state variable for the preview

    static var previews: some View {
        HelpView(isHelpView: $isHelpView) // Use the binding variable in the preview
    }
}
