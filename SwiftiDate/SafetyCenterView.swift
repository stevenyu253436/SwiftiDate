//
//  SafetyCenterView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/10.
//

import Foundation
import SwiftUI

struct SafetyCenterView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) { // Change alignment to leading
                Spacer()
                
                // Align the text and image to the left using HStack
                HStack {
                    VStack(alignment: .leading) {
                        Text("你好呀~ 玩玩")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("讓 SwiftiDate 來守護你的安全！")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading) // Padding for the text

                    Spacer()

                    Image("photo1") // Use your actual image name here
                        .resizable()
                        .frame(width: 100, height: 133)
                        .clipShape(Circle()) // Make it circular
                        .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional white border
                        .padding(.trailing) // Add padding to separate the image from the text
                }
                .padding(.bottom, 20)
                
                NavigationLink(destination: Text("安全意識小測驗")) {
                    VStack(alignment: .leading, content: {
                        Text("安全意識小測驗")
                            .font(.headline)
                            .foregroundColor(.black) // Title text color
                            .padding(.leading) // Add leading padding to align with the rest of the content

                        HStack {
                            // Image for the icon on the left
                            Image(systemName: "lightbulb.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the size of the icon
                                .foregroundColor(.blue) // Change color of the icon
                            
                            Text("測測看你的交友安全意識")
                                .font(.subheadline)
                                .foregroundColor(.gray) // Subtitle text color

                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(25) // Padding around the HStack content
                        .background(Color(red: 240/255, green: 250/255, blue: 255/255)) // Light blue background color
                        .cornerRadius(15) // Rounded corners
                        .shadow(radius: 1) // Add a slight shadow for depth
                        .padding(.horizontal, 16) // Add padding from the left and right screen edges
                    })
                    .padding(.bottom, 10) // Add bottom padding to the entire VStack
                }
                
                NavigationLink(destination: Text("安全須知")) {
                    VStack(alignment: .leading, content: {
                        Text("安全須知")
                            .font(.headline)
                            .foregroundColor(.black) // Title text color
                            .padding(.leading) // Add leading padding to align with the rest of the content

                        HStack {
                            // Image for the icon on the left
                            Image(systemName: "bell.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the size of the icon
                                .foregroundColor(.pink) // Change color of the icon

                            Text("溫馨提醒")
                                .font(.subheadline)
                                .foregroundColor(.gray) // Subtitle text color

                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.pink) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(25) // Padding around the HStack content
                        .background(Color(red: 255/255, green: 240/255, blue: 240/255)) // Light pink background color
                        .cornerRadius(15) // Rounded corners
                        .shadow(radius: 1) // Add a slight shadow for depth
                        .padding(.horizontal, 16) // Add padding from the left and right screen edges
                    })
                    .padding(.bottom, 10) // Add bottom padding to the entire VStack
                }
                
                NavigationLink(destination: Text("反詐騙中心")) {
                    VStack(alignment: .leading, content: {
                        Text("反詐騙中心")
                            .font(.headline)
                            .foregroundColor(.black) // Title text color
                            .padding(.leading) // Add leading padding to align with the rest of the content

                        HStack {
                            // Image for the icon on the left
                            Image(systemName: "shield.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the size of the icon
                                .foregroundColor(.green) // Change color of the icon

                            Text("提升反詐騙意識")
                                .font(.subheadline)
                                .foregroundColor(.gray) // Subtitle text color

                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.green) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(25) // Padding around the HStack content
                        .background(Color(red: 240/255, green: 255/255, blue: 240/255)) // Light green background color
                        .cornerRadius(15) // Rounded corners
                        .shadow(radius: 1) // Add a slight shadow for depth
                        .padding(.horizontal, 16) // Add padding from the left and right screen edges
                    })
                    .padding(.bottom, 10) // Add bottom padding to the entire VStack
                }
                
                NavigationLink(destination: Text("安全及認證")) {
                    VStack(alignment: .leading, content: {
                        Text("安全及認證")
                            .font(.headline)
                            .foregroundColor(.black) // Title text color
                            .padding(.leading) // Add leading padding to align with the rest of the content

                        HStack {
                            // Image for the icon on the left
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 50, height: 50) // Adjust the size of the icon
                                .foregroundColor(.blue) // Change color of the icon
                            
                            Text("真人認證")
                                .font(.subheadline)
                                .foregroundColor(.gray) // Subtitle text color

                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(25) // Padding around the HStack content
                        .background(Color(red: 240/255, green: 250/255, blue: 255/255)) // Light blue background color
                        .cornerRadius(15) // Rounded corners
                        .shadow(radius: 1) // Add a slight shadow for depth
                        .padding(.horizontal, 16) // Add padding from the left and right screen edges
                    })
                    .padding(.bottom, 10) // Add bottom padding to the entire VStack
                }
                
                VStack {
                    // 檢舉
                    Section(header: Text("檢舉")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading) // Set alignment to leading
                                .padding(.leading, 16)) {
                        NavigationLink(destination: Text("什麼情況下應該檢舉")) {
                            Text("什麼情況下應該檢舉")
                                .foregroundColor(.gray) // Set the text color to gray
                            
                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 255/255, green: 255/255, blue: 200/255)) // Light yellow background color
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        .padding(.horizontal, 16)

                        NavigationLink(destination: Text("如何檢舉")) {
                            Text("如何檢舉")
                                .foregroundColor(.gray) // Set the text color to gray
                            
                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 255/255, green: 255/255, blue: 200/255)) // Light yellow background color
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        .padding(.horizontal, 16)
                                    
                        NavigationLink(destination: Text("檢舉後會發生什麼？")) {
                            Text("檢舉後會發生什麼？")
                                .foregroundColor(.gray) // Set the text color to gray
                            
                            Spacer() // Pushes everything to the left

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray) // Arrow color
                                .padding(.trailing, 10)
                        }
                        .padding(35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 255/255, green: 255/255, blue: 200/255)) // Light yellow background color
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 10) // Section bottom padding
                }
                .padding(.bottom, 20) // This padding will work for the whole VStack

                Spacer()
                
                NavigationLink(destination: Text("相約見面")) {
                    VStack(alignment: .leading, content: {
                        Text("相約見面")
                            .font(.headline)
                            .foregroundColor(.black) // Title text color
                            .padding(.leading) // Add leading padding to align with the rest of the content
                        
                        HStack {
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.cyan)

                            Text("相約見面")
                                .padding()
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                        .padding(25)
                        .background(Color(red: 255/255, green: 240/255, blue: 240/255)) // Light pink background color
                        .cornerRadius(15)
                        .shadow(radius: 1)
                        .padding(.horizontal, 16)
                    })
                }
            }
            .navigationBarTitle("安全中心", displayMode: .inline)
        }
    }
}

struct SafetyCenterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SafetyCenterView() // Adding the view inside NavigationView for the preview
        }
    }
}
