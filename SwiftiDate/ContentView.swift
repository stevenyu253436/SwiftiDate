//
//  ContentView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SwipeCardView()
                .tabItem {
                    Image(systemName: "heart.fill")
                }
            
            Text("附近")
                .tabItem {
                    Image(systemName: "star.fill")
                }
            
            NavigationView {
                UserGuideView()
            }
            .tabItem {
                Image(systemName: "questionmark.circle.fill")
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
