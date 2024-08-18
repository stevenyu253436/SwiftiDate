//
//  DietPreferencesView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/20.
//

import Foundation
import SwiftUI

struct DietPreferencesView: View {
    @Binding var selectedDietPreference: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("你有任何飲食上的偏好嗎？")
                .font(.headline)
                .padding()

            // List of diet preferences
            ForEach(["從不挑食", "純素主義", "素食", "潔食", "清真", "其他飲食偏好"], id: \.self) { option in
                Button(action: {
                    selectedDietPreference = option
                }) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedDietPreference == option ? Color.green : Color.clear)
                        .foregroundColor(selectedDietPreference == option ? .white : .primary)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }

            Spacer()

            // Clear and Confirm buttons
            HStack {
                Button(action: {
                    selectedDietPreference = nil // Clear the selection
                }) {
                    Text("清空")
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Confirm and dismiss the view
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
