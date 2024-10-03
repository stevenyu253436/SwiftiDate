//
//  PersonalInfoView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/3.
//

import SwiftUI

struct PersonalInfoView: View {
    @Binding var isPersonalInfoView: Bool // Binding variable to control the view dismissal
    @State private var userName: String = "玩玩" // Replace with your actual data
    @State private var userBirthday: String = "1999/07/02" // Replace with your actual data

    var body: some View {
        VStack {
            // Custom Navigation Bar
            HStack {
                Button(action: {
                    isPersonalInfoView = false // Dismiss the view when back is tapped
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("個人資料")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                // Optional placeholder for right-side content, if needed
                Spacer().frame(width: 44) // To balance the chevron size
            }
            .padding()
            
            Divider()

            // List with personal info
            List {
                HStack {
                    Text("姓名")
                    Spacer()
                    Text(userName)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 10)

                HStack {
                    Text("生日")
                    Spacer()
                    Text(userBirthday)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 10)
            }
            .listStyle(GroupedListStyle()) // Optional: Set the list style to match the look
        }
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    @State static var isPersonalInfoView = true

    static var previews: some View {
        PersonalInfoView(isPersonalInfoView: $isPersonalInfoView)
    }
}
