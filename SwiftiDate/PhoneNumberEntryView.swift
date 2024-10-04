//
//  PhoneNumberEntryView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/4.
//

import Foundation
import SwiftUI

struct PhoneNumberEntryView: View {
    @Binding var isRegistering: Bool // Binding variable to control view navigation
    @State private var isShowingCountryCodePicker = false
    @State private var selectedCountryCode: String = "+886" // 預設為台灣國碼
    @State private var phoneNumber: String = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Handle Back Action (Pop to previous view)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .padding(.leading)
                }
                Spacer()
            }
            .padding(.top)
            
            Text("你的手機號碼是？")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            Text("註冊或登錄需要輸入你的手機號碼")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            HStack {
                Button(action: {
                    isShowingCountryCodePicker.toggle() // 點擊顯示國碼選擇器
                }) {
                    HStack {
                        Text(selectedCountryCode) // 顯示選中的國碼
                            .font(.title2)
                            .foregroundColor(.black) // 設置文字顏色為黑色
                        Image(systemName: "chevron.down") // 向下箭頭圖示
                            .font(.system(size: 16))
                            .foregroundColor(.gray.opacity(0.7)) // 設置圖示顏色為黑色
                    }
                    .font(.title2)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                TextField("", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .font(.title2)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "phone")
                    .foregroundColor(.gray) // You can change the color to your preference
                Text("請確認你的手機號碼為目前正在使用的手機號碼！")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "umbrella.fill")
                Text("我們不會將該資訊分享給任何人，你的手機號碼也不會出現在你的個人首頁")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            Button(action: {
                // Handle Continue Action
            }) {
                Text("繼續")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(25)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: $isShowingCountryCodePicker) {
            CountryCodePickerView(selectedCountryCode: $selectedCountryCode)
        }
    }
}

struct CountryCodePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCountryCode: String
    
    let countryCodes = ["+1", "+44", "+81", "+86", "+886"] // 示例國碼

    var body: some View {
        VStack {
            // 顯示左上角的返回按鈕
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // 返回上一頁
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            
            Text("選擇國家代碼")
                .font(.largeTitle)
                .padding()

            List(countryCodes, id: \.self) { code in
                Button(action: {
                    selectedCountryCode = code // 更新選中的國碼
                    presentationMode.wrappedValue.dismiss() // 關閉選擇器
                }) {
                    Text(code)
                        .font(.title2)
                        .padding()
                }
            }
            .listStyle(GroupedListStyle()) // 設定 GroupedListStyle
        }
    }
}

struct PhoneNumberEntryView_Previews: PreviewProvider {
    @State static var isRegistering = true
    
    static var previews: some View {
        PhoneNumberEntryView(isRegistering: $isRegistering)
            .previewDevice("iPhone 15 Pro")
    }
}
