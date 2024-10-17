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
    
    // Local debug variable for Supreme status
    @State private var isSupreme = false // Modify this to test different scenarios

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
                        ProfileHeaderView(
                            isShowingEditProfileView: $isShowingEditProfileView,
                            photos: $photos
                        )
                        
                        // 统计信息
                        StatisticsSectionView(selectedTab: $selectedTab, isShowingTurboView: $isShowingTurboView)
                            .environmentObject(userSettings) // 傳遞 EnvironmentObject
                            .fullScreenCover(isPresented: $isShowingTurboView) {
                                TurboView(contentSelectedTab: $contentSelectedTab, turboSelectedTab: $selectedTab, showBackButton: true, onBack: {
                                    isShowingTurboView = false // 當返回按鈕被按下時，關閉 fullScreenCover
                                })
                            }
                        
                        if userSettings.isProfilePhotoVerified {
                            // 成就进度条
                            VerifiedProfileProgressView(userRankPercentage: userRankPercentage, isShowingInfoPopup: $isShowingInfoPopup)
                        } else {
                            UnverifiedProfilePlaceholderView(photos: photos)
                        }
                        
                        // Turbo, Crush, 讚美
                        AchievementSectionView(
                            isShowingTurboPurchaseView: $isShowingTurboPurchaseView,
                            isShowingCrushPurchaseView: $isShowingCrushPurchaseView,
                            isShowingPraisePurchaseView: $isShowingPraisePurchaseView
                        )
                        .environmentObject(userSettings)
                        
                        // Display Supreme banner if the user has purchased Supreme
                        if isSupreme {
                            ZStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "crown.fill") // Adding the crown icon
                                            .foregroundColor(.gold) // Matching the gold color
                                            .font(.system(size: 18)) // Adjust the size as needed
                                        
                                        Text("SwiftiDate Supreme")
                                            .font(.headline)
                                            .foregroundColor(.gold) // Set text color to gold
                                            .fontWeight(.bold)
                                    }
                                    
                                    Text("已開啟 SwiftiDate 所有特權")
                                        .font(.subheadline)
                                        .foregroundColor(.gold)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 30)
                                .frame(maxWidth: UIScreen.main.bounds.width - 80, alignment: .leading) // 設置最大寬度稍小於螢幕寬度
                                .padding(.horizontal) // Add horizontal padding to the outer VStack
                            }
                            .background(Color.black) // Apply background color to the entire ZStack
                            .cornerRadius(10) // Apply corner radius to the entire ZStack
                        } else {
                            ZStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "crown.fill") // Adding the crown icon
                                            .foregroundColor(.gold) // Matching the gold color
                                            .font(.system(size: 18)) // Adjust the size as needed
                                        
                                        Text("SwiftiDate Supreme")
                                            .font(.headline)
                                            .foregroundColor(.gold) // Set text color to gold
                                            .fontWeight(.bold)
                                    }
                                    
                                    Text("已開啟 SwiftiDate 所有特權")
                                        .font(.subheadline)
                                        .foregroundColor(.gold)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 30)
                                .frame(maxWidth: UIScreen.main.bounds.width - 80, alignment: .leading) // 設置最大寬度稍小於螢幕寬度
                                .padding(.horizontal) // Add horizontal padding to the outer VStack
                            }
                            .background(Color.black) // Apply background color to the entire ZStack
                            .cornerRadius(10) // Apply corner radius to the entire ZStack
                        }
                        
                        ServiceSectionContainer(isSupreme: $isSupreme)
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

struct ProfileView_Previews: PreviewProvider {
    @State static var mockSelectedTab = 4 // Create a mock State for the binding
    
    static var previews: some View {
        NavigationView {
            ProfileView(contentSelectedTab: $mockSelectedTab) // Pass the binding for preview
                .environmentObject(UserSettings()) // Add a mock EnvironmentObject for UserSettings
        }
    }
}
