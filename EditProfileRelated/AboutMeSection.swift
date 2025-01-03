//
//  AboutMeSection.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/17.
//

import Foundation
import SwiftUI

// 關於我區域
struct AboutMeSection: View {
    @Binding var aboutMe: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("關於我")
                .font(.headline)
                .padding(.bottom, 5)
            
            TextEditor(text: $aboutMe)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
        }
        .padding()
    }
}
