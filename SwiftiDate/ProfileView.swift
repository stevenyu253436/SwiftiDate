//
//  ProfileView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI
import FirebaseStorage

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userSettings: UserSettings // 使用 EnvironmentObject 存取 UserSettings
    
    @State private var userRankPercentage: Double = 25.4
    @State private var isShowingInfoPopup = false // State to show/hide the popup
    @State private var isShowingTurboView = false
    @State private var selectedTab: Int = 0 // State to control which tab is selected in TurboView
    @Binding var contentSelectedTab: Int // Use a binding variable for selectedTab from ContentView
    @State private var profileSelectedTab: Int = 0 // State to control which tab is selected in ProfileView
    @State private var isShowingTurboPurchaseView = false // State variable to control the sheet presentation
    @State private var isShowingCrushPurchaseView = false // State variable to control Crush sheet presentation
    @State private var isShowingPraisePurchaseView = false // State variable to control Praise sheet presentation
    @State private var isShowingEditProfileView = false // State to show EditProfileView
    @State private var showSettingsView = false // State variable to control Settings View presentation
    @State private var showSafetyCenterView = false // 控制 SafetyCenterView 的顯示
    
    // Local debug variable for Supreme status
    @State private var isSupreme = false // Modify this to test different scenarios

    var body: some View {
        if showSettingsView {
            SettingsView(showSettingsView: $showSettingsView) // Pass the binding to the SettingsView
                .environmentObject(appState) // 傳遞 AppState
        } else if showSafetyCenterView {
            SafetyCenterView(showSafetyCenterView: $showSafetyCenterView, photos: $userSettings.photos) // 如果全局变量为 true，则显示 SafetyCenterView
                .environmentObject(userSettings)
        } else {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        // 头像及基本信息
                        ProfileHeaderView(
                            isShowingEditProfileView: $isShowingEditProfileView,
                            photos: $userSettings.photos // 傳遞綁定的照片屬性
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
                            UnverifiedProfilePlaceholderView(photos: userSettings.photos) // 使用 userSettings.photos
                        }
                        
                        // Turbo, Crush, 讚美
                        AchievementSectionView(
                            isShowingTurboPurchaseView: $isShowingTurboPurchaseView,
                            isShowingCrushPurchaseView: $isShowingCrushPurchaseView,
                            isShowingPraisePurchaseView: $isShowingPraisePurchaseView
                        )
                        .environmentObject(userSettings)
                        
                        // Display Supreme banner if the user has purchased Supreme
                        if userSettings.isSupremeUser {
                            SupremeBannerView()
                        } else {
                            PremiumCardTabView(selectedTab: $profileSelectedTab)
                        }
                        
                        ServiceSectionContainer(isSupreme: .constant(userSettings.isSupremeUser))
                    }
                    .environmentObject(userSettings)
                }
                .onAppear {
                    loadPhotosFromAppStorage()
                }
                
                // 使用新的 TopRightActionButtons 组件
                TopRightActionButtons(showSettingsView: $showSettingsView, showSafetyCenterView: $showSafetyCenterView)
                
                // Show dimmed background and popup when isShowingInfoPopup is true
                if isShowingInfoPopup {
                    Color.black.opacity(0.4) // Dimmed background
                        .edgesIgnoringSafeArea(.all) // Make it cover the entire screen
                    InfoPopupView(isShowing: $isShowingInfoPopup, userRankPercentage: userRankPercentage)
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
            userSettings.photos = userSettings.loadedPhotosString.components(separatedBy: ",")
            print("Photos loaded from cache: \(userSettings.photos)")
        } else {
            print("No cached photos found in AppStorage, fetching from Firebase.")
            fetchPhotosFromFirebase()
        }
    }
    
    // Fetch photos from Firebase Storage
    func fetchPhotosFromFirebase() {
        print("Fetching photos from Firebase started")
        userSettings.photos.removeAll() // Clear existing photos before fetching
        
        let storage = Storage.storage()
        let userID = userSettings.globalUserID // Access user ID from UserSettings
        let storageRef = storage.reference().child("user_photos/\(userID)")
        
        storageRef.listAll { (listResult, error) in
            if let error = error {
                print("Error fetching photos: \(error)")
                return
            }
                        
            // Safely unwrap the listResult
            guard let listResult = listResult else {
                print("Failed to fetch the result")
                return
            }
            
            var fetchedPhotoURLs: [(url: String, photoNumber: Int)] = []
            var downloadedPhotos: [(url: String, imageName: String)] = [] // Temporary array to store downloaded photos
            var processedItemCount = 0 // Track the number of processed items
            
            for (index, item) in listResult.items.enumerated() {
//                 註解：以前的代碼可以編譯通過，但是在新的 Firebase SDK 或 Swift 編譯器更新之後，
//                 回調函式的參數型別或 API 使用方式發生了變更，導致舊的寫法不再適用。
//                 現在需要使用 Result<URL, Error> 來處理下載 URL 的結果。
//                item.downloadURL { (url, error) in
//                    if let error = error {
//                        print("Error getting download URL: \(error)")
//                        return
//                    }
//                    
//                    if let url = url {
//                        let urlString = url.absoluteString
//                        
//                        // Extract the number from the photo name
//                        if let photoNumber = extractPhotoNumber(from: urlString) {
//                            fetchedPhotoURLs.append((urlString, photoNumber))
//                        }
//                        
//                        // Once all URLs are fetched, sort by photo number
//                        if fetchedPhotoURLs.count == result.items.count {
//                            fetchedPhotoURLs.sort { $0.photoNumber < $1.photoNumber }
//                            
//                            // Download each photo and save it to local storage
//                            for (urlString, _) in fetchedPhotoURLs {
//                                downloadAndSavePhoto(from: urlString) { imageName in
//                                    if let imageName = imageName {
//                                        downloadedPhotos.append((url: urlString, imageName: imageName))
//                                    }
//                                    
//                                    // If all photos are downloaded, update the photos array
//                                    if downloadedPhotos.count == fetchedPhotoURLs.count {
//                                        // Sort the downloaded photos according to fetchedPhotoURLs order
//                                        downloadedPhotos.sort { lhs, rhs in
//                                            fetchedPhotoURLs.firstIndex(where: { $0.url == lhs.url })! < fetchedPhotoURLs.firstIndex(where: { $0.url == rhs.url })!
//                                        }
//                                        
//                                        DispatchQueue.main.async {
//                                            // Update the photos array and AppStorage
//                                            userSettings.photos = downloadedPhotos.map { $0.imageName }
//                                            userSettings.loadedPhotosString = userSettings.photos.joined(separator: ",")
//                                            print("Updated photos array after download: \(self.photos)")
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
                print("Processing item \(index + 1) of \(listResult.items.count): \(item.name)")
                
                item.downloadURL { result in
                    processedItemCount += 1
                    print("Download URL callback for item \(item.name), result: \(result)")
                    
                    switch result {
                    case .success(let url):
                        let urlString = url.absoluteString
                        
                        // Extract the number from the photo name
                        if let photoNumber = extractPhotoNumber(from: urlString) {
                            fetchedPhotoURLs.append((urlString, photoNumber))
                        }
                        
                        // Once all URLs are fetched, sort by photo number
                        if processedItemCount == listResult.items.count {
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
                                            userSettings.photos = downloadedPhotos.map { $0.imageName }
                                            userSettings.loadedPhotosString = userSettings.photos.joined(separator: ",")
                                            print("Updated photos array after download: \(userSettings.photos)")
                                        }
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        print("Error getting download URL: \(error)")
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
        userSettings.photos.append(imageName)
        userSettings.loadedPhotosString = userSettings.photos.joined(separator: ",")
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
                .environmentObject(AppState()) // 加入 AppState
        }
    }
}
