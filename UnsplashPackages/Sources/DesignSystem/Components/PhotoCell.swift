//
//  PhotoCell.swift
//
//
//  Created by Yassin El Mouden on 17/03/2024.
//

import Localizable
import SDWebImageSwiftUI
import SwiftUI

public struct PhotoCell: View {
    let urlPhoto: String
    let userName: String
    let urlUserProfile: String
    let nbLikes: Int

    @State private var animatedNumber: Int = 0

    public init(
        urlPhoto: String,
        userName: String,
        urlUserProfile: String,
        nbLikes: Int
    ) {
        self.urlPhoto = urlPhoto
        self.userName = userName
        self.urlUserProfile = urlUserProfile
        self.nbLikes = nbLikes
    }

    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: urlPhoto) {
                WebImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .clipped()

                } placeholder: {
                    Color.clear
                        .frame(height: 350)
                }
            }

            VStack(alignment: .leading) {
                HStack {
                    WebImage(url: URL(string: urlUserProfile)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .transition(.slide)

                    } placeholder: {
                        Color.clear
                            .frame(width: 32, height: 32)
                    }

                    Text("\(userName)")
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(DSColors.whiteText.swiftUIColor)

                    Spacer()
                }
                .padding([.top, .leading, .trailing], Margins.small)

                HStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                    Text("\(.localizable.homeLikeTitle(animatedNumber))")
                        .contentTransition(.numericText())
                        .font(.footnote)
                        .bold()
                        .foregroundStyle(DSColors.whiteText.swiftUIColor)
                }
                .padding([.bottom, .leading, .trailing], Margins.small)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.6))
        }
        .frame(height: 350)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.small)
            .stroke(Color.gray, lineWidth: 1)
        )
        .background(Color.black)
        .cornerRadius(8)
        .padding([.leading, .trailing], CornerRadius.small)
        .scrollTransition { content, phase in
            content
                .blur(radius: phase.value > -1 ? 0 : 3)
        }
        .onAppear {
            withAnimation(.easeInOut.delay(0.3)) {
                animatedNumber = nbLikes
            }
        }
    }
}

#Preview {
    PhotoCell(
        urlPhoto: "",
        userName: "",
        urlUserProfile: "",
        nbLikes: 10
    )
}
