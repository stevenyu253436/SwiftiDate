//
//  DrinkOptionsView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/20.
//

import Foundation
import SwiftUI

struct DrinkOptionsView: View {
    @Binding var selectedDrinkOption: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("你喝酒嗎？")
                .font(.headline)
                .padding()

            ForEach(["只在社交場合", "不喝酒", "經常", "有時候"], id: \.self) { option in
                Button(action: {
                    selectedDrinkOption = option
                }) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedDrinkOption == option ? Color.green : Color.clear)
                        .foregroundColor(selectedDrinkOption == option ? .white : .primary)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }

            Spacer()

            HStack {
                Button(action: {
                    selectedDrinkOption = nil
                }) {
                    Text("清空")
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                }
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
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
    }
}
