//
//  ChatGPTView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/9.
//

import Foundation
import SwiftUI

struct ChatGPTView: View {
    @State private var userInput: String = ""   // 用戶輸入的訊息
    @State private var chatResponse: String = "" // GPT 的回應
    @State private var isLoading = false        // 用來顯示加載狀態
    
    let apiKey = openAIAPIKey  // 將這個替換為您的 API 密鑰

    var body: some View {
        VStack {
            Text("ChatGPT-4o")
                .font(.title)
                .padding()
            
            ScrollView {
                Text(chatResponse)  // 顯示 ChatGPT 的回應
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 300)
            .border(Color.gray, width: 1)

            TextField("輸入您的訊息...", text: $userInput)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            if isLoading {
                ProgressView()  // 顯示加載中狀態
                    .padding()
            }

            Button(action: {
                sendMessageToChatGPT()  // 發送用戶輸入給 ChatGPT
            }) {
                Text("發送")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    // 與 OpenAI API 進行交互的函數
    func sendMessageToChatGPT() {
        guard !userInput.isEmpty else { return }

        isLoading = true
        
        // 準備 API 請求
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 設定請求的 body
        let body: [String: Any] = [
            "model": "gpt-4", // 可以使用 "gpt-3.5-turbo" 或 "gpt-4"
            "messages": [
                ["role": "system", "content": "你是個有幫助的助手。"],
                ["role": "user", "content": userInput]
            ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        // 發送請求
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            // 確保沒有錯誤且數據正確
            guard let data = data, error == nil else {
                print("API請求失敗：\(error?.localizedDescription ?? "未知錯誤")")
                return
            }
            
            // 解碼 API 回應
            if let response = try? JSONDecoder().decode(ChatGPTResponse.self, from: data) {
                DispatchQueue.main.async {
                    // 將 ChatGPT 的回應顯示在 UI 中
                    chatResponse = response.choices.first?.message.content ?? "無回應"
                    userInput = ""  // 清空用戶輸入
                }
            } else {
                print("無法解析回應數據")
            }
        }.resume()
    }
}

// 定義 OpenAI API 回應的資料結構
struct ChatGPTResponse: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}
