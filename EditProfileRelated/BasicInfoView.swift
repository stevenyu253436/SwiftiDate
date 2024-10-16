//
//  BasicInfoView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/16.
//

import Foundation
import SwiftUI

struct BasicInfoView: View {
    @Binding var selectedHometown: String?
    @Binding var showHometownInput: Bool
    @Binding var selectedLanguages: [String]
    @Binding var showLanguageSelection: Bool
    @Binding var selectedHeight: Int?
    @Binding var showHeightPicker: Bool
    @Binding var selectedZodiac: String
    @Binding var showZodiacPicker: Bool
    @Binding var selectedBloodType: String?
    @Binding var showBloodTypePicker: Bool
    
    var body: some View {
        // 基本資料
        VStack(alignment: .leading) {
            Text("基本資料")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "house.fill")
                    .foregroundColor(.gray)
                Text("來自")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let selectedHometown = selectedHometown {
                    Text(selectedHometown)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showHometownInput = true  // 点击时显示家乡输入页面
            }
            .sheet(isPresented: $showHometownInput) {
                HometownInputView(selectedHometown: $selectedHometown)
            }
            
            HStack {
                Image(systemName: "globe")
                    .foregroundColor(.gray)
                Text("語言")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                Text(selectedLanguages.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showLanguageSelection = true
            }
            .sheet(isPresented: $showLanguageSelection) {
                LanguageSelectionView(selectedLanguages: $selectedLanguages)
            }
            
            HStack {
                Image(systemName: "ruler.fill")
                    .foregroundColor(.gray)
                Text("身高")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                Text("\(selectedHeight ?? 170) cm")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showHeightPicker = true // 点击时显示身高选择页面
            }
            .sheet(isPresented: $showHeightPicker) {
                HeightPickerView(selectedHeight: $selectedHeight)
            }
            
            HStack {
                Image("zodiac_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // 调整大小以适应你的设计
                Text("星座")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if selectedZodiac.isEmpty {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                } else {
                    Text(selectedZodiac)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showZodiacPicker = true // 点击时显示星座选择页面
            }
            .sheet(isPresented: $showZodiacPicker) {
                ZodiacPickerView(selectedZodiac: $selectedZodiac)
            }
            
            HStack {
                Image("blood_type_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // 调整大小以适应你的设计
                Text("血型")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let bloodType = selectedBloodType {
                    Text(bloodType)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showBloodTypePicker = true // 点击时显示血型选择页面
            }
            .sheet(isPresented: $showBloodTypePicker) {
                BloodTypePickerView(selectedBloodType: $selectedBloodType)
            }
        }
        .padding(.horizontal)
    }
}

struct BasicInfoView_Previews: PreviewProvider {
    @State static var mockSelectedHometown: String? = "台中"
    @State static var mockShowHometownInput = false
    @State static var mockSelectedLanguages: [String] = ["中文"]
    @State static var mockShowLanguageSelection = false
    @State static var mockSelectedHeight: Int? = 175
    @State static var mockShowHeightPicker = false
    @State static var mockSelectedZodiac = "巨蟹座"
    @State static var mockShowZodiacPicker = false
    @State static var mockSelectedBloodType: String? = "O型"
    @State static var mockShowBloodTypePicker = false

    static var previews: some View {
        BasicInfoView(
            selectedHometown: $mockSelectedHometown,
            showHometownInput: $mockShowHometownInput,
            selectedLanguages: $mockSelectedLanguages,
            showLanguageSelection: $mockShowLanguageSelection,
            selectedHeight: $mockSelectedHeight,
            showHeightPicker: $mockShowHeightPicker,
            selectedZodiac: $mockSelectedZodiac,
            showZodiacPicker: $mockShowZodiacPicker,
            selectedBloodType: $mockSelectedBloodType,
            showBloodTypePicker: $mockShowBloodTypePicker
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
