//
//  SafetyQuizView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/10.
//

import Foundation
import SwiftUI

struct SafetyQuizView: View {
    @State private var selectedOption: String? = nil
    @State private var showExplanation: Bool = false
    @State private var showMessage: Bool = false
    @State private var currentQuestionIndex: Int = 0
    
    let questions: [QuizQuestion] = [
        QuizQuestion(
            text: "配對後，用以下哪種聊天方式會更安全？",
            options: ["配對後，在 SwiftiDate 上聊天", "配對後馬上轉去其他平台或APP"],
            correctAnswer: "配對後，在 SwiftiDate 上聊天",
            explanation: "SwiftiDate 上聊天更安全。如果配對之後馬上換到其他平台或其他APP聊天，SwiftiDate的安全團隊就沒有辦法保護您聊天的安全～"
        ),
        QuizQuestion(
            text: "系統顯示，你和一個配對距離很近。對方說想見面，並問你的具體住址在哪。這時候，你應該…",
            options: ["告訴對方自己的詳細住址", "只告訴對方自己所在的大致方位。保護隱私，不輕易透露個人訊息。"],
            correctAnswer: "只告訴對方自己所在的大致方位。保護隱私，不輕易透露個人訊息。",
            explanation: "個人詳細住址屬於個人隱私。為了你的安全，請不要輕易透露個人信息。"
        ),
        QuizQuestion(
            text: "一位條件很好的配對對象每天無微不至地關心你，聊了很久之後提出要加Line，帶你一起投資賺錢。你的態度會是：",
            options: ["立馬檢舉，這是詐騙！", "謹慎投資，先投點小錢試試看"],
            correctAnswer: "立馬檢舉，這是詐騙！",
            explanation: "網路上認識後相約一起投資的，幾乎都是詐騙。遇到這種情況，請立刻向 SwiftiDate 檢舉。無論利潤多高多好，都不能相信。"
        ),
        QuizQuestion(
            text: "配對好友跟你聊了很久，某天約你在現實生活中見面，你也想去赴約，你會：",
            options: ["相約在咖啡廳、餐廳等公共場所所見面", "可以去他家裡見面"],
            correctAnswer: "相約在咖啡廳、餐廳等公共場所所見面",
            explanation: "第一次在線下見面盡量選擇公共場所。如果對方有任何讓你感覺不適的行為，要馬上離開。"
        )
    ]
    
    var body: some View {
        VStack {
            // Current question text and progress bar
            Text("第 \(currentQuestionIndex + 1) 題，共 \(questions.count) 題")
                .font(.headline)
                .padding()
            
            ProgressView(value: Double(currentQuestionIndex + 1), total: Double(questions.count))
                .padding(.horizontal, 40)
            
            Spacer()
            
            Text(questions[currentQuestionIndex].text)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            
            if showExplanation {
                ExplanationView(explanation: questions[currentQuestionIndex].explanation)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5))
            } else {
                if showMessage {
                    MessageView(isCorrect: selectedOption == questions[currentQuestionIndex].correctAnswer)
                }
                
                // Render question options
                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                    OptionButton(optionText: option, isSelected: selectedOption == option) {
                        selectedOption = option
                        showMessage = true
                        triggerExplanation()
                    }
                }
                .padding(.horizontal, 30)
            }
            
            Spacer()
            
            // "Next" button
            Button(action: moveToNextQuestion) {
                Text("下一題")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(showExplanation ? Color.green : Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
            .disabled(!showExplanation)
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }
    
    // Function to show the explanation after a delay
    func triggerExplanation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showExplanation = true
            showMessage = false
        }
    }
    
    // Function to move to the next question
    func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedOption = nil
            showExplanation = false
        } else {
            print("Quiz completed")
        }
    }
}

struct QuizQuestion {
    let text: String
    let options: [String]
    let correctAnswer: String
    let explanation: String
}

struct OptionButton: View {
    var optionText: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(optionText)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.green.opacity(0.2) : Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
                .foregroundColor(.black)
        }
    }
}

struct MessageView: View {
    var isCorrect: Bool
    
    var body: some View {
        Text(isCorrect ? "答對了！好厲害！" : "差一點點就能答對了！")
            .font(.headline)
            .foregroundColor(isCorrect ? Color.green : Color.red)
            .padding(.bottom, 10)
    }
}

struct ExplanationView: View {
    var explanation: String
    
    var body: some View {
        Text(explanation)
            .font(.body)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.green.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal, 30)
    }
}

struct SafetyQuizView_Previews: PreviewProvider {
    static var previews: some View {
        SafetyQuizView()
    }
}
