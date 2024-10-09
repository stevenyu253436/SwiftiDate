//
//  UserGuideView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/9/21.
//

import Foundation
//
//  UserGuideView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct UserGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("歡迎來到 SwiftiDate！在這裡，使用「讚美」與「超級喜歡」的功能，就好比在現實生活中向女生搭訕，表達您的興趣和好感。在這份指南中，我們將引導您如何運用這些功能，讓您能更自然地向心儀的對象搭訕，並增加互動機會。")
                    .padding(.bottom)

                Group {
                    Text("1. 了解「讚美」與「超級喜歡」的搭訕技巧")
                        .font(.headline)
                    
                    Text("• 讚美：").bold() + Text("就像您在街上看到一位吸引您的女生，鼓起勇氣向她說「妳好，我覺得妳很有魅力」，這樣的動作。按下「讚美」讓對方知道您對她有興趣，是開啟對話的第一步。當對方也對您表示讚美，這就像她對您的搭訕回應了微笑，意味著您們有進一步認識的機會。")

                    Text("• 超級喜歡：").bold() + Text("就像是您遇到一個非常吸引您的女生，迫不及待地想要引起她的注意，您直接上前說：「我覺得妳真的是我見過最美的人。」按下「超級喜歡」就是這樣的強烈表達方式，能讓對方立刻知道您對她的高度興趣，但記得這是一種特別的搭訕方式，請謹慎使用。")
                }
                .padding(.bottom)

                Group {
                    Text("2. 如何有效地搭訕並使用「讚美」功能")
                        .font(.headline)
                    
                    Text("• 仔細觀察對方：").bold() + Text("就像在現實中搭訕前，您會觀察對方的舉止、穿著與氣質，來判斷是否適合交談。使用 SwiftiDate 時，請仔細閱讀對方的個人資料，了解她的興趣和喜好，這樣您能更準確地選擇想要搭訕的對象。")

                    Text("• 尋找共同點：").bold() + Text("如果您在資料中發現她有著與您相似的興趣，例如都喜歡旅行，這就是一個很好的搭訕話題！按下「讚美」時，表示您們有共同點，讓搭訕更容易成功。")

                    Text("• 適度讚美，避免過度：").bold() + Text("現實中，頻繁搭訕會被認為不真誠。同樣地，在 SwiftiDate 上，過度地向每個人按讚美，可能會讓您的興趣顯得膚淺。請選擇您真正有興趣的人來讚美，這樣才能吸引到真正適合您的對象。")
                }
                .padding(.bottom)

                Group {
                    Text("3. 有效運用「超級喜歡」的搭訕技巧")
                        .font(.headline)
                    
                    Text("• 謹慎選擇對象：").bold() + Text("「超級喜歡」就像是大膽地向心儀的女生表達您的強烈興趣。每天可以使用的次數有限，請務必在確定她是您真正想認識的人後，再使用這個功能。對那些個人資料豐富且和您有共同興趣的對象使用，效果最好。")

                    Text("• 把握好時機：").bold() + Text("在搭訕的時候，時機很重要。當您感覺她的個性、興趣與您非常契合，或是她的特質正是您在尋找的，這時按下「超級喜歡」，就能引起她的注意，增加成功的機率。")

                    Text("• 展現真誠與獨特性：").bold() + Text("與其泛泛而談，讓對方感受到您的真心更重要。搭訕成功後，請說出對方個人簡介中的特點，表達您對她的興趣，這樣她才會覺得您與其他人不同。")
                }
                .padding(.bottom)

                Group {
                    Text("4. 完善自己的「搭訕形象」：提升讚美與超級喜歡的效果")
                        .font(.headline)
                    
                    Text("• 選擇好照片：").bold() + Text("第一印象很重要！展示自己最佳狀態的照片，就像在搭訕時穿著得體。讓對方看到您的多面性，例如愛好、興趣等，增加吸引力。")

                    Text("• 精心撰寫個人簡介：").bold() + Text("就像在搭訕時，簡單有趣地介紹自己，個人簡介是讓對方快速了解您的機會。請真誠地描述自己的興趣與生活，這樣才更有機會吸引到對方。")
                }
                .padding(.bottom)

                // You can continue to add other sections in a similar way
                Group {
                    Text("5. 主動與對方互動，讓搭訕更有效")
                        .font(.headline)
                    
                    Text("• 迅速回應：").bold() + Text("在現實中，搭訕後若對方回應，您也應該快速地接續對話。同樣地，在 SwiftiDate 上，當配對成功後，主動開啟聊天，讓對方知道您對她有興趣。")

                    Text("• 保持尊重與幽默：").bold() + Text("幽默感是搭訕的好工具，但也要尊重對方的界限。避免問太私人或敏感的問題，先從對方的興趣開始，讓對話自然展開。")

                    Text("• 利用對方興趣展開話題：").bold() + Text("對方的興趣是您搭訕的最佳起點，根據她的興趣提出問題或分享經驗，會讓她感受到您的真誠，並且增加對話的趣味性。")
                }
                .padding(.bottom)

                Group {
                    Text("6. 如何應對不合適的對象")
                        .font(.headline)
                    
                    Text("• 尊重對方的選擇：").bold() + Text("就像現實中的搭訕，對方可能對您不感興趣，這時候尊重對方是最重要的。若對方沒有進一步互動的意願，請禮貌地結束對話。")

                    Text("• 繼續尋找適合您的對象：").bold() + Text("如果感覺不對，那就不要浪費時間，專注尋找下一個更適合您的對象。這樣才更容易找到真正心儀的人。")
                }
                .padding(.bottom)

                Group {
                    Text("7. 使用 SwiftiDate 的其他搭訕技巧")
                        .font(.headline)
                    
                    Text("• 經常更新資料：").bold() + Text("隨時保持最新狀態，讓對方看到您的生活動態，這樣可以引起更多人的興趣。")

                    Text("• 參加活動或話題：").bold() + Text("SwiftiDate 會定期推出各種活動或話題，參加這些活動，能讓更多人注意到您，並增加搭訕的機會。")

                    Text("• 保持耐心：").bold() + Text("就像在現實生活中找到合適的對象需要時間，請耐心等待，找到適合您的對象。")
                }
                .padding(.bottom)

                Group {
                    Text("8. 最後的建議")
                        .font(.headline)
                    
                    Text("• 真誠與誠實：").bold() + Text("搭訕的過程中，真誠是最有力量的。請如實地展示自己，這樣才有機會遇到真正欣賞您的對象。")

                    Text("• 大膽嘗試不同搭訕方式：").bold() + Text("不同的對象可能需要不同的搭訕方式，請大膽嘗試，並找到最適合自己的方法。")
                }
                .padding(.bottom)
                
                // 新增關於 ChatGPT 回訊息功能的段落
                Group {
                    Text("9. 使用 ChatGPT 來回應訊息")
                        .font(.headline)
                    
                    Text("SwiftiDate 目前整合了 ChatGPT 功能，您可以在對話中使用 ChatGPT 來生成回應。這個功能非常適合在您不知道該如何回應時，讓 ChatGPT 提供一些建議性的對話回應。")
                        .padding(.bottom)
                    
                    Text("目前，ChatGPT 提供的回應是基於最一般化的對話邏輯，能夠幫助您在各種情境下進行基本的溝通。隨著技術的發展，我們正在開發一個專門針對人性化對話的客製化 LLM 模型。未來，這個模型將能更好地理解您與對象之間的情感互動，提供更加個性化的回應，讓溝通變得更加真實和自然。")
                        .padding(.bottom)
                    
                    Text("我們相信，這樣的功能將會大大提升用戶的互動體驗，幫助您在 SwiftiDate 上建立更有深度的連結。")
                }
                .padding(.bottom)

                // Continue with other sections or conclusion...
                Group {
                    Text("結語")
                        .font(.headline)
                    
                    Text("SwiftiDate 就像是一個提供給您搭訕的舞台，讓您有機會結識更多優質的對象。希望您在運用「讚美」和「超級喜歡」時，能像現實中勇敢搭訕那樣，找到屬於自己的幸福。")
                }
            }
            .padding()
        }
        .navigationTitle("使用說明")
    }
}

struct UserGuideView_Previews: PreviewProvider {
    static var previews: some View {
        UserGuideView()
    }
}
