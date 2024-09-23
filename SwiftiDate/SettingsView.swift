//
//  SettingsView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var showSettingsView: Bool // Binding variable to control the view dismissal

    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    showSettingsView = false // Dismiss SettingsView and return to ProfileView
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Text("設定")
                    .font(.headline)
                    .padding(.leading, 5)
                
                Spacer()
            }
            .padding()
            
            Divider()
            
            // Settings content
            List {
                Section {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                            .foregroundColor(.purple)
                        Text("掃碼")
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.orange)
                        Text("恢復購買")
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "crown")
                            .foregroundColor(.brown)
                        Text("開啟 SwiftiDate Supreme 會員標誌")
                        Spacer()
                        Toggle("", isOn: .constant(true))
                            .labelsHidden()
                    }
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.pink)
                        Text("邀請好友一起玩SwiftiDate")
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.pink)
                        Text("兌換會員")
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.cyan)
                        Text("個人資料")
                        Spacer()
                    }
                }
                
                Section {
                    Text("客服")
                    Text("幫助")
                    Text("語言")
                    Text("社區規範")
                }
            }
        }
    }
}
