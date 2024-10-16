//
//  PhotoUtility.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/17.
//

import Foundation
import UIKit

struct PhotoUtility {
    static func loadImageFromLocalStorage(named imageName: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }

    static func saveImageToLocalStorage(image: UIImage, withName imageName: String) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
            try? data.write(to: url)
        }
    }

    static func deleteImageFromLocalStorage(named imageName: String) {
        let fileManager = FileManager.default
        let fileURL = getDocumentsDirectory().appendingPathComponent(imageName)
        
        do {
            try fileManager.removeItem(at: fileURL)
            print("Photo deleted successfully from local storage: \(imageName)")
        } catch {
            print("Failed to delete photo from local storage: \(error.localizedDescription)")
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
