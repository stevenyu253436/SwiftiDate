//
//  PhotoSectionView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI

struct PhotoSectionView: View {
    var photos: [String]

    var body: some View {
        // 上排照片
        HStack(spacing: 10) {
            ForEach(photos.prefix(3), id: \.self) { photo in
                Image(photo)
                    .resizable()
                    .frame(width: 100, height: 133)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        Button(action: {
                            // 删除照片操作
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        .offset(x: -5, y: -5)
                        , alignment: .topTrailing
                    )
            }
        }
        // 下排照片
        HStack(spacing: 10) {
            ForEach(photos.suffix(3), id: \.self) { photo in
                Image(photo)
                    .resizable()
                    .frame(width: 100, height: 133)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        Button(action: {
                            // 删除照片操作
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        .offset(x: -5, y: -5)
                        , alignment: .topTrailing
                    )
            }
        }
    }
}
