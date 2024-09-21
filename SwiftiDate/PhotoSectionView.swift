//
//  PhotoSectionView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import Foundation
import SwiftUI

enum PhotoState {
    case empty
    case loading
    case success(UIImage)
    case failure
}

struct PhotoSectionView: View {
    @Binding var photos: [String] // Change to @Binding
    @State private var showImagePicker = false // 控制顯示照片選擇器
    @State private var selectedImage: UIImage? // 保存選中的圖片

    var body: some View {
        // 上排照片
        HStack(spacing: 10) {
            ForEach(photos.prefix(3), id: \.self) { photo in
                if let url = URL(string: photo) {
                    AsyncImageView(url: url, placeholder: Image(systemName: "photo")) // 使用自定義的 AsyncImageView
                        .frame(width: 100, height: 133)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            Button(action: {
                                removePhoto(photo: photo)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                            .offset(x: -5, y: -5), alignment: .topTrailing
                        )
                        .onAppear {
                            print("Loading image from URL: \(url)")
                            print("Photos array on appear: \(photos)")
                        }
                }
            }
        }
        
        // 下排照片
        HStack(spacing: 10) {
            ForEach(photos.suffix(3), id: \.self) { photo in
                if let url = URL(string: photo) {
                    AsyncImageView(url: url, placeholder: Image(systemName: "photo")) // 使用自定義的 AsyncImageView
                        .frame(width: 100, height: 133)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            Button(action: {
                                removePhoto(photo: photo)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                            .offset(x: -5, y: -5), alignment: .topTrailing
                        )
                        .onAppear {
                            print("Loading image from URL: \(url)")
                            print("Photos array on appear: \(photos)")
                        }
                }
            }
            
            // 如果剛好移除的是第六張照片，顯示一個占位符號
            if photos.count == 5 {
                PlaceholderView()  // 顯示 "生活" 占位符號
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
                .onChange(of: selectedImage) { newImage in
                    if let image = newImage {
                        // 處理圖片上傳，這裡可以使用上傳服務或直接添加到照片列表中
                        addImageToPhotos(image: image)
                    }
                }
        }
    }
    
    // 移除照片的函數
    func removePhoto(photo: String) {
        if let index = photos.firstIndex(of: photo) {
            photos.remove(at: index)
        }
    }
    
    // 將選擇的圖片轉換為顯示並添加到照片列表
    func addImageToPhotos(image: UIImage) {
        let imageName = UUID().uuidString // 生成唯一名稱
        // 假設這裡將圖片保存到本地或上傳，並添加到圖片列表
        photos.append(imageName)
        // 可以進一步將圖片上傳並顯示在相應的 Image 中
    }
}

// View to display an image from URL
struct PhotoView: View {
    var photoURL: URL?

    var body: some View {
        if let url = photoURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView() // Loading indicator
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView() // Provide an explicit view for @unknown default case
                }
            }
            .frame(width: 100, height: 133) // Ensure the frame is set for AsyncImage
        } else {
            Color.gray.opacity(0.2)
                .frame(width: 100, height: 133) // Ensure consistent sizing
        }
    }
}

// 占位符號的View
struct PlaceholderView: View {
    var body: some View {
        VStack {
            Image(systemName: "book.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            Text("生活")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 133)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// ImagePicker: 用於選擇照片
struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
