//
//  LifestyleView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/16.
//

import Foundation
import SwiftUI

struct LifestyleView: View {
    @Binding var selectedLookingFor: String?
    @Binding var showLookingForView: Bool
    @Binding var selectedPet: String?
    @Binding var showPetSelectionView: Bool
    @Binding var selectedFitnessOption: String?
    @Binding var showFitnessOptions: Bool
    @Binding var selectedSmokingOption: String?
    @Binding var showSmokingOptions: Bool
    @Binding var selectedDrinkOption: String?
    @Binding var showDrinkOptions: Bool
    @Binding var selectedVacationOption: String?
    @Binding var showVacationOptions: Bool
    @Binding var selectedDietPreference: String?
    @Binding var showDietPreferences: Bool
    
    var body: some View {
        // 生活方式
        VStack(alignment: .leading) {
            Text("生活方式")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                Text("想找")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let lookingFor = selectedLookingFor {
                    Text(lookingFor)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showLookingForView = true
            }
            .sheet(isPresented: $showLookingForView) {
                LookingForView(selectedLookingFor: $selectedLookingFor)
            }
            
            HStack {
                Image(systemName: "pawprint")
                    .foregroundColor(.gray)
                Text("寵物")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let pet = selectedPet {
                    Text(pet)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showPetSelectionView = true
            }
            .sheet(isPresented: $showPetSelectionView) {
                PetSelectionView(selectedPet: $selectedPet)
            }
            
            HStack {
                Image(systemName: "dumbbell")
                    .foregroundColor(.gray)
                Text("健身")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let option = selectedFitnessOption {
                    Text(option)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showFitnessOptions = true
            }
            .sheet(isPresented: $showFitnessOptions) {
                FitnessOptionsView(selectedFitnessOption: $selectedFitnessOption)
            }
            
            HStack {
                Image("smoking")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24) // 调整大小以适应你的设计
                Text("抽煙")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let option = selectedSmokingOption {
                    Text(option)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showSmokingOptions = true
            }
            .sheet(isPresented: $showSmokingOptions) {
                SmokingOptionsView(selectedSmokingOption: $selectedSmokingOption)
            }
            
            HStack {
                Image(systemName: "wineglass.fill")
                    .foregroundColor(.gray)
                Text("喝酒")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let option = selectedDrinkOption {
                    Text(option)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showDrinkOptions = true
            }
            .sheet(isPresented: $showDrinkOptions) {
                DrinkOptionsView(selectedDrinkOption: $selectedDrinkOption)
            }
            
            HStack {
                Image(systemName: "tree.fill")
                    .foregroundColor(.gray)
                Text("休假日")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let option = selectedVacationOption {
                    Text(option)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showVacationOptions = true
            }
            .sheet(isPresented: $showVacationOptions) {
                VacationOptionsView(selectedVacationOption: $selectedVacationOption)
            }
            
            HStack {
                Image(systemName: "fork.knife")
                    .foregroundColor(.gray)
                Text("飲食習慣")
                    .font(.headline)
                    .padding(.bottom, 5)
                Spacer()
                if let option = selectedDietPreference {
                    Text(option)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("新增")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                Image(systemName: "chevron.right") // 添加向右的箭头
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                showDietPreferences = true
            }
            .sheet(isPresented: $showDietPreferences) {
                DietPreferencesView(selectedDietPreference: $selectedDietPreference)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct LifestyleView_Previews: PreviewProvider {
    @State static var selectedLookingFor: String? = "穩定的關係"
    @State static var showLookingForView = false
    @State static var selectedPet: String? = "沒有寵物"
    @State static var showPetSelectionView = false
    @State static var selectedFitnessOption: String? = "經常健身"
    @State static var showFitnessOptions = false
    @State static var selectedSmokingOption: String? = "不抽煙"
    @State static var showSmokingOptions = false
    @State static var selectedDrinkOption: String? = "偶爾喝酒"
    @State static var showDrinkOptions = false
    @State static var selectedVacationOption: String? = "時間自己掌控"
    @State static var showVacationOptions = false
    @State static var selectedDietPreference: String? = "其他飲食偏好"
    @State static var showDietPreferences = false
    
    static var previews: some View {
        LifestyleView(
            selectedLookingFor: $selectedLookingFor,
            showLookingForView: $showLookingForView,
            selectedPet: $selectedPet,
            showPetSelectionView: $showPetSelectionView,
            selectedFitnessOption: $selectedFitnessOption,
            showFitnessOptions: $showFitnessOptions,
            selectedSmokingOption: $selectedSmokingOption,
            showSmokingOptions: $showSmokingOptions,
            selectedDrinkOption: $selectedDrinkOption,
            showDrinkOptions: $showDrinkOptions,
            selectedVacationOption: $selectedVacationOption,
            showVacationOptions: $showVacationOptions,
            selectedDietPreference: $selectedDietPreference,
            showDietPreferences: $showDietPreferences
        )
    }
}
