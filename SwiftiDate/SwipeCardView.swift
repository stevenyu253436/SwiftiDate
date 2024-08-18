//
//  SwipeCardView.swift
//  SwiftiDate
//
//  Created by 游哲維 on 2024/8/18.
//

import SwiftUI

struct SwipeCardView: View {
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(radius: 5)
            VStack {
                Image("profile_picture_others")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Text("後照鏡被偷, 20")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("雙魚座 · 桃園市 · 172 cm")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .frame(width: 350, height: 500)
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { _ in
                    if self.offset.width > 100 {
                        // 右滑動
                        print("Like")
                    } else if self.offset.width < -100 {
                        // 左滑動
                        print("Dislike")
                    } else {
                        // 恢復原位
                        self.offset = .zero
                    }
                }
        )
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeCardView()
            .previewLayout(.sizeThatFits) // 可选，适应预览视图的大小
    }
}
