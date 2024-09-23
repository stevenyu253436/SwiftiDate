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

var deviceIdentifier: String? // Global variable

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    // Store or retrieve device identifier
    storeDeviceIdentifier()

    return true
  }

  private func storeDeviceIdentifier() {
    let keychain = Keychain(service: "com.yourapp.SwiftiDate")
    if let existingUUID = keychain["deviceUUID"] {
      print("Existing Device UUID: \(existingUUID)")
      deviceIdentifier = existingUUID // Store it in the global variable
    } else {
      let newUUID = UUID().uuidString
      keychain["deviceUUID"] = newUUID
      deviceIdentifier = newUUID // Store it in the global variable
      print("New Device UUID stored: \(newUUID)")
    }
  }
}

@main
struct SwiftiDateApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
              ContentView()
            }
        }
    }
}
