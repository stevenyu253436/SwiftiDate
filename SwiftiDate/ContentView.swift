//
//  ContentView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings // 引入 UserSettings 來獲取 globalUserGender
    @State private var selectedTurboTab: Int = 0 // Add this to track the selected tab for TurboView
    
    var body: some View {
        TabView {
            SwipeCardView()
                .tabItem {
                    Image(systemName: "heart.fill")
                }
            
            // Pass the selectedTab to TurboView
            TurboView(selectedTab: $selectedTurboTab, showBackButton: false) // Pass the state to control the tab
                .tabItem {
                    Image(systemName: "star.fill")
                }

            // Only show UserGuideView if the user is male
            if userSettings.globalUserGender == .male { // 從 userSettings 獲取性別資訊
                NavigationView {
                    UserGuideView()
                }
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                }
            }
            
            ChatView() // 替換為 ChatView
                .tabItem {
                    Image(systemName: "message.fill")
                }
            
            NavigationView {
                ProfileView()
            }
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 15 Pro")  // 这里您可以选择想要预览的设备
    }
}
