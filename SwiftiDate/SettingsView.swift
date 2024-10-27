//
//  SettingsView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/23.
//

import Foundation
import SwiftUI
import MessageUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState // 確保可以訪問 AppState
    @EnvironmentObject var userSettings: UserSettings // 使用 EnvironmentObject 來獲取 global 變數
    @Binding var showSettingsView: Bool // Binding variable to control the view dismissal
    @State private var isQRCodeScannerView = false
    @State private var isHelpView = false // State variable to control HelpView presentation
    @State private var isCommunityGuidelinesView = false // State variable for CommunityGuidelinesView
    @State private var isPrivacyPolicyView = false // State variable for PrivacyPolicyView
    @State private var isTermsOfServiceView = false // State variable for TermsOfServiceView
    @State private var isDataManagementView = false
    @State private var showUpdatePopup = false // State variable to control update popup display
    @State private var isShowingLogoutAlert = false // State variable to control alert presentation
    @State private var isPersonalInfoView = false // 控制個人資料頁面的顯示
    @State private var isShowingCustomerServiceAlert = false
    @State private var isShowingMailComposer = false // 控制郵件視圖的顯示
    @State private var mailData: MailData? // 保存郵件數據

    var body: some View {
        ZStack {
            if isQRCodeScannerView {
                QRCodeScannerView(didFindCode: { scannedCode in
                    // Handle the scanned code
                    print("Scanned QR Code: \(scannedCode)")
                    isQRCodeScannerView = false // Dismiss QRCodeScannerView after scanning
                }, dismissView: {
                    // Action to dismiss the QR code scanner
                    isQRCodeScannerView = false // Dismiss the scanner when the back button is tapped
                })
                .edgesIgnoringSafeArea(.all)
            } else if isPersonalInfoView {
                PersonalInfoView(isPersonalInfoView: $isPersonalInfoView)
            } else if isHelpView {
                HelpView(isHelpView: $isHelpView) // Use the binding variable in the preview
            } else if isCommunityGuidelinesView {
                CommunityGuidelinesView(isCommunityGuidelinesView: $isCommunityGuidelinesView)
            } else if isPrivacyPolicyView {
                PrivacyPolicyView(isPrivacyPolicyView: $isPrivacyPolicyView)
            } else if isTermsOfServiceView {
                TermsOfServiceView(isTermsOfServiceView: $isTermsOfServiceView)
            } else if isDataManagementView {
                DataManagementView(isDataManagementView: $isDataManagementView)
            } else {
                mainSettingsView
            }
            
            if showUpdatePopup { updatePopup }
        }
        .alert(isPresented: $isShowingLogoutAlert) { logoutAlert }
        .alert(isPresented: $isShowingCustomerServiceAlert) { mailSetupAlert }
    }
    
    var mainSettingsView: some View {
        VStack {
            ZStack {
                // 中間的標題
                HStack {
                    Spacer() // Push title to the center
                    
                    Text("設定")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer() // Keep title centered by adding another spacer
                }
                .padding() // Overall padding for the HStack
                
                // 左上角的返回按鈕
                HStack {
                    Button(action: {
                        // 當按下返回按鈕時關閉 SafetyCenterView
                        showSettingsView = false
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray) // 設置按鈕顏色
                    }
                    .padding(.leading) // 添加內邊距以確保按鈕不會緊貼邊緣
                    
                    Spacer() // This will push the button to the left
                }
            }
            
            Divider()
            
            // Settings content
            List {
                Section {
                    SettingsOptionView(
                        icon: "qrcode.viewfinder",
                        text: "掃碼",
                        color: .purple, // 設定圖標的顏色
                        action: {
                            isQRCodeScannerView = true // 切換到 QR Code 掃描器
                        }
                    )
                    
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
                    
                    SettingsOptionView(
                        icon: "envelope.fill",
                        text: "邀請好友一起玩SwiftiDate",
                        color: .pink, // Apply the pink color to the icon
                        action: {
                            // 定義按鈕的操作，例如分享功能
                        }
                    )
                    
                    SettingsOptionView(
                        icon: "crown.fill",
                        text: "兌換會員",
                        color: .pink, // Set the custom color for the icon
                        action: {
                            // 定義按鈕的操作
                        }
                    )
                    
                    SettingsOptionView(
                        icon: "person.fill",
                        text: "個人資料",
                        color: .cyan, // Set the custom color for the icon
                        action: {
                            isPersonalInfoView = true // Navigate to Personal Info View
                        }
                    )
                }
                
                Section {
                    SettingsOptionView(text: "客服") { checkIfMailIsSetup() }
                    // 使用 .sheet 呈現 MailComposeView
                    .sheet(isPresented: $isShowingMailComposer) {
                        if let mailData = mailData {
                            MailComposeView(data: mailData)
                        }
                    }

                    SettingsOptionView(text: "幫助") { isHelpView = true }

                    SettingsOptionView(text: "語言") {}

                    SettingsOptionView(text: "社區規範") { isCommunityGuidelinesView = true }

                    SettingsOptionView(text: "隱私權政策") { isPrivacyPolicyView = true }

                    SettingsOptionView(text: "服務協議") { isTermsOfServiceView = true }

                    SettingsOptionView(text: "數據管理") { isDataManagementView = true }
                    
                    SettingsOptionView(text: "資料恢復") {}

                    SettingsOptionView(text: "檢查版本更新") { showUpdatePopup = true }
                    
                    SettingsOptionView(text: "戀愛性格測驗") {}
                    
//                            HStack {
//                                Text("MBTI測驗")
//                                    .padding(.vertical, 10)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.gray)
//                            }
                }
                
                Section {
                    Button(action: {
                        isShowingLogoutAlert = true // Show the alert when tapped
                    }) {
                        Text("登出")
                            .padding(.vertical, 10) // Adjust this value to increase the height
                            .frame(maxWidth: .infinity, alignment: .leading) // Extend Text to the full width
                            .background(Color.white) // Make sure the background is set to white
                            .foregroundColor(.red) // Set the text color to red
                    }
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
    
    // Alert for logout confirmation
    var logoutAlert: Alert {
        Alert(
            title: Text("一旦登出，你的登入資料將被清除"),
            primaryButton: .default(Text("取消")),
            secondaryButton: .destructive(Text("確定"), action: {
                // 更新登錄狀態
                appState.isLoggedIn = false // 切換到未登錄狀態
            })
        )
    }
    
    // Popup for updates
    var updatePopup: some View {
        // Custom Popup View
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Add a close button in the top-right corner
                HStack {
                    Spacer() // Push the X button to the right
                    Button(action: {
                        showUpdatePopup = false // Close the popup when "X" is tapped
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)) // Adjust padding values
                    }
                }
                
                // Image (Add your custom image here)
                Image(systemName: "rocket.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
                
                Text("目前已經是最新版本")
                    .font(.headline)
                    .padding(.horizontal, 20)
                
                Text("超多免費的新功能，輕鬆脫單無負擔，快來體驗全新 SwiftiDate 吧～")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Button(action: {
                    showUpdatePopup = false // Close the popup when "好的" button is tapped
                }) {
                    Text("好的")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(Color.green)
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
            }
            .frame(width: 300, height: 400)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
    
    // No need for saveUserState as @AppStorage handles persistence

    // Alert for mail setup
    var mailSetupAlert: Alert {
        Alert(
            title: Text("請設置郵箱"),
            message: Text("需要設置郵箱才可以發送反饋給我們"),
            primaryButton: .default(Text("去設置"), action: {
                // 跳轉到郵箱設置頁面
                if let url = URL(string: "App-Prefs:root=MAIL") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }),
            secondaryButton: .cancel(Text("不用了"))
        )
    }
    
    // 檢查是否有設置郵箱帳戶
    func checkIfMailIsSetup() {
        if MFMailComposeViewController.canSendMail() {
            // 設置郵件數據
            mailData = MailData(subject: "反饋", recipients: ["support@swiftidate.com"], messageBody: "請描述您遇到的問題")
            isShowingMailComposer = true // 顯示郵件撰寫頁面
        } else {
            // 未設置郵箱，顯示提醒框
            print("Debug: MFMailComposeViewController 無法發送郵件，請確認郵件帳戶設置是否正確。")
            isShowingCustomerServiceAlert = true
        }
    }
    
    // Handle scanned QR code
    func handleScannedCode(scannedCode: String) {
        print("Scanned QR Code: \(scannedCode)")
        dismissCurrentView()
    }
    
    // Dismiss the current view
    func dismissCurrentView() {
        isQRCodeScannerView = false // Dismiss the scanner when the back button is tapped
    }
}

// 自定義的郵件撰寫視圖
struct MailComposeView: UIViewControllerRepresentable {
    var data: MailData
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.setSubject(data.subject)
        mailComposeVC.setToRecipients(data.recipients)
        mailComposeVC.setMessageBody(data.messageBody, isHTML: false)
        mailComposeVC.mailComposeDelegate = context.coordinator
        return mailComposeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}

// 定義郵件數據模型
struct MailData {
    var subject: String
    var recipients: [String]
    var messageBody: String
}

// Define reusable setting option component
struct SettingsOptionView: View {
    var icon: String? = nil
    var text: String
    var color: Color = .purple // New color property with default value
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon).foregroundColor(color) // Apply color to icon
                }
                Text(text).foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray)
            }
            .padding(.vertical, 10)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var showSettingsView = true // Provide a sample state variable for the preview

    static var previews: some View {
        SettingsView(showSettingsView: $showSettingsView) // Use the binding variable in the preview
    }
}
