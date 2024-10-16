//
//  EducationAndWorkView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/16.
//

import Foundation
import SwiftUI

// 教育與工作子視圖
struct EducationAndWorkView: View {
    @Binding var selectedDegree: String?
    @Binding var selectedSchool: String?
    @Binding var selectedIndustry: String?
    @Binding var selectedJob: String?
    
    @Binding var showDegreePicker: Bool
    @Binding var showSchoolInput: Bool
    @Binding var showIndustryPicker: Bool
    @Binding var showJobInput: Bool
    
    let degrees: [String]
    let industries: [String]
    
    var body: some View {
        // 工作與學歷
        VStack(alignment: .leading) {
            Text("工作與學歷")
                .font(.headline)
                .padding(.bottom, 5)

            HStack {
                Image(systemName: "graduationcap.fill")
                    .foregroundColor(.gray)
                Text("學歷")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let selectedDegree = selectedDegree {
                    Text(selectedDegree)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green) // 未选择时显示绿色的“新增”
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showDegreePicker = true // 点击时显示学历选择
            }
            .sheet(isPresented: $showDegreePicker) {
                DegreePicker(selectedDegree: $selectedDegree, degrees: degrees)
            }
            
            HStack {
                Image("school_icon") // 假设你的图标命名为 "school_icon"
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // 调整大小以适应你的设计
                Text("學校")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let selectedSchool = selectedSchool {
                    Text(selectedSchool)
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
                showSchoolInput = true
            }
            .sheet(isPresented: $showSchoolInput) {
                SchoolInputView(selectedSchool: $selectedSchool)
            }
            
            HStack {
                Image(systemName: "building.fill")
                    .foregroundColor(.gray)
                Text("工作行業")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                Text(selectedIndustry ?? "未選擇")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showIndustryPicker = true // 显示行业选择页面
            }
            .sheet(isPresented: $showIndustryPicker) {
                IndustryPicker(selectedIndustry: $selectedIndustry, industries: industries)
            }
            
            HStack {
                Image(systemName: "building.fill")
                    .foregroundColor(.gray)
                Text("職業")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                Text(selectedJob ?? "新增")
                    .font(.subheadline)
                    .foregroundColor(selectedJob != nil ? .gray : .green)
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showJobInput = true // 点击时显示职业输入页面
            }
            .sheet(isPresented: $showJobInput) {
                JobInputView(selectedJob: $selectedJob)
            }
        }
        .padding(.horizontal)
    }
}
