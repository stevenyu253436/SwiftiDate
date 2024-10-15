//
//  ContentView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings // 引入 UserSettings 來獲取 globalUserGender
    @State private var selectedTab: Int = 0 // Add this to track the selected tab
    @State private var selectedTurboTab: Int = 0 // Add this to track the selected tab for TurboView
    
    var body: some View {
        TabView(selection: $selectedTab) { // Bind TabView selection to selectedTab
            SwipeCardView()
                .tabItem {
                    Image(systemName: "heart.fill")
                }
                .tag(0) // Assign a tag for SwipeCardView tab
            
            // Pass the selectedTab to TurboView
            TurboView(contentSelectedTab: $selectedTab, turboSelectedTab: $selectedTurboTab, showBackButton: false) // Match the parameter name here
                .tabItem {
                    Image(systemName: "star.fill")
                }
                .tag(1) // Assign a tag for TurboView tab

            // Only show UserGuideView if the user is male
            if userSettings.globalUserGender == .male { // Use globalUserGender for the gender check
                NavigationView {
                    UserGuideView()
                }
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                }
                .tag(2) // Assign a tag for UserGuideView tab
            }
            
            ChatView(contentSelectedTab: $selectedTab) // Pass the binding to contentSelectedTab
                .tabItem {
                    Image(systemName: "message.fill")
                }
                .tag(3) // Assign a tag for ChatView tab
            
            NavigationView {
                ProfileView(contentSelectedTab: $selectedTab) // Pass the binding variable
            }
                .tabItem {
                    Image(systemName: "person.fill")
                }
                .tag(4) // Assign a tag for ProfileView tab
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings()) // Provide the UserSettings object here
            .previewDevice("iPhone 15 Pro")  // 这里您可以选择想要预览的设备
    }
}
