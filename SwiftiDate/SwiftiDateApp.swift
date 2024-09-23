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
var globalLatitude: Double? // Global variable for latitude
var globalLongitude: Double? // Global variable for longitude
var globalSubadministrativeArea: String? // Global variable for subadministrative area
var globalLocality: String? // Global variable for locality

class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate {
  var locationManager: CLLocationManager?
  let geocoder = CLGeocoder() // Initialize the geocoder

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    
    // Store or retrieve device identifier
    storeDeviceIdentifier()
      
    // Initialize location manager
    initializeLocationManager()

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
