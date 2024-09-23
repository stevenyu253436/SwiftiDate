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
    @State private var isHelpView = false // State variable to control HelpView presentation

    var body: some View {
        if isHelpView {
            HelpView(isHelpView: $isHelpView) // Use the binding variable in the preview
        } else {
            VStack {
                // Custom Navigation Bar
                HStack {
                    Button(action: {
                        showSettingsView = false // Dismiss SettingsView and return to ProfileView
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
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
                        .padding(.vertical, 10) // Adjust this value to increase the height
                        
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.orange)
                            Text("恢復購買")
                            Spacer()
                        }
                        .padding(.vertical, 10) // Adjust this value to increase the height
                        
                        HStack {
                            Image(systemName: "crown")
                                .foregroundColor(.brown)
                            Text("開啟 SwiftiDate Supreme 會員標誌")
                            Spacer()
                            Toggle("", isOn: .constant(true))
                                .labelsHidden()
                        }
                        .padding(.vertical, 10) // Adjust this value to increase the height
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.pink)
                            Text("邀請好友一起玩SwiftiDate")
                            Spacer()
                        }
                        .padding(.vertical, 10) // Adjust this value to increase the height
                        
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.pink)
                            Text("兌換會員")
                            Spacer()
                        }
                        .padding(.vertical, 10) // Adjust this value to increase the height
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.cyan)
                            Text("個人資料")
                            Spacer()
                        }
                        .padding(.vertical, 10) // Adjust this value to increase the height
                    }
                    
                    Section {
                        HStack {
                            Text("客服")
                                .padding(.vertical, 10) // Adjust this value to increase the height
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray) // Optional: Set the color of the chevron
                        }

                        Button(action: {
                            isHelpView = true // Show HelpView
                        }) {
                            HStack {
                                Text("幫助")
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .foregroundColor(.black) // Keep the text color unchanged when the button is tapped
                        }
                        
                        HStack {
                            Text("語言")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("社區規範")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("隱私權政策")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("服務協議")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("數據管理")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("資料恢復")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("檢查版本更新")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Text("戀愛性格測驗")
                                .padding(.vertical, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section {
                        Text("登出")
                            .padding(.vertical, 10) // Adjust this value to increase the height
                            .frame(maxWidth: .infinity, alignment: .leading) // Extend Text to the full width
                            .background(Color.white) // Make sure the background is set to white
                            .foregroundColor(.red) // Set the text color to red
                    }
                    
                    Section {
                        Text("關閉帳號")
                            .padding(.vertical, 10) // Adjust this value to increase the height
                            .frame(maxWidth: .infinity, alignment: .leading) // Extend Text to the full width
                            .background(Color.white) // Make sure the background is set to white
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var showSettingsView = true // Provide a sample state variable for the preview

    static var previews: some View {
        SettingsView(showSettingsView: $showSettingsView) // Use the binding variable in the preview
    }
}
