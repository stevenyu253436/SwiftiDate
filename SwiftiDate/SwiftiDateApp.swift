//
//  SwiftiDateApp.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI
import FirebaseCore
import CoreLocation
import KeychainAccess
import UserNotifications // Import UserNotifications framework
import FirebaseFirestore
import FirebaseAppCheck
import FirebaseAuth
import FirebaseCrashlytics

var deviceIdentifier: String? // Global variable
var globalLatitude: Double? // Global variable for latitude
var globalLongitude: Double? // Global variable for longitude
var globalSubadministrativeArea: String? // Global variable for subadministrative area
var globalLocality: String? // Global variable for locality

@main
struct SwiftiDateApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var appState = AppState()
    @StateObject var userSettings = UserSettings() // Initialize UserSettings as a state object
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !userSettings.globalPhoneNumber.isEmpty { // 改為檢查非空
                    ContentView()
                        .environmentObject(userSettings)
                        .environmentObject(appState)
                } else {
                    LoginOrRegisterView()
                        .environmentObject(userSettings)
                        .environmentObject(appState)
                }
            }
            .onAppear {
                userSettings.globalPhoneNumber = "0972516868"
                userSettings.globalUserName = "玩玩"
                userSettings.storedGender = Gender.male
                userSettings.globalIsUserVerified = true
                userSettings.globalSelectedGender = "女生"
                userSettings.globalUserBirthday = "1999/07/02"
                userSettings.globalUserID = "userID_1"
                userSettings.globalLikesMeCount = 0
                userSettings.globalLikeCount = 0
                userSettings.isPremiumUser = true
                userSettings.isSupremeUser = true
                userSettings.globalTurboCount = 1
                userSettings.globalCrushCount = 10000
                userSettings.globalPraiseCount = 10000
                userSettings.isProfilePhotoVerified = true
            }
        }
    }
}
