//
//  ContentView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        if appState.isLoggedIn {
            MainView()
                .environmentObject(userSettings)
        } else {
            LoginView()
                .environmentObject(appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
            .environmentObject(UserSettings()) // 確保預覽時的環境變量
            .previewDevice("iPhone 15 Pro")  // 这里您可以选择想要预览的设备
    }
}
