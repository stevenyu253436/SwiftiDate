//
//  EditProfileView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI
import FirebaseStorage

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct EditProfileView: View {
    @EnvironmentObject var userSettings: UserSettings // 使用 EnvironmentObject 存取 UserSettings
    
    @State private var selectedTab = "編輯"
    @Binding var photos: [String] // Change photos to a Binding variable
    @State private var deletedPhotos: [String] = [] // 用來存放被刪除的照片URL
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

    @State private var selectedMeetWillingness: String? = nil  // 用來存儲選中的見面意願
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
    
    // Custom initializer with optional selectedInterests
    init(photos: Binding<[String]>, selectedInterests: Set<String> = []) {
        _photos = photos // Initialize with the binding
        _selectedInterests = State(initialValue: selectedInterests)
        _interestColors = State(initialValue: [:]) // 初始化為空字典
    }

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
                            PhotoSectionView(photos: $photos, deletedPhotos: $deletedPhotos) // Pass both bindings
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
                                // 使用 fullScreenCover 傳遞 selectedMeetWillingness 作為 @Binding
                                .fullScreenCover(isPresented: $isShowingMeetWillingnessView) {
                                    MeetWillingnessView(isPresented: $isShowingMeetWillingnessView, selectedOption: $selectedMeetWillingness)  // 傳遞選擇的見面意願
                                }
                            }
                            .padding()

                            // 在這裡插入 InterestsView，並將隨機選中的6個興趣標籤傳遞給它
                            InterestsView(
                                interests: Array(selectedInterests.shuffled().prefix(6)),
                                selectedInterests: $selectedInterests,
                                interestColors: $interestColors  // 傳遞 interestColors 作為 @Binding
                            )
                            
                            EducationAndWorkView(
                                selectedDegree: $selectedDegree,
                                selectedSchool: $selectedSchool,
                                selectedIndustry: $selectedIndustry,
                                selectedJob: $selectedJob,
                                showDegreePicker: $showDegreePicker,
                                showSchoolInput: $showSchoolInput,
                                showIndustryPicker: $showIndustryPicker,
                                showJobInput: $showJobInput,
                                degrees: degrees,
                                industries: industries
                            )
                            
                            BasicInfoView(
                                selectedHometown: $selectedHometown,
                                showHometownInput: $showHometownInput,
                                selectedLanguages: $selectedLanguages,
                                showLanguageSelection: $showLanguageSelection,
                                selectedHeight: $selectedHeight,
                                showHeightPicker: $showHeightPicker,
                                selectedZodiac: $selectedZodiac,
                                showZodiacPicker: $showZodiacPicker,
                                selectedBloodType: $selectedBloodType,
                                showBloodTypePicker: $showBloodTypePicker
                            )
                            
                            LifestyleView(
                                selectedLookingFor: $selectedLookingFor,
                                showLookingForView: $showLookingForView,
                                selectedPet: $selectedPet,
                                showPetSelectionView: $showPetSelectionView,
                                selectedFitnessOption: $selectedFitnessOption,
                                showFitnessOptions: $showFitnessOptions,
                                selectedSmokingOption: $selectedSmokingOption,
                                showSmokingOptions: $showSmokingOptions,
                                selectedDrinkOption: $selectedDrinkOption,
                                showDrinkOptions: $showDrinkOptions,
                                selectedVacationOption: $selectedVacationOption,
                                showVacationOptions: $showVacationOptions,
                                selectedDietPreference: $selectedDietPreference,
                                showDietPreferences: $showDietPreferences
                            )
                        }
                    }
                    .background(Color.gray.opacity(0.1)) // 设置背景颜色为淡灰色
                } else {
                    // 預覽界面
                    ZStack {
                        if let imageName = photos.indices.contains(currentPhotoIndex) ? photos[currentPhotoIndex] : nil,
                           let image = loadImageFromLocalStorage(named: imageName) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 420, maxHeight: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4))
                                .edgesIgnoringSafeArea(.top)
                        } else {
                            // Display a placeholder or error image
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }

                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 5) {
                                ForEach(0..<photos.count) { index in
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 40, height: 8)
                                        .foregroundColor(index == currentPhotoIndex ? .white : .gray)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .cornerRadius(10)
                            
                            Spacer()
                            
                            Text("\(userSettings.globalUserName), 25") // 使用 userSettings 來存取 globalUserName
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                Text("巨蟹座 · 新竹市 · 自由接案者")
                                    .foregroundColor(.white)
                            }
                            .font(.subheadline)
                            
                            Text(aboutMe)
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.top)
                        }
                        .padding()
                        
                        // Add a transparent layer for tap detection
                        GeometryReader { geometry in
                            HStack {
                                // Left half tap gesture
                                Rectangle()
                                    .fill(Color.clear)
                                    .contentShape(Rectangle()) // Make the whole area tappable
                                    .frame(width: geometry.size.width / 2)
                                    .onTapGesture {
                                        // Decrease index if not at the first photo
                                        if currentPhotoIndex > 0 {
                                            currentPhotoIndex -= 1
                                        }
                                    }
                                
                                // Right half tap gesture
                                Rectangle()
                                    .fill(Color.clear)
                                    .contentShape(Rectangle()) // Make the whole area tappable
                                    .frame(width: geometry.size.width / 2)
                                    .onTapGesture {
                                        // Increase index if not at the last photo
                                        if currentPhotoIndex < photos.count - 1 {
                                            currentPhotoIndex += 1
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("編輯個人資料", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    // 將 deletedPhotos 中的照片移回到 photos
                    deletedPhotos.sort(by: >) // 逆序排序
                    photos.append(contentsOf: deletedPhotos)
                    deletedPhotos.removeAll() // 清空 deletedPhotos
                    
                    // Custom action to go back
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                    }
                },
                trailing: Button("保存") {
                    // 遍歷 deletedPhotos，逐一從 Firebase 刪除
                    for photoURL in deletedPhotos {
                        deletePhotoFromFirebase(photoURL: photoURL)
                    }
                    
                    // 上傳新添加的照片到 Firebase
                    uploadNewPhotosToFirebase()

                    // 完成後返回到上一頁
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    // 從本地加載圖片
    func loadImageFromLocalStorage(named imageName: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(imageName)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    // 獲取文件目錄
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // 上傳新照片到 Firebase 的函數
    func uploadNewPhotosToFirebase() {
        let storage = Storage.storage()
        let userID = userSettings.globalUserID // 假設從 UserSettings 取得用戶 ID
        let storageRef = storage.reference().child("user_photos/\(userID)")

        // 找出需要上傳的照片
        for (index, photoName) in photos.enumerated() {
            let expectedPhotoName = "photo\(index + 1)" // 期待的照片名稱格式
            
            if !isPhotoAlreadyUploaded(photoName: photoName) {
                // 如果照片還沒有上傳過
                if let localImage = loadImageFromLocalStorage(named: photoName),
                   let imageData = localImage.jpegData(compressionQuality: 0.8) {
                    
                    let photoRef = storageRef.child("\(expectedPhotoName).jpeg") // Firebase 儲存名稱
                    
                    let uploadTask = photoRef.putData(imageData, metadata: nil) { (metadata, error) in
                        if let error = error {
                            print("Failed to upload photo: \(error.localizedDescription)")
                        } else {
                            print("Photo \(expectedPhotoName) uploaded successfully.")
                        }
                    }
                    
                    // 可選：監聽上傳進度
                    uploadTask.observe(.progress) { snapshot in
                        let percentComplete = 100.0 * Double(snapshot.progress?.completedUnitCount ?? 0) / Double(snapshot.progress?.totalUnitCount ?? 0)
                        print("Upload is \(percentComplete)% complete.")
                    }
                }
            }
        }
    }

    // 檢查照片是否已經上傳的輔助函數
    func isPhotoAlreadyUploaded(photoName: String) -> Bool {
        // 假設所有 Firebase 上傳的照片都以 "photo" 開頭
        return photoName.starts(with: "photo")
    }
    
    // 刪除 Firebase Storage 中的照片
    func deletePhotoFromFirebase(photoURL: String) {
        // 創建 Storage 引用
        let storageRef = Storage.storage().reference(forURL: photoURL)
        
        // 調用 delete 方法來刪除圖片
        storageRef.delete { error in
            if let error = error {
                print("Failed to delete photo: \(error.localizedDescription)")
            } else {
                print("Photo deleted successfully from Firebase: \(photoURL)")
                
                // 同時刪除本地存儲中的圖片
                if let imageName = self.extractImageName(from: photoURL) {
                    self.deleteImageFromLocalStorage(named: imageName)
                }
            }
        }
    }
    
    // 從本地存儲刪除圖片
    func deleteImageFromLocalStorage(named imageName: String) {
        let fileManager = FileManager.default
        let fileURL = getDocumentsDirectory().appendingPathComponent(imageName)
        
        do {
            try fileManager.removeItem(at: fileURL)
            print("Photo deleted successfully from local storage: \(imageName)")
        } catch {
            print("Failed to delete photo from local storage: \(error.localizedDescription)")
        }
    }

    // 從 Firebase URL 中提取圖片名稱
    func extractImageName(from url: String) -> String? {
        return URL(string: url)?.lastPathComponent
    }
}

struct EditProfileView_Previews: PreviewProvider {
    @State static var mockPhotos = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6"]
    
    static var previews: some View {
        EditProfileView(photos: $mockPhotos, selectedInterests: ["我喜歡Cosply", "咒術迴戰", "死神", "基本可以做到訊息秒回", "是個理性的人", "有上進心", "我是巨蟹座"]) // Pass selectedInterests first
    }
}
