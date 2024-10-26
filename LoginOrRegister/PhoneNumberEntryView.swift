//
//  PhoneNumberEntryView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/10/4.
//

import Foundation
import SwiftUI

struct PhoneNumberEntryView: View {
    @Binding var isRegistering: Bool // Binding variable to control view navigation
    @State private var isShowingCountryCodePicker = false
    @State private var selectedCountryCode: String = "+886" // 預設為台灣國碼
    @State private var phoneNumber: String = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Handle Back Action (Pop to previous view)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black.opacity(0.7)) // 設置文字顏色為黑色
                        .padding(.leading)
                }
                Spacer()
            }
            .padding(.top)
            
            Text("你的手機號碼是？")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            Text("註冊或登錄需要輸入你的手機號碼")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            HStack {
                Button(action: {
                    isShowingCountryCodePicker.toggle() // 點擊顯示國碼選擇器
                }) {
                    HStack {
                        Text(selectedCountryCode) // 顯示選中的國碼
                            .font(.title2)
                            .foregroundColor(.black) // 設置文字顏色為黑色
                        Image(systemName: "chevron.down") // 向下箭頭圖示
                            .font(.system(size: 16))
                            .foregroundColor(.gray.opacity(0.7)) // 設置圖示顏色為黑色
                    }
                    .font(.title2)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                TextField("", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .font(.title2)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "phone")
                    .foregroundColor(.gray) // You can change the color to your preference
                Text("請確認你的手機號碼為目前正在使用的手機號碼！")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "umbrella.fill")
                Text("我們不會將該資訊分享給任何人，你的手機號碼也不會出現在你的個人首頁")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            Button(action: {
                // Handle Continue Action
            }) {
                Text("繼續")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(25)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .fullScreenCover(isPresented: $isShowingCountryCodePicker) {
            CountryCodePickerView(selectedCountryCode: $selectedCountryCode)
        }
    }
}

struct CountryCodePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCountryCode: String
    
    let countries = [
        ("台灣", "+886"),
        ("馬來西亞", "+60"),
        ("泰國", "+66"),
        ("印尼", "+62"),
        ("香港", "+852"),
        ("日本", "+81"),
        ("南韓", "+82"),
        ("英國", "+44"),
        ("美國", "+1"),
        ("法國", "+33"),
        ("阿富汗", "+93"),
        ("奧蘭群島", "+358"),
        ("阿爾巴尼亞", "+355"),
        ("阿爾及利亞", "+213"),
        ("美屬薩摩亞", "+1684"),
        ("安道爾", "+376"),
        ("安哥拉", "+244"),
        ("安圭拉", "+1264"),
        ("安地卡及巴布達", "+1268"),
        ("阿根廷", "+54"),
        ("亞美尼亞", "+374"),
        ("荷屬阿魯巴", "+297"),
        ("澳洲", "+61"),
        ("奧地利", "+43"),
        ("亞塞拜然", "+994"),
        ("巴哈馬", "+1242"),
        ("巴林", "+973"),
        ("孟加拉", "+880"),
        ("巴貝多", "+1246"),
        ("白俄羅斯", "+375"),
        ("比利時", "+32"),
        ("貝里斯", "+501"),
        ("貝南", "+229"),
        ("百慕達", "+1441"),
        ("不丹", "+975"),
        ("玻利維亞", "+591"),
        ("波士尼亞與赫塞哥維納", "+387"),
        ("波札那", "+267"),
        ("巴西", "+55"),
        ("英屬印度洋領地", "+246"),
        ("汶萊", "+673"),
        ("保加利亞", "+359"),
        ("布吉納法索", "+226"),
        ("蒲隆地", "+257"),
        ("喀麥隆", "+237"),
        ("加拿大", "+1"),
        ("維德角", "+238"),
        ("開曼群島", "+1"),
        ("柬埔寨", "+855"),
        ("中非共和國", "+236"),
        ("查德", "+235"),
        ("智利", "+56"),
        ("中國", "+86"),
        ("聖誕島", "+61"),
        ("科科斯（基林）群島", "+61"),
        ("哥倫比亞", "+57"),
        ("葛摩", "+269"),
        ("剛果（布拉薩）", "+242"),
        ("剛果（金夏沙）", "+243"),
        ("庫克群島", "+682"),
        ("哥斯大黎加", "+506"),
        ("象牙海岸", "+225"),
        ("克羅埃西亞", "+385"),
        ("古巴", "+53"),
        ("賽普勒斯", "+357"),
        ("捷克", "+420"),
        ("丹麥", "+45"),
        ("吉布地", "+253"),
        ("多米尼克", "+1767"),
        ("多明尼加共和國", "+1849"),
        ("厄瓜多", "+593"),
        ("埃及", "+20"),
        ("薩爾瓦多", "+503"),
        ("赤道幾內亞", "+240"),
        ("厄利垂亞", "+291"),
        ("愛沙尼亞", "+372"),
        ("衣索比亞", "+251"),
        ("福克蘭群島", "+500"),
        ("法羅群島", "+298"),
        ("斐濟", "+679"),
        ("芬蘭", "+358"),
        ("法屬圭亞那", "+594"),
        ("法屬玻里尼西亞", "+689"),
        ("加彭", "+241"),
        ("甘比亞", "+220"),
        ("喬治亞", "+995"),
        ("德國", "+49"),
        ("迦納", "+233"),
        ("直布羅陀", "+350"),
        ("希臘", "+30"),
        ("格陵蘭", "+299"),
        ("格瑞那達", "+1473"),
        ("瓜地洛普", "+590"),
        ("關島", "+1671"),
        ("瓜地馬拉", "+502"),
        ("根息", "+44"),
        ("幾內亞", "+224"),
        ("幾內亞比索", "+245"),
        ("蓋亞那", "+592"),
        ("海地", "+509"),
        ("梵蒂岡", "+39"),
        ("宏都拉斯", "+504"),
        ("匈牙利", "+36"),
        ("冰島", "+354"),
        ("印度", "+91"),
        ("伊朗", "+98"),
        ("伊拉克", "+964"),
        ("愛爾蘭", "+353"),
        ("曼島", "+44"),
        ("以色列", "+972"),
        ("義大利", "+39"),
        ("牙買加", "+1876"),
        ("澤西島", "+44"),
        ("約旦", "+962"),
        ("哈薩克", "+7"),
        ("肯亞", "+254"),
        ("吉里巴斯", "+686"),
        ("北韓", "+850"),
        ("科威特", "+965"),
        ("吉爾吉斯", "+996"),
        ("寮國", "+856"),
        ("拉脫維亞", "+371"),
        ("黎巴嫩", "+961"),
        ("賴索托", "+266"),
        ("賴比瑞亞", "+231"),
        ("利比亞", "+218"),
        ("列支敦斯登", "+423"),
        ("立陶宛", "+370"),
        ("盧森堡", "+352"),
        ("澳門", "+853"),
        ("馬其頓", "+389"),
        ("緬甸", "+95"),
        ("馬達加斯加", "+261"),
        ("馬拉威", "+265"),
        ("馬爾地夫", "+960"),
        ("馬利", "+223"),
        ("馬爾他", "+356"),
        ("馬紹爾群島", "+692"),
        ("馬丁尼克島", "+596"),
        ("茅利塔尼亞", "+222"),
        ("模里西斯", "+230"),
        ("馬約特", "+262"),
        ("墨西哥", "+52"),
        ("密克羅尼西亞群島", "+691"),
        ("摩爾多瓦", "+373"),
        ("摩納哥", "+377"),
        ("蒙古", "+976"),
        ("蒙特內哥羅", "+382"),
        ("蒙哲臘", "+1664"),
        ("摩洛哥", "+212"),
        ("莫三比克", "+258"),
        ("納米比亞", "+264"),
        ("諾魯", "+674"),
        ("尼泊爾", "+977"),
        ("荷蘭", "+31"),
        ("新喀里多尼亞", "+687"),
        ("紐西蘭", "+64"),
        ("尼加拉瓜", "+505"),
        ("尼日", "+227"),
        ("奈及利亞", "+234"),
        ("紐埃島", "+683"),
        ("諾福克島", "+672"),
        ("北馬里亞納群島", "+1670"),
        ("挪威", "+47"),
        ("阿曼王國", "+968"),
        ("巴基斯坦", "+92"),
        ("帛琉", "+680"),
        ("巴勒斯坦自治區", "+970"),
        ("巴拿馬", "+507"),
        ("巴布亞紐幾內亞", "+675"),
        ("巴拉圭", "+595"),
        ("秘魯", "+51"),
        ("菲律賓", "+63"),
        ("波蘭", "+48"),
        ("葡萄牙", "+351"),
        ("波多黎各", "+1939"),
        ("卡達", "+974"),
        ("羅馬尼亞", "+40"),
        ("俄羅斯", "+7"),
        ("盧安達", "+250"),
        ("留尼旺", "+262"),
        ("聖巴瑟米", "+590"),
        ("聖赫勒拿島", "+290"),
        ("聖克里斯多福及尼維斯", "+1869"),
        ("聖露西亞", "+1758"),
        ("法屬聖馬丁", "+590"),
        ("聖皮埃爾和密克隆群島", "+508"),
        ("聖文森及格瑞那丁", "+1784"),
        ("薩摩亞", "+685"),
        ("聖馬利諾", "+378"),
        ("聖多美普林西比", "+239"),
        ("沙烏地阿拉伯", "+966"),
        ("塞內加爾", "+221"),
        ("塞爾維亞", "+381"),
        ("塞席爾", "+248"),
        ("獅子山", "+232"),
        ("新加坡", "+65"),
        ("斯洛伐克", "+421"),
        ("斯洛維尼亞", "+386"),
        ("索羅門群島", "+677"),
        ("索馬利亞", "+252"),
        ("南非", "+27"),
        ("南蘇丹", "+211"),
        ("西班牙", "+34"),
        ("斯里蘭卡", "+94"),
        ("蘇丹", "+249"),
        ("蘇利南", "+597"),
        ("冷岸及央棉", "+47"),
        ("史瓦濟蘭", "+268"),
        ("瑞典", "+46"),
        ("瑞士", "+41"),
        ("敘利亞", "+963"),
        ("塔吉克", "+992"),
        ("坦尚尼亞", "+255"),
        ("東帝汶", "+670"),
        ("多哥", "+228"),
        ("托克勞群島", "+690"),
        ("東加", "+676"),
        ("千里達及托巴哥", "+1868"),
        ("突尼西亞", "+216"),
        ("土耳其", "+90"),
        ("土庫曼", "+993"),
        ("土克斯及開科斯群島", "+1649"),
        ("吐瓦魯", "+688"),
        ("烏干達", "+256"),
        ("烏克蘭", "+380"),
        ("阿拉伯聯合大公國", "+971"),
        ("烏拉圭", "+598"),
        ("烏茲別克", "+998"),
        ("萬那杜", "+678"),
        ("委內瑞拉", "+58"),
        ("越南", "+84"),
        ("英屬維京群島", "+1284"),
        ("美屬維京群島", "+1340"),
        ("瓦歷斯群島和富國那群島", "+681"),
        ("葉門", "+967"),
        ("尚比亞", "+260"),
        ("辛巴威", "+263"),
    ] // 國家名稱和國碼的列表

    var body: some View {
        VStack {
            // 顯示左上角的返回按鈕
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // 返回上一頁
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.gray.opacity(0.6))
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top)

            List(countries, id: \.1) { country, code in
                Button(action: {
                    selectedCountryCode = code // 更新選中的國碼
                    presentationMode.wrappedValue.dismiss() // 關閉選擇器
                }) {
                    HStack {
                        // 加上國旗圖標，假設圖標名稱和國家名稱相匹配
                        if let flagImage = UIImage(named: country.lowercased()) {
                            Image(uiImage: flagImage)
                                .resizable()
                                .frame(width: 30, height: 20) // 根據需要調整大小
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        } else {
                            // 如果沒有對應的國旗圖標，顯示占位符號
                            Image(systemName: "flag.fill")
                                .resizable()
                                .frame(width: 30, height: 20)
                                .foregroundColor(.gray)
                        }
                        
                        Text(country)
                            .font(.title2)
                            .foregroundColor(.black)
                        Spacer()
                        Text(code)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .listStyle(GroupedListStyle()) // 設定 GroupedListStyle
        }
    }
}

struct PhoneNumberEntryView_Previews: PreviewProvider {
    @State static var isRegistering = true
    
    static var previews: some View {
        PhoneNumberEntryView(isRegistering: $isRegistering)
            .previewDevice("iPhone 15 Pro")
    }
}