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

struct EducationAndWorkView_Previews: PreviewProvider {
    @State static var mockSelectedDegree: String? = "碩士及以上"
    @State static var mockSelectedSchool: String? = "台灣大學"
    @State static var mockSelectedIndustry: String? = "學生"
    @State static var mockSelectedJob: String? = "自由接案者"
    
    @State static var mockShowDegreePicker = false
    @State static var mockShowSchoolInput = false
    @State static var mockShowIndustryPicker = false
    @State static var mockShowJobInput = false
    
    static var mockDegrees = ["高中", "職校/專科", "學士", "碩士及以上", "其他學歷"]
    static var mockIndustries = [
        "藝術/設計", "建築", "航空/交通運輸", "商業/金融", "傳播/媒體", "文創產業",
        "時尚/模特", "健身/體育", "自由業", "教育培訓", "工程技術", "政府機關",
        "醫療/醫藥", "律政行業", "市場營銷", "製造業", "NGO/慈善事業", "公眾關係",
        "銷售/零售業", "媒體傳播/自媒體", "社會工作者", "學生", "科技行業/科學研究",
        "旅遊業", "其他：新創/創業", "其他：自營企業", "其他行業"
    ]
    
    static var previews: some View {
        EducationAndWorkView(
            selectedDegree: $mockSelectedDegree,
            selectedSchool: $mockSelectedSchool,
            selectedIndustry: $mockSelectedIndustry,
            selectedJob: $mockSelectedJob,
            showDegreePicker: $mockShowDegreePicker,
            showSchoolInput: $mockShowSchoolInput,
            showIndustryPicker: $mockShowIndustryPicker,
            showJobInput: $mockShowJobInput,
            degrees: mockDegrees,
            industries: mockIndustries
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
