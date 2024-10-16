//
//  ProfileView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI
import FirebaseStorage

extension Color {
    static let gold = Color(red: 212 / 255, green: 175 / 255, blue: 55 / 255) // Custom gold color
}

struct ProfileView: View {
    @EnvironmentObject var userSettings: UserSettings // 使用 EnvironmentObject 存取 UserSettings
    
    @State private var userRankPercentage: Double = 25.4
    @State private var isShowingInfoPopup = false // State to show/hide the popup
    @State private var isShowingTurboView = false
    @State private var selectedTab: Int = 0 // State to control which tab is selected in TurboView
    @Binding var contentSelectedTab: Int // Use a binding variable for selectedTab from ContentView
    @State private var isShowingTurboPurchaseView = false // State variable to control the sheet presentation
    @State private var isShowingCrushPurchaseView = false // State variable to control Crush sheet presentation
    @State private var isShowingPraisePurchaseView = false // State variable to control Praise sheet presentation
    @State private var isShowingEditProfileView = false // State to show EditProfileView
    @State private var showSettingsView = false // State variable to control Settings View presentation
    @State private var showSafetyCenterView = false // 控制 SafetyCenterView 的顯示
    @State private var photos: [String] = [] // Local state variable for photos

    var body: some View {
        if showSettingsView {
            SettingsView(showSettingsView: $showSettingsView) // Pass the binding to the SettingsView
        } else if showSafetyCenterView {
            SafetyCenterView(showSafetyCenterView: $showSafetyCenterView) // 如果全局变量为 true，则显示 SafetyCenterView
        } else {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        // 头像及基本信息
                        HStack {
                            if let firstPhotoName = photos.first, let image = PhotoUtility.loadImageFromLocalStorage(named: firstPhotoName) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 133)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                            } else {
                                // 顯示預設的佔位符圖片
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 133)
                                    .foregroundColor(.gray)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                            }

                            Button(action: {
                                isShowingEditProfileView = true // Show EditProfileView
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue) // 改變圖標顏色來確保對比
                                    .background(Color.white) // 可選，如果不需要可以去掉
                                    .clipShape(Circle())
                                    .shadow(color: .gray, radius: 4, x: 0, y: 2) // 加強陰影效果
                            }
                            .offset(x: -25, y: -25) // 调整按钮的位置
                            .fullScreenCover(isPresented: $isShowingEditProfileView) {
                                EditProfileView(photos: $photos) // Pass both photos and selectedInterests
                            }

                            VStack(alignment: .leading) {
                                HStack {
                                    Text(userSettings.globalUserName) // 使用 userSettings 來存取 globalUserName
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    if userSettings.isSupremeUser {
                                        Image(systemName: "crown.fill") // Adding the crown icon
                                            .foregroundColor(.gold) // Matching the gold color
                                            .font(.system(size: 18)) // Adjust the size as needed
                                    }
                                }
                                
                                if userSettings.globalIsUserVerified { // 使用 userSettings 來存取 globalIsUserVerified
                                    HStack {
                                        Image(systemName: "checkmark.seal.fill")
                                            .foregroundColor(.blue)
                                        Text("已認證")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding()

                        // 统计信息
                        HStack(spacing: 50) {
                            Button(action: {
                                selectedTab = 0 // Set selectedTab to 0 for "喜歡我的人"
                                isShowingTurboView = true // Set state to true to show TurboView
                            }) {
                                VStack {
                                    Text(userSettings.globalLikesMeCount >= 99 ? "99+" : "\(userSettings.globalLikesMeCount)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black) // 設置文字顏色為黑色
                                    Text("喜歡我")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            Button(action: {
                                selectedTab = 1 // Set selectedTab to 1 for "我的心動對象"
                                isShowingTurboView = true // Show TurboView
                            }) {
                                VStack {
                                    Text(userSettings.globalLikeCount > 99 ? "99+" : "\(userSettings.globalLikeCount)") // Display based on the like count
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black) // 設置文字顏色為黑色
                                    Text("我喜歡")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            VStack {
                                Text("5")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black) // 設置文字顏色為黑色
                                Text("精選")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal)
                        .fullScreenCover(isPresented: $isShowingTurboView) {
                            TurboView(contentSelectedTab: $contentSelectedTab, turboSelectedTab: $selectedTab, showBackButton: true, onBack: {
                                isShowingTurboView = false // Close the fullScreenCover when back button is pressed
                            })
                        }
                        
                        if userSettings.isProfilePhotoVerified {
                            // 成就进度条
                            VStack {
                                HStack {
                                    Text("打敗 \(String(format: "%.1f", userRankPercentage))%")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    
                                    // Add the question mark icon with tap gesture
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.green)
                                        .onTapGesture {
                                            isShowingInfoPopup = true // Show the popup when tapped
                                        }
                                }
                                .padding(.bottom, 5)

                                ProgressView(value: userRankPercentage / 100) // Convert the percentage to a fraction
                                    .progressViewStyle(LinearProgressViewStyle(tint: .green))
                                    .scaleEffect(x: 1, y: 4, anchor: .center)
                            }
                            .padding(.horizontal)
                        } else {
                            // 當頭像未通過驗證時，顯示提示視圖
                            HStack {
                                ZStack {
                                    if let firstPhotoName = photos.first, let image = PhotoUtility.loadImageFromLocalStorage(named: firstPhotoName) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(Color.white, lineWidth: 2)
                                            )
                                    } else {
                                        // 顯示預設的佔位符圖片
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.gray)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle().stroke(Color.white, lineWidth: 2)
                                            )
                                    }
                                    
                                    // 顯示 xmark，在圖像的上方
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Image(systemName: "xmark")
                                                .foregroundColor(.white)
                                        )
                                        .offset(x: 20, y: 20) // 調整 x 和 y 的偏移量，使其位於圖像上方
                                }
                                
                                Text("請更換頭像照片後再查看喜歡數排名")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                
                                Spacer()
                                
                                Image(systemName: "lock.fill")
                                    .resizable()
                                    .frame(width: 24, height: 30)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        // Turbo, Crush, 讚美
                        HStack(spacing: 20) {
                            AchievementCardView(title: "TURBO", count: userSettings.globalTurboCount, color: Color.purple) {
                                isShowingTurboPurchaseView = true // Set the state to show the TurboPurchaseView
                            }
                            AchievementCardView(title: "CRUSH", count: userSettings.globalCrushCount, color: Color.green) {
                                isShowingCrushPurchaseView = true // Show CrushPurchaseView
                            }
                            AchievementCardView(title: "讚美", count: userSettings.globalPraiseCount, color: Color.orange) {
                                isShowingPraisePurchaseView = true // Show PraisePurchaseView
                            }
                        }
                        .padding(.horizontal)
                        .sheet(isPresented: $isShowingTurboPurchaseView) {
                            TurboPurchaseView()
                        }
                        .sheet(isPresented: $isShowingCrushPurchaseView) {
                            CrushPurchaseView()
                        }
                        .sheet(isPresented: $isShowingPraisePurchaseView) {
                            PraisePurchaseView() // Present PraisePurchaseView when isShowingPraisePurchaseView is true
                        }
                        
                        // Display Supreme banner if the user has purchased Supreme
                        if userSettings.isSupremeUser {
                            HStack {
                                Image(systemName: "crown.fill") // Adding the crown icon
                                    .foregroundColor(.gold) // Matching the gold color
                                    .font(.system(size: 18)) // Adjust the size as needed
                                
                                VStack(alignment: .leading) {
                                    Text("SwiftiDate Supreme")
                                        .font(.headline)
                                        .foregroundColor(.gold) // Set text color to gold
                                        .fontWeight(.bold)
                                    
                                    Text("已開啟 SwiftiDate 所有特權")
                                        .font(.subheadline)
                                        .foregroundColor(.gold)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                            // 服務項目
                            VStack(alignment: .leading, spacing: 10) {
                                // Service Section Title
                                HStack {
                                    Text("服務項目")
                                        .font(.headline)
                                        .padding(.top)

                                    Spacer() // This spacer will push the next text to the right side

                                    VStack(alignment: .trailing) {
                                        Text("Supreme")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)

                                        Text("16項特權")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal)

                                // Service sections
                                ServiceSectionView(
                                    sectionTitle: "更快篩選對的人",
                                    totalItems: 4,
                                    services: [
                                        ("附近的人", true, nil),
                                        ("高級篩選", true, nil),
                                        ("每日精選", true, nil),
                                        ("額外的喜歡次數", false, "∞")
                                    ]
                                )
                                
                                // Adding the "獲取更多配對" ServiceSectionView
                                ServiceSectionView(
                                    sectionTitle: "獲取更多配對",
                                    totalItems: 7,
                                    services: [
                                        ("免費讚美", true, "3/天"),
                                        ("免費的Crush", true, "5/天"),
                                        ("免費Turbo", true, "1/月"),
                                        ("看看誰喜歡你", true, nil),
                                        ("開啟心動列表", true, nil),
                                        ("免費的反悔機會", false, "∞"),
                                        ("找回已解除的配對", true, nil)
                                    ]
                                )
                                
                                // Adding the "升級體驗" ServiceSectionView
                                ServiceSectionView(
                                    sectionTitle: "升級體驗",
                                    totalItems: 5,
                                    services: [
                                        ("隱身模式", true, nil),
                                        ("24小時專屬客服", true, nil),
                                        ("已讀回執", true, nil),
                                        ("專屬會員標誌", true, nil),
                                        ("不限次數的「緣分合盤」解讀", true, nil)
                                    ]
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                }
                .onAppear {
                    loadPhotosFromAppStorage()
                }

                // Gear icon in the top-right corner
                VStack {
                    HStack {
                        Spacer()
                        
                        // 將 shield.fill 圖標放入 Button
                        Button(action: {
                            // 點擊時顯示 SafetyCenterView
                            showSafetyCenterView = true
                        }) {
                            Image(systemName: "shield.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray) // Set the color to match the design
                                .padding(.trailing, 10)
                        }
                        
                        Button(action: {
                            showSettingsView = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .padding()
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
                
                // Show dimmed background and popup when isShowingInfoPopup is true
                if isShowingInfoPopup {
                    Color.black.opacity(0.4) // Dimmed background
                        .edgesIgnoringSafeArea(.all) // Make it cover the entire screen
                    
                    // Popup content
                    VStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("即時更新的人氣大賽")
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    isShowingInfoPopup = false // Close the popup
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                        .opacity(0.4)
                                }
                            }
                            .padding()
                            
                            Text("你好秀啊！你比附近\(String(format: "%.1f", userRankPercentage))%的用戶還受歡迎喔！")                               .font(.body)
                                .padding(.horizontal)
                            
                            Text("如何獲得更多喜歡")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "checkmark")
                                    Text("保持活躍，每天上線 SwiftiDate")
                                }
                                HStack {
                                    Image(systemName: "checkmark")
                                    Text("配對多右滑，右滑多配對")
                                }
                                HStack {
                                    Image(systemName: "checkmark")
                                    Text("選最好的照片作為頭像")
                                }
                                HStack {
                                    Image(systemName: "checkmark")
                                    Text("個資豐富，脫穎而出")
                                }
                                HStack {
                                    Image(systemName: "checkmark")
                                    Text("頭像認證，取得信任")
                                }
                            }
                            .padding(.horizontal)
                                                        
                            Button(action: {
                                isShowingInfoPopup = false // Dismiss the popup
                            }) {
                                Text("獲得更多曝光的機會")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                    .transition(.opacity) // Smooth transition when appearing/disappearing
                    .animation(.easeInOut)
                }
            }
        }
    }
    
    // 加載已保存的照片 URL 列表
    func loadPhotosFromAppStorage() {
//        // 清空 loadedPhotosString
//        userSettings.loadedPhotosString = ""
//
//        // 同步更新 photos 列表
//        self.photos.removeAll()
//
//        print("loadedPhotosString has been cleared, and photos have been reset.")
        
        if !userSettings.loadedPhotosString.isEmpty {
            print("Loaded cached photos from AppStorage: \(userSettings.loadedPhotosString)")
            // 直接將快取的照片名稱分割成陣列並賦值給 photos
            self.photos = userSettings.loadedPhotosString.components(separatedBy: ",")
            print("Photos loaded from cache: \(self.photos)")
        } else {
            print("No cached photos found in AppStorage, fetching from Firebase.")
            fetchPhotosFromFirebase()
        }
    }
    
    // Fetch photos from Firebase Storage
    func fetchPhotosFromFirebase() {
        print("Fetching photos from Firebase started")
        photos.removeAll() // Clear existing photos before fetching
        
        let storage = Storage.storage()
        let userID = userSettings.globalUserID // Access user ID from UserSettings
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
            
            var fetchedPhotoURLs: [(url: String, photoNumber: Int)] = []
            var downloadedPhotos: [(url: String, imageName: String)] = [] // Temporary array to store downloaded photos

            for item in result.items {
                item.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }
                    
                    if let url = url {
                        let urlString = url.absoluteString
                        
                        // Extract the number from the photo name
                        if let photoNumber = extractPhotoNumber(from: urlString) {
                            fetchedPhotoURLs.append((urlString, photoNumber))
                        }
                        
                        // Once all URLs are fetched, sort by photo number
                        if fetchedPhotoURLs.count == result.items.count {
                            fetchedPhotoURLs.sort { $0.photoNumber < $1.photoNumber }
                            
                            // Download each photo and save it to local storage
                            for (urlString, _) in fetchedPhotoURLs {
                                downloadAndSavePhoto(from: urlString) { imageName in
                                    if let imageName = imageName {
                                        downloadedPhotos.append((url: urlString, imageName: imageName))
                                    }
                                    
                                    // If all photos are downloaded, update the photos array
                                    if downloadedPhotos.count == fetchedPhotoURLs.count {
                                        // Sort the downloaded photos according to fetchedPhotoURLs order
                                        downloadedPhotos.sort { lhs, rhs in
                                            fetchedPhotoURLs.firstIndex(where: { $0.url == lhs.url })! < fetchedPhotoURLs.firstIndex(where: { $0.url == rhs.url })!
                                        }
                                        
                                        DispatchQueue.main.async {
                                            // Update the photos array and AppStorage
                                            self.photos = downloadedPhotos.map { $0.imageName }
                                            userSettings.loadedPhotosString = self.photos.joined(separator: ",")
                                            print("Updated photos array after download: \(self.photos)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Download photo from a URL and save it to local storage
    func downloadAndSavePhoto(from urlString: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        print("Starting download for photo: \(urlString)")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading photo: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to convert data to image for URL: \(urlString)")
                completion(nil)
                return
            }
            
            // Generate a unique name for the image and save it locally
            let imageName = UUID().uuidString
            PhotoUtility.saveImageToLocalStorage(image: image, withName: imageName)
            print("Photo downloaded and saved as \(imageName)")
            
            // 使用回調返回照片名稱
            completion(imageName)
        }
        
        task.resume()
    }
    
    func extractPhotoNumber(from urlString: String) -> Int? {
        // Extracts the number from "photoX" in the URL
        let pattern = "photo(\\d+)" // Regular expression to capture the number
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: urlString, range: NSRange(urlString.startIndex..., in: urlString)),
           let range = Range(match.range(at: 1), in: urlString) {
            return Int(urlString[range])
        }
        return nil
    }
    
    // 添加圖片到照片列表
    func addImageToPhotos(image: UIImage) {
        let imageName = UUID().uuidString
        PhotoUtility.saveImageToLocalStorage(image: image, withName: imageName)
        photos.append(imageName)
        userSettings.loadedPhotosString = photos.joined(separator: ",")
    }
}

struct AchievementCardView: View {
    var title: String
    var count: Int
    var color: Color
    var action: (() -> Void)? // Optional action closure
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            Text("\(count)")
                .font(.title)
                .fontWeight(.bold)
            Button(action: {
                action?() // Execute the action if provided
            }) {
                Text("獲取更多")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
            }
        }
        .frame(width: 100, height: 100)
        .background(color.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ServiceSectionView: View {
    var sectionTitle: String
    var totalItems: Int
    var services: [(name: String, isAvailable: Bool, count: String?)] // (Service name, availability, count)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Service items
            VStack(spacing: 5) {
                // Title and total items count
                HStack {
                    Text(sectionTitle)
                        .font(.headline)

                    Spacer()
                    
                    Text("\(totalItems)項")
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
                
                ForEach(services, id: \.name) { service in
                    HStack {
                        Text(service.name)
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if let count = service.count {
                            Text(count)
                                .font(.subheadline)
                        } else if service.isAvailable {
                            Image(systemName: "checkmark")
                        } else {
                            Image(systemName: "infinity")
                        }
                    }
                    Spacer()
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var mockSelectedTab = 4 // Create a mock State for the binding
    
    static var previews: some View {
        NavigationView {
            ProfileView(contentSelectedTab: $mockSelectedTab) // Pass the binding for preview
                .environmentObject(UserSettings()) // Add a mock EnvironmentObject for UserSettings
        }
    }
}
