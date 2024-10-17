//
//  PreviewSectionView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/17.
//

import Foundation
import SwiftUI

struct PreviewSectionView: View {
    @Binding var photos: [String]
    @Binding var currentPhotoIndex: Int
    var aboutMe: String
    var selectedZodiac: String
    var selectedJob: String?
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        // 預覽界面
        ZStack {
            if let imageName = photos.indices.contains(currentPhotoIndex) ? photos[currentPhotoIndex] : nil,
               let image = PhotoUtility.loadImageFromLocalStorage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 420, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 4))
                    .edgesIgnoringSafeArea(.top)
            } else {
                // Display a placeholder or error image
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    ForEach(0..<photos.count) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 40, height: 8)
                            .foregroundColor(index == currentPhotoIndex ? .white : .gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .cornerRadius(10)
                
                Spacer()
                
                Text("\(userSettings.globalUserName), 25") // 使用 userSettings 來存取 globalUserName
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.blue)
                    Text("\(selectedZodiac) · 新竹市 · \(selectedJob ?? "職業未填寫")")
                        .foregroundColor(.white)
                }
                .font(.subheadline)
                
                Text(aboutMe)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.top)
            }
            .padding()
            
            // Add a transparent layer for tap detection
            GeometryReader { geometry in
                HStack {
                    // Left half tap gesture
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle()) // Make the whole area tappable
                        .frame(width: geometry.size.width / 2)
                        .onTapGesture {
                            // Decrease index if not at the first photo
                            if currentPhotoIndex > 0 {
                                currentPhotoIndex -= 1
                            }
                        }
                    
                    // Right half tap gesture
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle()) // Make the whole area tappable
                        .frame(width: geometry.size.width / 2)
                        .onTapGesture {
                            // Increase index if not at the last photo
                            if currentPhotoIndex < photos.count - 1 {
                                currentPhotoIndex += 1
                            }
                        }
                }
            }
        }
    }
}
