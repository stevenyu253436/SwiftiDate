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

var deviceIdentifier: String? // Global variable
var globalLatitude: Double? // Global variable for latitude
var globalLongitude: Double? // Global variable for longitude
var globalSubadministrativeArea: String? // Global variable for subadministrative area
var globalLocality: String? // Global variable for locality

class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
  var locationManager: CLLocationManager?
  let geocoder = CLGeocoder() // Initialize the geocoder

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      print("Firebase configured successfully")
      
      // 初始化 Firestore 並指定資料庫名稱
      let settings = FirestoreSettings()
      settings.host = "firestore.googleapis.com"
      settings.isPersistenceEnabled = true // 開啟本地資料緩存
      settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
      
      // Use Mirror to reflect on the FirestoreSettings object
      let mirror = Mirror(reflecting: settings)
      print("Firestore Settings Properties:")
      for child in mirror.children {
          if let propertyName = child.label {
              print("\(propertyName): \(child.value)")
          }
      }

      var db = Firestore.firestore() // 使用 var 來讓 db 可以重新指派
      db.settings = settings

      // 如果需要指定資料庫ID
      if let app = FirebaseApp.app() {
          db = Firestore.firestore(app: app, database: "swiftidate-database")
      }

      print("Firestore initialized: \(db)")
      
      // 初始化 App Check
      let providerFactory = DeviceCheckProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)
      
    // Store or retrieve device identifier
    storeDeviceIdentifier()
      
    // Initialize location manager
    initializeLocationManager()
      
      // Request notification permissions
      requestNotificationPermission()

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
    
  private func initializeLocationManager() {
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestWhenInUseAuthorization() // Request location access permission
    locationManager?.startUpdatingLocation() // Start fetching the location
  }
    
  // CLLocationManagerDelegate method
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
      
    // Store latitude and longitude in global variables
    globalLatitude = latitude
    globalLongitude = longitude

    print("Current Location: Latitude \(latitude), Longitude \(longitude)")
      
    // Reverse geocoding
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      if let error = error {
        print("Failed to reverse geocode location: \(error.localizedDescription)")
        return
      }
          
      if let placemarks = placemarks, let placemark = placemarks.first {
        // Store Subadministrative Area and Locality in global variables
        globalSubadministrativeArea = placemark.subAdministrativeArea
        globalLocality = placemark.locality

        // Check if the location is in Hsinchu City, Taiwan
        if placemark.country == "Taiwan", placemark.locality == "Hsinchu City" {
          print("The location is in Hsinchu City, Taiwan!")
        } else {
          print("The location is not in Hsinchu City, Taiwan. It is in \(placemark.locality ?? "Unknown City"), \(placemark.country ?? "Unknown Country").")
        }
              
        // Print detailed address information
        print("Administrative Area: \(placemark.administrativeArea ?? "N/A")")
        print("Subadministrative Area: \(placemark.subAdministrativeArea ?? "N/A")")
        print("Locality: \(placemark.locality ?? "N/A")")
        print("SubLocality: \(placemark.subLocality ?? "N/A")")
        print("Postal Code: \(placemark.postalCode ?? "N/A")")
        print("Country: \(placemark.country ?? "N/A")")
      }
    }
  }
    
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Failed to get location: \(error.localizedDescription)")
  }
    
    // Request notification permission
    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
    }
    
    // UNUserNotificationCenterDelegate method to handle notifications while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}

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
