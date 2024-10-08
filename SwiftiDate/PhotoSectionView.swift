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
                Image(photo)
                    .resizable()
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
            }
        }
        
        HStack(spacing: 10) {
            let bottomPhotos = photos.suffix(min(max(photos.count - 3, 0), 3))
            ForEach(bottomPhotos, id: \.self) { photo in
                Image(photo)
                    .resizable()
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
            }

            // 補齊照片到6張，並確保最後一張index為5
            if photos.count < 6 {
                let placeholderCount = 6 - photos.count
                ForEach(0..<placeholderCount, id: \.self) { index in
                    PlaceholderView(index: photos.count + index, showImagePicker: $showImagePicker) // 傳入當前照片數 + index
                }
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
    
    // Button to add photos
    func AddPhotoButton() -> some View {
        Button(action: {
            showImagePicker = true
        }) {
            VStack {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                Text("添加照片")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 100, height: 133)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    // 移除照片的函數
    func removePhoto(photo: String) {
        if let index = photos.firstIndex(of: photo) {
            photos.remove(at: index)
        }
    }
    
    // 將選擇的圖片轉換為顯示並添加到照片列表
    func addImageToPhotos(image: UIImage) {
        let imageName = UUID().uuidString // Generate a unique name
        saveImageToLocalStorage(image: image, withName: imageName) // Save to local storage
        photos.append(imageName) // Store the image name in your photos array
    }
    
    // Save image to local storage
    func saveImageToLocalStorage(image: UIImage, withName imageName: String) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: url)
            print("Image saved to local storage at \(url.path)")
        }
    }
    
    // Load image from local storage
    func loadImageFromLocalStorage(named imageName: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(imageName)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    // Delete image from local storage
    func deleteImageFromLocalStorage(named imageName: String) {
        let url = getDocumentsDirectory().appendingPathComponent(imageName)
        try? FileManager.default.removeItem(at: url)
    }
    
    // Helper function to get the app's document directory
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
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
    var index: Int // 傳遞進來的參數，表示第幾張占位符號
    @Binding var showImagePicker: Bool // 新增 showImagePicker binding

    var body: some View {
        VStack {
            if index == 5 {
                // 當 index 等於 5 時顯示 book.fill 和 "生活"
                Image(systemName: "book.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                Text("生活")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                // 否則顯示空白占位符
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                Text("占位符 \(index)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 100, height: 133)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onTapGesture {
            // 點擊時顯示相簿
            showImagePicker = true
        }
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

// PreviewProvider for PhotoSectionView
struct PhotoSectionView_Previews: PreviewProvider {
    @State static var samplePhotos = [
        "photo1", "photo2", "photo3", "photo4", "photo5", "photo6"
    ] // Example photo names (replace with actual image names)

    static var previews: some View {
        PhotoSectionView(photos: $samplePhotos)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}
