//
//  EditProfileView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI
import FirebaseStorage

struct EditProfileView: View {
    @State private var selectedTab = "編輯"
    @State private var photos = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6"]
    @State private var aboutMe = "能見面左右滑謝謝🙏\n一起吃日料吧🍣\n抽水煙也可以💨"
    @State private var currentPhotoIndex = 0
    
    @State private var selectedDegree: String? = "碩士及以上"  // 改为可选类型
    @State private var showDegreePicker = false // 新增
    let degrees = ["高中", "職校/專科", "學士", "碩士及以上", "其他學歷"] // 新增

    @State private var selectedSchool: String? = "台灣大學" // 新增
    @State private var showSchoolInput = false // 新增
    
    @State private var selectedIndustry: String? = "學生" // 新增
    @State private var showIndustryPicker = false // 新增
    
    @State private var selectedJob: String? = "自由接案者"
    @State private var showJobInput = false
    
    @State private var selectedHometown: String? = "台中"  // 当前选中的家乡
    @State private var showHometownInput = false  // 是否显示输入视图
    
    @State private var selectedLanguages: [String] = ["中文"]
    @State private var showLanguageSelection = false
    
    @State private var selectedHeight: Int? = 180
    @State private var showHeightPicker = false
    
    @State private var selectedZodiac: String = "巨蟹座"
    @State private var showZodiacPicker = false
    
    @State private var selectedBloodType: String? = "O型"
    @State private var showBloodTypePicker = false
    
    @State private var selectedLookingFor: String? = "穩定的關係"
    @State private var showLookingForView = false

    @State private var selectedPet: String? = "沒有寵物"
    @State private var showPetSelectionView = false

    @State private var selectedFitnessOption: String? = "經常健身"
    @State private var showFitnessOptions = false

    @State private var selectedSmokingOption: String? = "不抽煙"
    @State private var showSmokingOptions = false

    @State private var selectedDrinkOption: String? = "只在社交場合"
    @State private var showDrinkOptions = false

    @State private var selectedVacationOption: String? = "時間自己掌控"
    @State private var showVacationOptions = false

    @State private var selectedDietPreference: String? = "其他飲食偏好"
    @State private var showDietPreferences = false

    @State private var isShowingMeetWillingnessView = false  // 新增：控制是否顯示 MeetWillingnessView
    
    let industries = [
        "藝術/設計", "建築", "航空/交通運輸", "商業/金融", "傳播/媒體", "文創產業",
        "時尚/模特", "健身/體育", "自由業", "教育培訓", "工程技術", "政府機關",
        "醫療/醫藥", "律政行業", "市場營銷", "製造業", "NGO/慈善事業", "公眾關係",
        "銷售/零售業", "媒體傳播/自媒體", "社會工作者", "學生", "科技行業/科學研究",
        "旅遊業", "其他：新創/創業", "其他：自營企業", "其他行業"
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedInterests: Set<String> = []  // 用來追蹤選中的標籤
    @State private var interestColors: [String: Color] = [:]  // 新增 interestColors 變量
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("編輯個人資料", selection: $selectedTab) {
                    Text("編輯").tag("編輯")
                    Text("預覽").tag("預覽")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if selectedTab == "編輯" {
                    // 編輯界面
                    ScrollView {
                        VStack(spacing: 10) {
                            PhotoSectionView(photos: $photos) // Use updated PhotoSectionView
                                .padding()

                            Toggle(isOn: .constant(true)) {
                                Text("智慧照片曝光")
                            }
                            .padding()
                            
                            // 藍勾勾認證部分
                            VStack(alignment: .leading, spacing: 5) {
                                Text("真人認證")
                                    .font(.headline)
                                    .foregroundColor(.black) // 标题颜色为黑色
                                    .padding(.bottom, 5)

                                HStack {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                    Text("認證你的個人照片")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("已認證")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white) // 设置背景颜色为白色
                                .cornerRadius(10) // 设置圆角
                                .shadow(radius: 2) // 可选：添加阴影以突出显示框框
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(Color.clear) // 保持背景透明，以便显示框框效果
                            
                            VStack(alignment: .leading) {
                                Text("關於我")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                
                                TextEditor(text: $aboutMe)
                                    .frame(height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                            }
                            .padding()
                            
                            VStack(alignment: .leading) {
                                Text("線下見面")
                                    .font(.headline)
                                    .padding(.bottom, 5)

                                HStack {
                                    Image(systemName: "person.2.fill")
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                    Text("見面意願")
                                    Spacer()
                                    Text("已填寫")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .onTapGesture {
                                    // 設置狀態為 true，導航到 MeetWillingnessView
                                    isShowingMeetWillingnessView = true
                                }

                                // 隱藏的 NavigationLink，通過 isActive 控制導航
                                NavigationLink(
                                    destination: MeetWillingnessView(),
                                    isActive: $isShowingMeetWillingnessView,
                                    label: { EmptyView() }
                                )
                            }
                            .padding()

                            // 在這裡插入 InterestsView，並將隨機選中的6個興趣標籤傳遞給它
                            InterestsView(
                                interests: Array(selectedInterests.shuffled().prefix(6)),
                                selectedInterests: $selectedInterests,
                                interestColors: $interestColors  // 傳遞 interestColors 作為 @Binding
                            )
                            
                            // 我的標籤
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "tag.fill")
                                        .foregroundColor(.gray)
                                    Text("我的標籤")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("新增")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                    Image(systemName: "chevron.right") // 添加向右的箭头
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                            .padding()

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
                            
                            // 生活方式
                            VStack(alignment: .leading) {
                                Text("生活方式")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                    Text("想找")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let lookingFor = selectedLookingFor {
                                        Text(lookingFor)
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
                                    showLookingForView = true
                                }
                                .sheet(isPresented: $showLookingForView) {
                                    LookingForView(selectedLookingFor: $selectedLookingFor)
                                }
                                
                                HStack {
                                    Image(systemName: "pawprint")
                                        .foregroundColor(.gray)
                                    Text("寵物")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let pet = selectedPet {
                                        Text(pet)
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
                                    showPetSelectionView = true
                                }
                                .sheet(isPresented: $showPetSelectionView) {
                                    PetSelectionView(selectedPet: $selectedPet)
                                }

                                HStack {
                                    Image(systemName: "dumbbell")
                                        .foregroundColor(.gray)
                                    Text("健身")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let option = selectedFitnessOption {
                                        Text(option)
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
                                    showFitnessOptions = true
                                }
                                .sheet(isPresented: $showFitnessOptions) {
                                    FitnessOptionsView(selectedFitnessOption: $selectedFitnessOption)
                                }

                                HStack {
                                    Image("smoking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24) // 调整大小以适应你的设计
                                    Text("抽煙")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let option = selectedSmokingOption {
                                        Text(option)
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
                                    showSmokingOptions = true
                                }
                                .sheet(isPresented: $showSmokingOptions) {
                                    SmokingOptionsView(selectedSmokingOption: $selectedSmokingOption)
                                }

                                HStack {
                                    Image(systemName: "wineglass.fill")
                                        .foregroundColor(.gray)
                                    Text("喝酒")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let option = selectedDrinkOption {
                                        Text(option)
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
                                    showDrinkOptions = true
                                }
                                .sheet(isPresented: $showDrinkOptions) {
                                    DrinkOptionsView(selectedDrinkOption: $selectedDrinkOption)
                                }

                                HStack {
                                    Image(systemName: "tree.fill")
                                        .foregroundColor(.gray)
                                    Text("休假日")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let option = selectedVacationOption {
                                        Text(option)
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
                                    showVacationOptions = true
                                }
                                .sheet(isPresented: $showVacationOptions) {
                                    VacationOptionsView(selectedVacationOption: $selectedVacationOption)
                                }

                                HStack {
                                    Image(systemName: "fork.knife")
                                        .foregroundColor(.gray)
                                    Text("飲食習慣")
                                        .font(.headline)
                                        .padding(.bottom, 5)
                                    Spacer()
                                    if let option = selectedDietPreference {
                                        Text(option)
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
                                    showDietPreferences = true
                                }
                                .sheet(isPresented: $showDietPreferences) {
                                    DietPreferencesView(selectedDietPreference: $selectedDietPreference)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .background(Color.gray.opacity(0.1)) // 设置背景颜色为淡灰色
                } else {
                    // 預覽界面
                    ZStack(alignment: .bottomLeading) {
                        // 使用最大宽度和高度，同时保留圆角效果
                        Image(photos[currentPhotoIndex])
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 380, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 25)) // 设置圆角
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4)) // 可选：加一个白色边框
                            .edgesIgnoringSafeArea(.top) // 使图片扩展到顶部
                            .onTapGesture { location in
                                // 根据点击位置确定是否切换到上一张或下一张
                                let halfWidth = UIScreen.main.bounds.width / 2
                                if location.x < halfWidth {
                                    // 左半部分点击，显示上一张图片
                                    if currentPhotoIndex > 0 {
                                        currentPhotoIndex -= 1
                                    }
                                } else {
                                    // 右半部分点击，显示下一张图片
                                    if currentPhotoIndex < photos.count - 1 {
                                        currentPhotoIndex += 1
                                    }
                                }
                            }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 5) {
                                ForEach(0..<photos.count) { index in
                                    RoundedRectangle(cornerRadius: 4) // 使用圆角矩形代替圆形
                                        .frame(width: 40, height: 8) // 调整宽度和高度，使其成为一个拉长的圆角矩形
                                        .foregroundColor(index == currentPhotoIndex ? .white : .gray)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center) // 将 HStack 置中
                            .padding(.vertical, 8) // 调整垂直内边距，确保圆点在中央
                            .padding(.horizontal)
                            .cornerRadius(10) // 设置背景圆角
                            
                            Spacer()
                            
                            Text("玩玩, 25")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white) // 文字颜色为白色以与背景形成对比
                            
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                Text("巨蟹座 · 新竹市 · 自由接案者")
                                    .foregroundColor(.white) // 文字颜色为白色以与背景形成对比
                            }
                            .font(.subheadline)
                            
                            Text(aboutMe)
                                .font(.body)
                                .foregroundColor(.white) // 文字颜色为白色以与背景形成对比
                                .padding(.top)
                        }
                        .padding() // 给文字一些内边距
                    }
                }
            }
            .navigationBarTitle("編輯個人資料", displayMode: .inline)
            .navigationBarItems(trailing: Button("保存") {
                // 保存操作
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    // Fetch photos from Firebase Storage
    func fetchPhotosFromFirebase() {
        print("Fetching photos from Firebase started")
        photos.removeAll() // Clear existing photos before fetching
        
        let storage = Storage.storage()
        let userID = "userID_1" // Replace this with the current user ID
        let storageRef = storage.reference().child("user_photos/\(userID)")

        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error fetching photos: \(error)")
                return
            }

            // Safely unwrap the result
            guard let result = result else {
                print("Failed to fetch the result")
                return
            }

            for item in result.items {
                item.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }

                    if let url = url {
                        DispatchQueue.main.async {
                            self.photos.append(url.absoluteString)
                            print("Fetched photo URL: \(url.absoluteString)")
                        }
                    }
                }
            }
        }
    }
    
    func savePhotosToLocalStorage() {
        for (index, photo) in photos.enumerated() {
            if let image = loadImageFromURL(photo) {
                let imageName = "photo_\(index).jpg" // Give the image a unique name
                saveImageToLocalStorage(image: image, withName: imageName)
                print("Saved photo \(index) to local storage")
            }
        }
    }
    
    // Save image to local storage
    func saveImageToLocalStorage(image: UIImage, withName imageName: String) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: url)
            print("Image saved to local storage at \(url.path)")
        }
    }
    
    // Load UIImage from a URL string
    func loadImageFromURL(_ urlString: String) -> UIImage? {
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }

    
    // Helper function to get the app's document directory
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(selectedInterests: ["我喜歡Cosply", "咒術迴戰", "死神", "基本可以做到訊息秒回", "是個理性的人", "有上進心", "我是巨蟹座"])
    }
}

extension EditProfileView {
    init(selectedInterests: Set<String>) {
        _selectedInterests = State(initialValue: selectedInterests)
        _interestColors = State(initialValue: [:]) // 初始化為空字典
    }
}
